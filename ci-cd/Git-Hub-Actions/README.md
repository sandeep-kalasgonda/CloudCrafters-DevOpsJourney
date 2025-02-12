# GitHub Actions - CI/CD Automation

GitHub Actions is a powerful automation tool that enables **Continuous Integration (CI) and Continuous Deployment (CD)** workflows directly in GitHub repositories. It allows developers to automate testing, building, and deploying applications efficiently.

---

## 🚀 Features of GitHub Actions
- Automates build, test, and deployment workflows.
- Supports event-driven execution (e.g., `push`, `pull_request`).
- Offers a marketplace with pre-built actions.
- Allows self-hosted or cloud-based runners.

---

## 🛠️ Setting Up GitHub Actions

### **1️⃣ Create a Workflow File**
Workflows in GitHub Actions are defined in **YAML** files inside `.github/workflows/`.

Example: **Basic CI Pipeline**
```yaml
name: CI Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

---

## 📂 File Structure
```
/my-project
│── .github/
│   ├── workflows/
│   │   ├── ci-pipeline.yml
│── src/
│── README.md
│── package.json
```

---

## 🔍 Viewing Workflow Output

### **1️⃣ GitHub UI**
1. Go to your **GitHub repository**.
2. Click on the **"Actions"** tab.
3. Select the **workflow run** you want to inspect.
4. Click on individual steps to **view logs**.

### **2️⃣ GitHub CLI**
Run the following commands:
```sh
gh run list                 # List recent workflow runs
gh run view <RUN_ID> --log  # View logs of a specific run
```

---

## ⚙️ Debugging Tips
- Add debugging messages in the workflow:
  ```yaml
  - run: echo "Debugging step..."
  ```
- Enable **verbose logging** with:
  ```yaml
  - run: npm test --verbose
  ```

---

## 📦 Using Secrets and Environment Variables
To securely store API keys and credentials, use **GitHub Secrets**:
1. Go to your repository **Settings** → **Secrets and Variables** → **Actions**.
2. Click **New repository secret**.
3. Reference it in your workflow:
   ```yaml
   - run: echo "API Key is ${{ secrets.API_KEY }}"
   ```

---

## 📢 Conclusion
GitHub Actions simplifies CI/CD automation, making it easier to test, build, and deploy projects. It integrates seamlessly with GitHub repositories and supports custom workflows for different use cases.

For more details, check out the **[GitHub Actions Documentation](https://docs.github.com/en/actions)**.

---

💡 **Need help?** Feel free to create an issue or contribute to this repository! 🚀

