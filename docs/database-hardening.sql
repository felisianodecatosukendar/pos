-- Applied via Supabase MCP migration pos_restrict_table_privileges_and_inactive_reads.
REVOKE TRUNCATE, REFERENCES, TRIGGER ON public.profiles, public.operating_expenses, public.receipt_settings FROM anon, authenticated;
ALTER POLICY opening_read ON public.daily_openings TO authenticated USING ((SELECT private.is_admin()) OR (cashier_id=(SELECT auth.uid()) AND (SELECT private.is_staff())));
ALTER POLICY expense_read ON public.cashier_expenses TO authenticated USING ((SELECT private.is_admin()) OR (cashier_id=(SELECT auth.uid()) AND (SELECT private.is_staff())));
