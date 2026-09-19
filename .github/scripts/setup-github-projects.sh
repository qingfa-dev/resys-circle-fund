#!/usr/bin/env bash
set -euo pipefail

OWNER="qingfa-dev"
REPO="qingfa-dev/resys-circle-fund"
TITLE="ReSys.CircleFund SDLC"
DESC="CircleFund delivery board — 5 iterations, 17 sprints, epics and lifecycle per docs/02-planning"
DATA="$(cd "$(dirname "$0")" && pwd)/project-data.tsv"
PHASE="${1:-all}"
PROJECT_NUM=""

log() { printf '%s\n' "$*" >&2; }

# ---------------------------------------------------------------- project ---

project_number() {
  gh api graphql \
    -f query='query($login:String!){user(login:$login){projectsV2(first:50){nodes{number title closed}}}}' \
    -F login="$OWNER" \
    | jq -r --arg t "$TITLE" \
        '.data.user.projectsV2.nodes[] | select(.title==$t and (.closed|not)) | .number' \
    | head -n1
}

project_node_id() {
  gh api graphql \
    -f query='query($login:String!){user(login:$login){projectsV2(first:50){nodes{number id title}}}}' \
    -F login="$OWNER" \
    | jq -r --arg n "$1" \
        '.data.user.projectsV2.nodes[] | select(.number == ($n|tonumber)) | .id' \
    | head -n1
}

ensure_project() {
  local num
  num="$(project_number)"
  if [[ -z "$num" ]]; then
    log "Creating project: $TITLE"
    gh project create --owner "$OWNER" --title "$TITLE" >/dev/null
    num="$(project_number)"
  else
    log "Project exists: #$num"
  fi
  gh project edit "$num" --owner "$OWNER" --description "$DESC" >/dev/null
  printf '%s' "$num"
}

link_repo() {
  local num="$1"
  if gh project link "$num" --owner "$OWNER" --repo "$REPO" >/dev/null 2>&1; then
    log "Linked $REPO to project #$num"
  else
    log "Link skipped (already linked or unsupported): #$num"
  fi
}

# ----------------------------------------------------------------- fields ---

field_id() {
  gh project field-list "$1" --owner "$OWNER" --format json \
    | jq -r --arg n "$2" '.fields[] | select(.name==$n) | .id' | head -n1
}

create_field() {
  local num="$1" name="$2" opts="$3"
  if [[ -n "$(field_id "$num" "$name")" ]]; then log "field exists: $name"; return; fi
  gh project field-create "$num" --owner "$OWNER" --name "$name" \
    --data-type SINGLE_SELECT --single-select-options "$opts" >/dev/null
  log "field created: $name"
}

ensure_fields() {
  local num="$1"
  create_field "$num" "Iteration" "Iteration 1,Iteration 2,Iteration 3,Iteration 4,Iteration 5"
  create_field "$num" "Sprint" "$(seq -f 'Sprint %g' 1 17 | paste -sd, -)"
  create_field "$num" "Epic" "$(awk -F'\t' '$1=="epic"{print $4" "$5}' "$DATA" | paste -sd, -)"
  create_field "$num" "Priority" "P0 Critical,P1 High,P2 Medium,P3 Low"
  create_field "$num" "Area" "Backend,Frontend,Infra,CI,Tests,Docs"
  create_field "$num" "Size" "XS,S,M,L,XL"
}

ensure_status() {
  local num="$1" fid
  fid="$(field_id "$num" "Status")"
  jq -n --arg fid "$fid" '{query:"mutation($input:UpdateProjectV2FieldInput!){updateProjectV2Field(input:$input){projectV2Field{... on ProjectV2SingleSelectField{id name}}}}",variables:{input:{fieldId:$fid,singleSelectOptions:[
    {name:"Backlog",color:"GRAY",description:"Not yet refined"},
    {name:"Refinement",color:"BLUE",description:"Being refined"},
    {name:"Ready",color:"PURPLE",description:"Meets Definition of Ready"},
    {name:"In Progress",color:"YELLOW",description:"Being implemented"},
    {name:"Code Review",color:"ORANGE",description:"Under review"},
    {name:"CI",color:"PINK",description:"Automated checks"},
    {name:"QA",color:"GREEN",description:"Quality assurance"},
    {name:"UAT",color:"GREEN",description:"User acceptance"},
    {name:"Done",color:"GREEN",description:"Meets Definition of Done"}
  ]}}}' | gh api graphql --input - >/dev/null
  log "status options set"
}

# ------------------------------------------------------------------ views ---

