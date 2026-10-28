# PIYAMACX POS — Product Requirements Document

## Project
Mobile-first POS for Piyamacx women's sleepwear and fashion. Initial outlet: Summarecon Mall Bekasi. One owner/admin and one cashier/SPG. Browser on Android, Indonesian UI, IDR, Asia/Jakarta timezone.

## Architecture
Next.js TypeScript, Tailwind CSS, DaisyUI, Supabase Auth and PostgreSQL with Row Level Security, deployed on Vercel. Prefer free-tier infrastructure. Do not introduce unnecessary integrations or marketplace features.

## Permissions
**Admin:** dashboard, all sales, product CRUD, SKU, category, variant, price, stock adjustments with reasons, cashier management, reports and CSV exports, audited void/refund.
**Cashier:** login, browse active products, checkout, payment method, own sales history. Cannot edit prices, adjust stock, change user roles or view private admin reports.

## Core features
1. Authentication: email/password, individual users, role checks, logout, no public registration.
2. Catalog: SKU unique, name, category, variant, price, current stock, low-stock threshold, active status.
3. Checkout: searchable products, quantity changes, cart, discount, cash/QRIS/transfer, cash change, receipt confirmation.
4. Inventory: atomic decrement, prevent negative stock, audited stock adjustments.
5. Sales: unique receipt number, cashier, date/time, payment method, immutable line-item price snapshots, total, status.
6. Reports: date filter, daily totals, payment method breakdown, cashier, sales CSV, low-stock products.
7. Voids: admin-only, reason required, transaction and stock reversal recorded in audit log.

## Correctness and security
All public database tables must have RLS. Authorize using server-controlled role data, not editable user metadata. Checkout must use a single transactional database RPC: lock/check stock, calculate server-side prices, create sale and items, decrement stock and record movements. On error, roll back everything. Avoid exposing privileged Supabase keys. Configure NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY in Vercel.

## UI
Clean Piyamacx styling, touch-friendly buttons, quick product search, legible stock and totals, mobile-first layouts, clear validation and loading states.

## Deployment
GitHub: felisianodecatosukendar/pos. Vercel project: pos. Supabase ref: wvuhkkxnabqmawkdgers. Pin dependencies and commit lockfile, run database migrations and advisors, set environment variables, create initial admin securely, build and test before production.

## Acceptance
- Unauthenticated users cannot read sales or stock.
- Cashiers cannot edit catalog or stock.
- Concurrent checkout cannot oversell.
- Failed sale leaves no partial rows or stock changes.
- Completed sale decrements stock exactly once and creates a receipt.
- Void/adjustment is traceable.
- Reports match transaction records.
- Android browser workflow and Vercel build pass.
