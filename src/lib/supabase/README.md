# Supabase connection

Install dependency: `npm install @supabase/supabase-js`

Copy `.env.example` to `.env.local`. The URL and publishable key are safe to expose in a browser, provided database RLS is configured correctly. Never commit `service_role` or `sb_secret_` keys. Configure server-only credentials in Vercel environment variables if required later.

Import the browser client from `@/lib/supabase/client`.