create_view() {
  local pid="$1" name="$2" layout="$3" filter="${4:-}"
  if gh api graphql \
       -f query='query($id:ID!){node(id:$id){... on ProjectV2{views(first:50){nodes{name}}}}}' \
       -F id="$pid" | jq -r '.data.node.views.nodes[].name' | grep -qxF "$name"; then
    log "view exists: $name"; return
  fi
  local body vid
  body="$(jq -n --arg pid "$pid" --arg name "$name" --arg layout "$layout" \
    '{query:"mutation($input:CreateProjectV2ViewInput!){createProjectV2View(input:$input){projectV2View{id name}}}",variables:{input:{projectId:$pid,name:$name,layout:$layout}}}')"
  vid="$(printf '%s' "$body" | gh api graphql --input - | jq -r '.data.createProjectV2View.projectV2View.id')"
  if [[ -n "$filter" ]]; then
    jq -n --arg vid "$vid" --arg filter "$filter" \
      '{query:"mutation($input:UpdateProjectV2ViewInput!){updateProjectV2View(input:$input){projectV2View{id name}}}",variables:{input:{viewId:$vid,filter:$filter}}}' \
      | gh api graphql --input - >/dev/null
  fi
  log "view created: $name"
}

ensure_views() {
  local pid; pid="$(project_node_id "$1")"
  create_view "$pid" "Board — Status"      BOARD_LAYOUT
  create_view "$pid" "Roadmap — Iteration" ROADMAP_LAYOUT
  create_view "$pid" "Backlog"             TABLE_LAYOUT "status:Backlog"
  create_view "$pid" "Current Sprint"      BOARD_LAYOUT 'sprint:"Sprint 1"'
  create_view "$pid" "By Epic"             TABLE_LAYOUT
}

# ----------------------------------------------------------------- labels ---

ensure_labels() {
  local cat val color desc name
  while IFS=$'\t' read -r kind cat val color desc; do
    [[ "$kind" == "label" ]] || continue
    if [[ "$cat" == "special" ]]; then name="$val"; else name="$cat:$val"; fi
    if gh label list --repo "$REPO" --limit 200 --json name \
         | jq -r '.[].name' | grep -qxF "$name"; then
      log "label exists: $name"; continue
    fi
    gh label create "$name" --repo "$REPO" --color "${color#\#}" --description "$desc" >/dev/null
    log "label created: $name"
  done < "$DATA"
}

# ------------------------------------------------------------- milestones ---

ensure_milestone() {
  local title="$1"
  if gh api "repos/$REPO/milestones?state=all&per_page=100" --jq '.[].title' | grep -qxF "$title"; then
    log "milestone exists: $title"; return
  fi
  gh api "repos/$REPO/milestones" -f title="$title" -f state=open >/dev/null
  log "milestone created: $title"
}

sprint_milestone() {
  awk -F'\t' -v s="$1" '$1=="sprint" && $2==s{print "Sprint "$2" — "$4}' "$DATA"
}

iteration_milestone() {
  awk -F'\t' -v i="$1" '$1=="iteration" && $2==i{print $4" "$3}' "$DATA"
}

ensure_milestones() {
  local kind num name rel iteration
  while IFS=$'\t' read -r kind num iteration name; do
    if [[ "$kind" == "sprint" ]]; then ensure_milestone "Sprint ${num} — ${name}"; fi
  done < "$DATA"
  while IFS=$'\t' read -r kind num name rel; do
    if [[ "$kind" == "iteration" ]]; then ensure_milestone "${rel} ${name}"; fi
  done < "$DATA"
}

# ------------------------------------------------------------------ seed ---

declare -A ISSUE_URLS
declare -A MS_NUM

load_issues() {
  local title url
  while IFS=$'\t' read -r title url; do ISSUE_URLS["$title"]="$url"; done < <(
    gh api --paginate "repos/$REPO/issues?state=all&per_page=100" \
      --jq '.[] | [.title, .html_url] | @tsv'
  )
}

load_milestones() {
  local t n
  while IFS=$'\t' read -r t n; do MS_NUM["$t"]="$n"; done < <(
    gh api "repos/$REPO/milestones?state=all&per_page=100" \
      --jq '.[] | [.title, .number] | @tsv'
  )
}

issue_url() { printf '%s' "${ISSUE_URLS[$1]:-}"; }

# Create an issue through the REST API (separate rate-limit pool from GraphQL).
create_issue_rest() {
  local title="$1" ms="$2" label="$3" body="$4"
  local args=(-f title="$title" -f body="$body")
  [[ -n "$label" ]] && args+=(-f "labels[]=$label")
  [[ -n "$ms" && -n "${MS_NUM[$ms]:-}" ]] && args+=(-F milestone="${MS_NUM[$ms]}")
  gh api "repos/$REPO/issues" -X POST "${args[@]}" --jq '.html_url'
}

