import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/ui',

  reporter: [['html', { outputFolder: './evidences/playwright-report', open: 'never' }]],
  

  outputDir: './evidences/test-results', 

  use: {
    
    video: 'on', 
    trace: 'on', 
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
});