# Jenkins

## What is Jenkins?
- **Jenkins** provides **CI/CD (Continuous Integration and Continuous Delivery)** functionality.
- It is an **open-source automation server**.
- Primarily used for **continuous integration (CI)** and **continuous delivery (CD)** of software projects.
- Supports **building, deploying, and automating** projects.

---

## Importance of Jenkins
- Facilitates **automated testing and deployment**.
- Integrates with various tools and services (e.g., Git, Maven).
- Enhances **collaboration** among development teams.

---

## Installing Jenkins on Ubuntu

### Installation Steps:

1. This is the Debian package repository of Jenkins to automate installation and upgrade. To use this repository, first add the key to your system (for the Weekly Release Line):

```bash

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian/jenkins.io-2023.key
  
```
2.Then add a Jenkins apt repository entry:

```bash

 echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
  
  ```

3.Update your local package index, then finally install Jenkins:

```bash

  sudo apt-get update
  sudo apt-get install fontconfig openjdk-17-jre
  sudo apt-get install jenkins

```

### Prerequisites:

- Java Development Kit (JDK) must be installed.

### Configuring Jenkins

- Initial Setup

- Access Jenkins through a web browser (default port is 8080):

```bash

http://localhost:8080

```

- Unlock Jenkins using the initial admin password found in:

```bash
 
/var/lib/jenkins/secrets/initialAdminPassword

```
### Plugins and Jobs

## Plugins

Plugins are used to integrate other applications with Jenkins jobs.

Examples: Git, Maven, Docker, Kubernetes, etc.

## Jobs

A job is a specific way to perform a task in Jenkins.

Types of Jobs:

- Freestyle: Simple, flexible jobs.

- Pipeline: Advanced jobs defined using a Jenkinsfile.

### Build Triggers

- Manual Build Trigger:

Users can manually trigger a build by clicking the "Build Now" button on the Jenkins dashboard.

- Build After Other Projects Are Built:

A job is triggered after one or more upstream jobs complete successfully.

- Build Periodically:

Schedule builds using cron syntax:

MINUTES (0-59) HOURS (0-23) DAY_OF_MONTH (1-31) MONTH (1-12) DAY_OF_WEEK (0-6)

Example: H/15 * * * * (every 15 minutes).

- Poll SCM:

Jenkins checks for changes in the source code repository at regular intervals.

A build is triggered only when changes are detected.

- GitHub Webhooks:

Integrates with GitHub to trigger builds based on repository events (e.g., push, pull request).

### Key Components of Declarati[ve Pipeline Syntax

## Pipeline Block

Every Declarative Pipeline must start with a pipeline block:

```bash

pipeline {
    // Pipeline content goes here
}

```
## Agent

Specifies where the pipeline or specific stages should run:

```bash

agent any  // Runs on any available agent

```
## Stages

The stages block contains one or more stage blocks, each representing a distinct phase in the pipeline (e.g., Build, Test, Deploy):

```bash

stages {
    stage('Build') {
        steps {
            // Build steps go here
        }
    }
    stage('Test') {
        steps {
            // Test steps go here
        }
    }
}

```

## Steps

Inside each stage, define the actual commands or actions to be executed using steps:

```bash

steps {
    sh 'mvn clean package'  // Example: Build a Maven project
}

```

Example Jenkinsfile

```bash

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/your-project.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}

```