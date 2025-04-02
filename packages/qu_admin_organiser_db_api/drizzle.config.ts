import { defineConfig } from "drizzle-kit";

export default defineConfig({
  dialect: "mysql",
  schema: "./lib/schemas/*Schema.ts",
  out: "./drizzle",
});
