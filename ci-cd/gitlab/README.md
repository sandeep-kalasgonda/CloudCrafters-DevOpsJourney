# GitLab CI/CD Workflow & Setup using Local Runner

## 1. Introduction
This document provides a   step-by-step guide on setting up **GitLab CI/CD** with a **self-hosted local runner**. This setup allows automation of build, test, and deployment workflows.

---

## 2. Prerequisites
- A **GitLab** account
- A **GitLab repository**
- A **Linux-based server or VM** to act as a local runner
- **Docker installed** on the local machine (for containerized jobs, optional but recommended)
- **Git installed** on your local machine

---

## 3. GitLab CI/CD Workflow Overview

1. **Commit Code** → Push to GitLab repository.
2. **GitLab Runner Executes Jobs** → The runner fetches the project and executes defined CI/CD pipeline stages.
3. **Build & Test** → The application is built and tested.
4. **Deployment (Optional)** → The application is deployed to a server or cloud provider (aws).

---

## 4. Creating a GitLab Repository

1. Go to [GitLab](https://gitlab.com/).
2. Click on **New Project**.
3. Choose **Create Blank Project**.
4. Set a **Repository Name** and **Visibility**.
5. Click **Create Repository**.
6. Copy the Git repository URL and clone it locally:
   ```bash
   git clone <repo-url>
   cd <repo-name>
   ```

---

## 5. Installing and Configuring GitLab Runner (Local)

### **Step 1: Install GitLab Runner**
Run the following commands on your local server/VM to install GitLab Runner:

```bash
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install gitlab-runner -y
```

### **Step 2: Register the Runner**
1. Go to **GitLab → Your Repository → Settings → CI/CD → Runners**.
2. Copy the **GitLab instance URL** and **Registration Token**.
3. Run the following command to register the runner:

```bash
sudo gitlab-runner register
```

4. Enter the following details when prompted:
   - **GitLab instance URL** (e.g., `https://gitlab.com/`)
   - **Registration token** (copied from GitLab settings)
   - **Runner description** (e.g., `local-runner`)
   - **Executor type** (Choose `docker` for containerized jobs or `shell` for local execution)
   - **Docker image** (if using Docker, e.g., `ubuntu:latest`)

### **Step 3: Start the GitLab Runner**
```bash
sudo gitlab-runner start
```

Verify the runner is active:
```bash
sudo gitlab-runner status
```

The runner should now be listed as **active** in GitLab.

---

## 6. Configuring `.gitlab-ci.yml` for CI/CD

Create a `.gitlab-ci.yml` file in the root of your GitLab repository.

### **Basic Example**
```yaml
stages:
  - build
  - test
  - deploy

build:
  stage: build
  script:
    - echo "Building the project..."
    - mkdir build

unit_tests:
  stage: test
  script:
    - echo "Running tests..."
    - exit 0

deploy:
  stage: deploy
  script:
    - echo "Deploying application..."
    - exit 0
```

---

## 7. Importance of Tags in GitLab CI/CD

Tags in GitLab CI/CD are essential for:
- **Versioning**: Identifying different versions of the application.
- **Stable Releases**: Ensuring deployments are based on tested versions.
- **Triggering Pipelines**: Running specific jobs only for tagged versions.

### **Creating and Pushing a Tag**
```bash
git tag -a v1.0 -m "Release version 1.0"
git push origin v1.0
```

### **Using Tags in `.gitlab-ci.yml`**
To trigger jobs only on specific tags:
```yaml
build:
  stage: build
  script:
    - echo "Building for tagged release"
  only:
    - tags
```

---

## 8. Running & Monitoring Pipelines
1. **Push the code to GitLab**
   ```bash
   git add .
   git commit -m "Add GitLab CI/CD pipeline"
   git push origin main
   ```

2. **Go to GitLab → CI/CD → Pipelines** to monitor the execution.
3. Click on any **job** to see the logs and outputs.

---

## 9. Troubleshooting
### **Issue: Runner is not picking up jobs**
```bash
sudo gitlab-runner verify
```
If inactive, restart it:
```bash
sudo gitlab-runner restart
```

### **Issue: Job fails due to permission errors**
Ensure the runner user has proper permissions to execute scripts:
```bash
sudo usermod -aG docker gitlab-runner
```

### **Issue: Slow execution or stuck jobs**
Check logs:
```bash
sudo journalctl -u gitlab-runner --no-pager
```

---

## 10. Conclusion
Congratulations! 🎉 You have successfully set up a **GitLab CI/CD pipeline** using a **local GitLab Runner**. This setup ensures automated testing and deployment while keeping everything within your control.

---

## 11. Next Steps
- Configure **Dockerized** builds for better environment control.
- Integrate with **cloud providers** for deployment.
- Set up **environment variables & secrets** for secure deployments.

---



