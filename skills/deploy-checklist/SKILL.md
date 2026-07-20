---
name: deploy-checklist
description: Coordinate multi-service deployments safely. Use when deploying, releasing, shipping to production, or preparing a release across multiple services.
---

# Deploy Checklist

## Quick Start

Coordinate deployment across multiple services with pre/post validation. Prevents partial deploys and catches issues before users do.

## Determine Scope

What changed? This determines which services need deploying:

| Changed files | Service to deploy | Command |
|---------------|-------------------|---------|
| `app/`, `lib/`, `components/` | Web app (Next.js) | `yarn deploy:app` or Vercel auto-deploy |
| `services/lambda-pipeline/` | AWS Lambda | `yarn deploy:lambda` |
| `services/query-api/` | FastAPI service | Service-specific deploy |
| `supabase/migrations/` | Database | `yarn supabase:db:push:remote` |
| Multiple of the above | Multi-service | Deploy in dependency order (below) |

## Deployment Order

When multiple services change, deploy in this order:

```
1. Database migrations (schema must exist before code references it)
2. Lambda / backend services (process data with new schema)
3. Web app (UI references new API responses)
```

Never deploy UI changes that depend on API changes before deploying the API.

## Pre-Deploy Checklist

```
Pre-Deploy:
- [ ] All tests pass locally
- [ ] TypeScript compiles with no errors (`tsc --noEmit`)
- [ ] Lint passes
- [ ] Branch is up to date with main
- [ ] PR approved (if applicable)
- [ ] No pending migrations that haven't been pushed
- [ ] Environment variables added to production (if new ones)
- [ ] Feature flags set correctly (if applicable)
```

## Database Migration Deploy

```
Migration Deploy:
- [ ] Review migration SQL one more time
- [ ] Migration is additive/backward-compatible
- [ ] RLS policies included for new tables
- [ ] Run: `yarn supabase:db:push:remote`
- [ ] Verify: Check Supabase dashboard for new tables/columns
- [ ] Rollback plan: Have the reverse migration ready
```

**Critical:** If migration is destructive (drop column, rename), use expand/contract:
1. Deploy new column (expand)
2. Deploy code to write to both old + new
3. Backfill data
4. Deploy code to read from new only
5. Drop old column (contract)

## Lambda Deploy

```
Lambda Deploy:
- [ ] Test locally: `sam local invoke [FunctionName]`
- [ ] Run: `yarn deploy:lambda`
- [ ] Verify: Check CloudWatch for startup errors
- [ ] Verify: Send a test event (email/document)
- [ ] Monitor: Watch CloudWatch for 10 minutes
```

## Web App Deploy

```
Web App Deploy:
- [ ] Verify Vercel preview deployment works (if auto-deploy)
- [ ] Or run: `yarn deploy:app`
- [ ] Verify: Check production URL loads
- [ ] Verify: Test the changed feature end-to-end
- [ ] Monitor: Check Sentry for new errors
- [ ] Monitor: Check analytics for anomalies
```

## Post-Deploy Validation

```
Post-Deploy:
- [ ] Feature works in production (test manually)
- [ ] No new errors in Sentry
- [ ] No new errors in CloudWatch (if Lambda deployed)
- [ ] API response times normal
- [ ] No user-reported issues in first 30 minutes
```

## Rollback Plan

If something goes wrong:

| Service | Rollback method |
|---------|----------------|
| Web app | Revert in Vercel dashboard (instant) |
| Lambda | Redeploy previous version: `git checkout main && yarn deploy:lambda` |
| Database | Run reverse migration (if prepared) or restore from backup |

**Decision threshold:** Rollback immediately if:
- Error rate spikes >5x baseline
- Core functionality is broken (login, payments, email processing)
- Data integrity issue detected

## Release Tagging

After successful deploy:

```bash
# Web app release
git tag -a web-v1.X.Y -m "Brief description of changes"

# Lambda release
git tag -a lambda-v1.X.Y -m "Brief description of changes"

git push --tags
```

## Communication

- Notify team in Slack/channel before deploying
- Post deploy confirmation after validation passes
- If rollback needed, communicate immediately with scope of impact
