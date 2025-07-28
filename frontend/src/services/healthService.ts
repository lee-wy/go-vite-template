import { config } from "../config/config";

export interface HealthResponse {
  message: string;
}

export const healthService = {
  async checkHealth(): Promise<HealthResponse> {
    try {
      const response = await fetch(`${config.API_BASE_URL}/health`);

      if (response.ok) {
        const message = await response.text();
        return { message };
      } else {
        return { message: `HTTP ${response.status}` };
      }
    } catch (error) {
      return {
        message: error instanceof Error ? error.message : "Unknown error",
      };
    }
  },
};
