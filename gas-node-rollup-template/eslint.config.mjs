// @ts-check

import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';

// Applies the different linting rules specifically to the src/ folder.
export default tseslint.config(
  {
    ...eslint.configs.recommended,
    files: ['src/**/*.{js,mjs,cjs,jsx,mjsx,ts,tsx,mtsx}']
  },
  ...tseslint.configs.recommended.map(config => ({ ...config, files: ['src/**/*.{js,mjs,cjs,jsx,mjsx,ts,tsx,mtsx}'] })),
  {
    files: ['src/**/*.{js,mjs,cjs,jsx,mjsx,ts,tsx,mtsx}'],
    "rules": {
      "@typescript-eslint/no-unused-vars": [
        "off",
        {
          "args": "all",
          "argsIgnorePattern": "^_",
          "caughtErrors": "all",
          "caughtErrorsIgnorePattern": "^_",
          "destructuredArrayIgnorePattern": "^_",
          "varsIgnorePattern": "^_",
          "ignoreRestSiblings": true
        }
      ],
      "@typescript-eslint/no-explicit-any": "warn",
      "no-case-declarations": "warn"
    }
  }
);