ensure_issue() {
  local title="$1" ms="$2" labels="$3" body="$4" url
  url="$(issue_url "$title")"
  if [[ -z "$url" ]]; then
    if ! url="$(create_issue_rest "$title" "$ms" "$labels" "$body")"; then
      log "issue create FAILED: $title"
      return 1
    fi
    ISSUE_URLS["$title"]="$url"
    log "issue created: $title"
  fi
  printf '%s' "$url"
}

# Retry a GraphQL command with backoff (secondary rate limits are time-based).
gql_retry() {
  local attempt=1 delay=15
  until "$@"; do
    if [[ $attempt -ge 5 ]]; then return 1; fi
    log "retry $attempt in ${delay}s: $*"
    sleep "$delay"
    attempt=$((attempt + 1)); delay=$((delay + 20))
  done
}

add_item() {
  if [[ "${SKIP_PROJECT:-0}" == "1" ]]; then return 0; fi
  if ! gql_retry gh project item-add "$PROJECT_NUM" --owner "$OWNER" --url "$1" >/dev/null 2>&1; then
    log "add_item skipped: $1"
  fi
  sleep 1.0
}

set_field() {
  if [[ "${SKIP_PROJECT:-0}" == "1" ]]; then return 0; fi
  if ! gql_retry gh project item-edit "$PROJECT_NUM" --owner "$OWNER" --url "$1" \
       --field "$2" --value "$3" >/dev/null 2>&1; then
    log "field set skipped: $1 [$2=$3]"
  fi
  sleep 1.0
}

seed_issues() {
  local kind num name rel iteration sprint id url ms
  load_issues
  load_milestones
  while IFS=$'\t' read -r kind num name rel; do
    [[ "$kind" == "iteration" ]] || continue
    url="$(ensure_issue "[Iteration ${num}] ${name}" "${rel} ${name}" "type:task" \
      "Iteration tracking issue for ${rel} ${name}. Scope and sprints per docs/02-planning/iteration-plan.md.")"
    add_item "$url"; set_field "$url" "Iteration" "Iteration ${num}"
  done < "$DATA"
  while IFS=$'\t' read -r kind num iteration name; do
    [[ "$kind" == "sprint" ]] || continue
    ms="Sprint ${num} — ${name}"
    url="$(ensure_issue "[Sprint ${num}] ${name}" "$ms" "type:task" \
      "Sprint planning issue. See docs/02-planning/iteration-plan/0${iteration}-iteration-${iteration}.md.")"
    add_item "$url"; set_field "$url" "Iteration" "Iteration ${iteration}"; set_field "$url" "Sprint" "Sprint ${num}"
  done < "$DATA"
  while IFS=$'\t' read -r kind iteration sprint id name; do
    [[ "$kind" == "epic" ]] || continue
    if [[ "$iteration" == "0" ]]; then
      ms=""; url="$(ensure_issue "[Epic] ${id} — ${name}" "" "type:feature" \
        "Cross-cutting epic ${id} (${name}). Applies across all iterations.")"
    else
      ms="$(sprint_milestone "$sprint")"
      url="$(ensure_issue "[Epic] ${id} — ${name}" "$ms" "type:feature" \
        "Epic ${id} (${name}). Iteration ${iteration}; $(iteration_milestone "$iteration").")"
    fi
    add_item "$url"
    if [[ "$iteration" != "0" ]]; then set_field "$url" "Iteration" "Iteration ${iteration}"; fi
    set_field "$url" "Epic" "${id} ${name}"
  done < "$DATA"
}

# ------------------------------------------------------------------ main ---

case "$PHASE" in
  all)
    PROJECT_NUM="$(ensure_project)"; link_repo "$PROJECT_NUM"
    ensure_fields "$PROJECT_NUM"; ensure_status "$PROJECT_NUM"
    ensure_views "$PROJECT_NUM"; ensure_labels; ensure_milestones; seed_issues ;;
  project)    PROJECT_NUM="$(ensure_project)"; link_repo "$PROJECT_NUM" ;;
  fields)     PROJECT_NUM="$(ensure_project)"; ensure_fields "$PROJECT_NUM"; ensure_status "$PROJECT_NUM" ;;
  views)      PROJECT_NUM="$(ensure_project)"; ensure_views "$PROJECT_NUM" ;;
  labels)     ensure_labels ;;
  milestones) ensure_milestones ;;
  seed)       PROJECT_NUM="$(ensure_project)"; seed_issues ;;
  *) log "unknown phase: $PHASE"; exit 2 ;;
esac
log "phase done: $PHASE"
