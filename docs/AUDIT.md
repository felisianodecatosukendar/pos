# POS audit — 29 October 2026

Scope: local source, installed dependencies, Supabase catalog/advisors, and Vercel project/deployment/environment metadata. No website access or real checkout was performed.

## Applied database fixes

Migration: pos_restrict_table_privileges_and_inactive_reads.

- Revoked TRUNCATE, TRIGGER, REFERENCES from anon/authenticated on profiles, operating_expenses, receipt_settings.
- daily_openings and cashier_expenses now require an active staff account for owner reads; active admins retain access.
- Verification: zero excess grants remaining; both policy expressions confirmed in pg_policies. No business records deleted.
- SQL reference: database-hardening.sql.

## Local application fixes

- Desktop navigation includes start day, cashier expenses and daily closing.
- Business date advances in Asia/Jakarta while preserving explicitly selected historical dates.
- Account changes reset role, cart, receipt, admin account list, audit rows and payment confirmation.
- Profile requests ignore responses after effect cleanup; operational loads wait for an active profile.
- Checkout uses a synchronous in-flight lock, validates payment confirmation, and clears the cart before receipt fetching. This prevents another submission while the first checkout's receipt is loading. Server-side idempotency is still needed for safe retries after ambiguous network failures.
- Removed unused Google font downloads; CSS already uses Arial.
- Removed unused state and stabilized the audit-data callback.

## Verification

- ESLint passes. One narrowly scoped suppression documents an asynchronous external-data effect flagged by the set-state-in-effect rule.
- TypeScript passes.
- Database privilege and policy verification passes.
- Production deployment metadata is READY at commit 8f54ea7e020614f84dd7936826110b35cb93c9e1, GitHub main, felisianodecatosukendar/pos.
- Required Supabase environment variable names exist for production and preview; values were not decrypted.
- Local build cannot finish because sandbox policy blocks Turbopack's local port binding. Browser and authenticated end-to-end behavior remain untested.
- Database changes are live. Application deployment status is tracked by the GitHub commit and Vercel deployment metadata.

## Remaining findings

- Supabase leaked-password protection is disabled. Available MCP tools do not expose Auth configuration updates.
- Eight authenticated SECURITY DEFINER RPC warnings remain. Previously inspected bodies check active admin/staff authorization and use an empty search_path. Do not revoke these blindly: the POS relies on them.
- Earlier performance advisor reported 12 foreign keys without covering indexes, overlapping SELECT policies on operating_expenses, and three unused indexes. These are not yet remediated.
- Sales and report access is shared among active staff by existing policy. Confirm the desired business access model before narrowing it.
- Report metrics use different bounded datasets (200 sales, 500 expenses, 5000 items), so they are not an accounting period profit-and-loss report.
- Opening/closing histories are bounded. At larger account/transaction volumes, current-day status should use dedicated queries rather than searching recent history.
- Server-side checkout idempotency and authenticated role/concurrency regression tests remain necessary before claiming a comprehensive production audit.
