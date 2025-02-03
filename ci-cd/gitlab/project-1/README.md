
---

# GitLab CI/CD Pipeline Setup Guide for Express.js Application

This guide will help you set up a simple CI/CD pipeline in GitLab to automate the process of installing dependencies, running tests, building a Docker image, and deploying it to a    virtual machine. This setup is designed for an Express.js application that includes some test files and a Dockerfile for building the application.

## Pipeline Overview

The pipeline consists of four stages:

1. **Install**: Installs the necessary dependencies for the Express.js project.
2. **Test**: Runs tests to ensure the application behaves as expected.
3. **Build**: Builds a Docker image from the application and pushes it to the GitLab registry.
4. **Deploy**: Deploys the latest Docker image to a GitLab runner VM.

### Stages in the Pipeline:

#### 1. `install_dependencies` Stage:
   - **Description**: This stage installs the required Node.js dependencies for the Express.js application using `npm install`.
   - **Configuration**:
     ```yaml
     install_dependencies:
       stage: install
       tags:
         - gitlab
       script:
         - npm install
       cache:
         paths:
           - node_modules/
     ```
   - **Explanation**:
     - The `npm install` command installs the Node.js dependencies listed in `package.json` (including Express.js).
     - The `node_modules/` folder is cached to speed up the process in future pipeline runs.

#### 2. `run_tests` Stage:
   - **Description**: This stage runs tests for the application using `npm test`. Test files should be present in the project directory.
   - **Configuration**:
     ```yaml
     run_tests:
       stage: test
       tags:
         - gitlab
       script:
         - echo "Running tests..."
         - npm test
       rules:
         - if: '$CI_COMMIT_BRANCH != "master"'
     ```
   - **Explanation**:
     - The `npm test` command runs the tests. You should have test files (e.g., with Mocha, Chai, or Jest) located in the appropriate test directory.
     - The `rules` section ensures that the tests are only run on branches other than `master` (e.g., feature branches, pull requests).

#### 3. `build_and_push_image` Stage:
   - **Description**: This stage builds a Docker image from the application using a `Dockerfile` and pushes it to the GitLab Container Registry.
   - **Configuration**:
     ```yaml
     build_and_push_image:
       stage: build
       tags:
         - gitlab
       script:
         - echo "$CI_REGISTRY_PASSWORD" | docker login -u "$CI_REGISTRY_USER" --password-stdin $CI_REGISTRY
         - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
         - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
         - docker tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA $CI_REGISTRY_IMAGE:latest
         - docker push $CI_REGISTRY_IMAGE:latest
       only:
         - master
     ```
   - **Explanation**:
     - The `docker build` command uses the `Dockerfile` in the project to build the Docker image.
     - The image is tagged with the commit SHA and `latest` to ensure the correct version is used.
     - The `only: master` ensures this stage runs only on the `master` branch.

#### 4. `deploy_to_runner_vm` Stage:
   - **Description**: This stage deploys the latest Docker image to a GitLab Runner VM, checking if Docker is installed and pulling the latest image.
   - **Configuration**:
     ```yaml
     deploy_to_runner_vm:
       stage: deploy
       tags:
         - gitlab
       script:
         - echo "Deploying to GitLab Runner VM..."
         - |
           # Check if Docker is installed, if not, install it
           echo 'Checking Docker installation...'
           if ! command -v docker &> /dev/null
           then
             echo "Docker not found, installing Docker..."
             sudo apt-get update
             sudo apt-get install -y docker.io
           fi

           # Pull the latest Docker image
           echo 'Pulling latest image...'
           docker pull $CI_REGISTRY_IMAGE:latest

           # Stop and remove the existing container if it exists
           echo 'Stopping previous container (if exists).. .. .'
           docker stop my-app || true
           docker rm my-app || true

           # Start the new container
           echo 'Starting new container...'
           docker run -d -p 8123:3000 --name my-app $CI_REGISTRY_IMAGE:latest
       only:
         - master
     ```
   - **Explanation**:
     - This script ensures Docker is installed on the VM. If not, it installs Docker.
     - It then pulls the latest Docker image from the registry and stops/removes any existing containers to avoid conflicts.
     - The new container is started, binding port `8123` on the VM to port `3000` of the container (where your Express.js app runs).

## Setting Up the CI/CD Pipeline

### Prerequisites:
1. **GitLab Runner**:
   Ensure you have a GitLab Runner installed and configured to run the pipeline.
   
2. **Docker**:
   - The runner VM must have Docker installed (for the deploy stage).
   - You can set up the Docker registry for pushing and pulling images.
   
3. **Environment Variables**:
   - Set up GitLab CI/CD environment variables for `$CI_REGISTRY`, `$CI_REGISTRY_USER`, and `$CI_REGISTRY_PASSWORD` for Docker authentication.
   - Set `$CI_REGISTRY_IMAGE` to the path of the Docker image in your GitLab registry.

### How to Configure:

1. **Create a `.gitlab-ci.yml` File**:
   - Copy the pipeline configuration into the `.gitlab-ci.yml` file at the root of your project.

2. **Ensure You Have a `Dockerfile`**:
   - Place a `Dockerfile` in the root directory of your Express.js application. This file will define how the Docker image is built.
   - Example of a simple `Dockerfile` for an Express.js app:
     ```Dockerfile
     FROM node:16

     # Set the working directory
     WORKDIR /usr/src/app

     # Install dependencies
     COPY package*.json ./
     RUN npm install

     # Copy the rest of the application
     COPY . .

     # Expose the port the app will run on
     EXPOSE 3000

     # Command to run the application
     CMD [ "npm", "start" ]
     ```

3. **Set Up GitLab CI/CD Variables**:
   - Navigate to your project’s settings in GitLab.
   - Go to **CI / CD** → **Variables**.
   - Add the following variables:
     - `CI_REGISTRY`: The URL of your GitLab container registry.
     - `CI_REGISTRY_USER`: Your GitLab registry username.
     - `CI_REGISTRY_PASSWORD`: Your GitLab registry password or token.
     - `CI_REGISTRY_IMAGE`: The path to your Docker image in GitLab.

4. **Push Your Code**:
   - Push your code to GitLab to trigger the pipeline.

### Example Workflow:

1. **Install Dependencies**:
   - `npm install` is executed and dependencies are installed for the Express.js app.

2. **Run Tests**:
   - Tests are run with `npm test` for branches other than `master`.

3. **Build & Push Docker Image**:
   - Docker image is built using the `Dockerfile` and pushed to the registry on the `master` branch.

4. **Deploy to Runner VM**:
   - The latest image is deployed to the runner VM.

## Conclusion

This GitLab CI/CD pipeline automates the process of installing dependencies, running tests, building Docker images, and deploying them to a GitLab Runner VM. By using this setup for your Express.js application, you can ensure smooth and automated workflows for building, testing, and deploying your app.

---

