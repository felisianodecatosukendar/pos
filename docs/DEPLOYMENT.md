# Deploy Piyamacx POS

1. Configure NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY in Vercel project pos for Production, Preview and Development.
2. Never commit Supabase service role key, database password or private tokens.
3. Run the SQL migration under supabase/migrations in the Supabase SQL editor.
4. Create staff accounts using Supabase Auth, then assign admin role with a trusted SQL editor.
5. Run npm install and npm run build; deploy from GitHub main.
