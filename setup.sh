#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Function to check if a command exists
command_exists () {
    type "$1" &> /dev/null ;
}

# Verification function
verify_setup() {
    echo "Verifying setup..."
    
    # ... (rest of the verify_setup function remains the same)
}

# Check if pnpm is installed
if ! command_exists pnpm ; then
    echo "pnpm is not installed. Please install it first."
    exit 1
fi

# Create React app with Vite
pnpm create vite my-standard-react-app --template react-ts

# Navigate into the project directory
cd my-standard-react-app

# Install dependencies
pnpm install

# Add ESLint and related plugins
pnpm add -D eslint@^8.0.0 @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y eslint-plugin-security

# Create ESLint config file
cat > .eslintrc.js << EOL
module.exports = {
  // ... (ESLint configuration remains the same)
};
EOL

# Add Prettier
pnpm add -D prettier

# Create Prettier config file
cat > .prettierrc << EOL
{
  "semi": true,
  "trailingComma": "all",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2
}
EOL

# Add Husky and lint-staged
pnpm add -D husky lint-staged

# Initialize Husky without using npx
pnpm husky install || true

# Add pre-commit hook without using npx
pnpm husky add .husky/pre-commit "pnpm lint-staged" || true

# Add lint-staged configuration to package.json
#pnpm json -I -f package.json -e 'this["lint-staged"]={"*.{js,jsx,ts,tsx}": ["eslint --fix","prettier --write"]}'

sed -i '/"scripts": {/i \
  "lint-staged": {\
    "*.{js,jsx,ts,tsx}": [\
      "eslint --fix",\
      "prettier --write"\
    ]\
  },' package.json

# Create catalog-info.yaml
cat > catalog-info.yaml << EOL
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: \${{values.component_id | dump}}
  description: \${{values.description | dump}}
  annotations:
    github.com/project-slug: \${{values.destination.owner + "/" + values.destination.repo}}
    backstage.io/techdocs-ref: dir:.
spec:
  type: website
  lifecycle: experimental
  owner: \${{values.owner | dump}}
EOL

# Create .backstage folder and backstage.json
mkdir -p .backstage
cat > .backstage/backstage.json << EOL
{
  "version": 1,
  "projectType": "react-typescript",
  "buildTool": "vite"
}
EOL

# Create SECURITY.md
cat > SECURITY.md << EOL
# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability within this project, please send an e-mail to security@yourcompany.com. All security vulnerabilities will be promptly addressed.

Please do not publicly disclose the issue until it has been addressed by our team.

## Supported Versions

Use this section to tell people about which versions of your project are currently being supported with security updates.

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |
EOL

# Return to the parent directory
cd ..

echo "About to call verify_setup"
# Run verification
verify_setup

echo "Setup complete! Your React template with Backstage configuration is ready."
