# Administrator Guide — CircleFund

## Overview

This guide covers system administration tasks for CircleFund, including user management, configuration, monitoring, and maintenance.

## System Administration

### User Management

#### View All Users

1. Navigate to the admin panel
2. View the user list with:
   - Username/email
   - Account status (Active, Inactive)
   - Registration date
   - Last login
   - Roles and circle memberships

#### Manage User Accounts

For each user, administrators can:

- Activate/deactivate accounts
- Reset passwords
- Edit profile information
- View audit trail of user actions
- Manage roles and permissions

#### Roles and Permissions

| Role | Access Level |
|------|-------------|
| System Administrator | Full system access |
| Group Owner | Group-specific management |
| Circle Organizer | Circle-specific financial management |
| Treasurer | Financial viewing and recording |
| Secretary | Administrative tasks |
| Moderator | Content moderation |
| Member | Basic participation |
| Viewer | Read-only access |

### Circle Administration

#### Manage Circle Types

Configure system-wide circle type settings:

1. Navigate to Settings → Circle Types
2. For each type (Non-interest, Fixed Interest, Bidding):
   - Enable/disable the type
   - Configure default rules
   - Set validation parameters
3. Save changes

#### System-Wide Configuration

```text
Settings → System Configuration
├── Authentication
│   ├── Password policy (min length, complexity)
│   ├── Session timeout (minutes)
│   ├── Lockout policy (failed attempts)
│   └── Token expiry (minutes)
├── Notifications
│   ├── Email notifications (enable/disable)
│   ├── Reminder schedule (days before due)
│   └── Reminder template
├── Financial
│   ├── Default currency
│   ├── Rounding strategy
│   ├── Maximum transaction amount
│   └── Reconciliation frequency
└── System
    ├── Maintenance mode (on/off)
    ├── Public registration (on/off)
    └── Audit log retention (days)
```

## Monitoring

### System Health

1. Navigate to Admin → System Health
2. Review:
   - API status (healthy/degraded/down)
   - Database connection status
   - Active user count
   - Recent error count
   - System resource usage

### Log Review

#### Application Logs

1. Navigate to Admin → Logs
2. Filter by:
   - Date range
   - Log level (Error, Warning, Information)
   - User ID
   - Circle ID
   - Correlation ID
3. Review relevant log entries
4. Export logs if needed

#### Audit Trail

1. Navigate to Admin → Audit Trail
2. Filter by:
   - Date range
   - Actor (who performed the action)
   - Action type
   - Resource type
   - Circle ID
3. Review the audit history
4. Export for compliance purposes

### Error Monitoring

Key errors to watch for:

- Database connection failures
- Authentication failures (potential brute force)
- Financial operation failures
- Unhandled exceptions
- Slow query alerts
- Memory/disk warnings

## Maintenance

### Scheduled Maintenance

Plan maintenance during low-usage periods:

1. Notify users in advance
2. Enable maintenance mode
3. Perform maintenance tasks
4. Verify system functionality
5. Disable maintenance mode
6. Notify users maintenance complete

### Database Maintenance

#### Regular Tasks

```text
Daily:
- Verify backup completed successfully
- Check database size growth
- Review slow query logs

Weekly:
- Vacuum/analyze database tables
- Check for table bloat
- Review index usage
- Verify replication (if configured)

Monthly:
- Full database integrity check
- Performance review and optimization
- Cleanup old audit data (according to retention policy)
- Test backup restore procedure
```

#### Running Database Maintenance

```bash
# Via application
Admin → Maintenance → Run Database Maintenance

# Or manually (SSH into server)
docker compose exec db vacuumdb -U circlefund -d circlefund --analyze
docker compose exec db reindexdb -U circlefund -d circlefund
```

### Application Updates

#### Checking for Updates

1. Check for new releases (GitHub releases page)
2. Review release notes for breaking changes
3. Test in staging environment first
4. Plan production deployment

#### Update Procedure

```text
1. Read release notes
2. Test in staging
3. Backup production database
4. Schedule maintenance window
5. Enable maintenance mode
6. Deploy new version
7. Run database migrations
8. Verify functionality
9. Disable maintenance mode
10. Notify users
```

### Backup Management

1. Navigate to Admin → Backups
2. View backup history with dates and sizes
3. Create on-demand backup
4. Verify backup integrity
5. Configure backup schedule and retention
6. Test restore procedure (monthly)

## Security Administration

### Access Control

- Review user access regularly
- Deactivate inactive accounts after 90 days
- Enforce strong password policy
- Monitor failed login attempts
- Review role assignments quarterly

### Security Checks

- [ ] SSL certificate valid and not expiring
- [ ] All endpoints require authentication (except public)
- [ ] No known vulnerabilities in dependencies
- [ ] Database encrypted at rest
- [ ] Backups encrypted
- [ ] Rate limiting configured
- [ ] Audit logging active and monitored
- [ ] Security patches applied promptly

### Compliance

- [ ] Audit trail maintained and backed up
- [ ] Financial data retention policy implemented
- [ ] Data access logs maintained
- [ ] User consent recorded (if applicable)
- [ ] Data deletion process documented (GDPR/privacy requirements)
