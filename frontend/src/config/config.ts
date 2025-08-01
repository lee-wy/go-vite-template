export const config = {
  API_BASE_URL: import.meta.env.VITE_API_BASE_URL || "http://localhost:8080",
} as const;

// Type for environment validation
export type Config = typeof config;
