import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Piyamacx POS",
  description: "Aplikasi kasir dan stok Piyamacx",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html
      lang="id"
      className="h-full antialiased"
    >
      <body className="min-h-full flex flex-col">{children}</body>
    </html>
  );
}
