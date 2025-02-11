# Setup with Jenkins and Docker for Django Application on Local Virtual Machines & EC2 Instances

This guide provides step-by-step instructions to set up an EC2 instance, install necessary tools, configure Jenkins, and deploy a Django application using Docker.

---

## Prerequisites
- An AWS account with access to EC2.
- Basic knowledge of AWS, Linux commands, Jenkins, and Docker.

---

## Step 1: Launch an EC2 Instance
1. Log in to your AWS Management Console.
2. Navigate to **EC2** > **Instances** > **Launch Instances**.
3. Choose an Amazon Machine Image (AMI) (e.g., Ubuntu Server 22.04 LTS).
4. Select an instance type (e.g., t2.micro).
5. Configure instance details, storage, and security groups.
   - Ensure the security group allows inbound traffic on ports:
     - `22` (SSH)
     - `8080` (Jenkins)
     - `8000` (Django app)
6. Launch the instance and download the key pair (.pem file).

---

## Step 2: Connect to the EC2 Instance
1. Connect to the Instance
Select your instance by checking the box next to it.

Click the Connect button at the top of the page.

In the Connect to instance dialog, you will see multiple connection options. Choose EC2 Instance Connect (recommended for simplicity).

2.Update the package list:

```bash

sudo apt update

```
## Step 3: Install Required ToolsStep 3: Install Required Tools

1. Install Git:

```bash

sudo apt install git -y

```
2. Install Docker:

```bash

sudo apt install docker.io -y

```

3. Add the current user to the Docker group:

```bash

sudo usermod -aG docker $USER

```
4. Restart the SSH session for the changes to take effect:

## Step 4: Install Jenkins

1. Install Jenkins:

https://pkg.jenkins.io/debian/

2. Start and enable Jenkins:

```bash

sudo systemctl start jenkins
sudo systemctl enable jenkins

```
3. Access Jenkins via your browser:

```bash

http://<EC2-Public-IP>:8080

```

4. Unlock Jenkins using the initial admin password:

```bash

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

```

5. Complete the Jenkins setup and install recommended plugins.

## Step 5: Configure Jenkins for Docker

1. Add the Jenkins user to the Docker group:

```bash

sudo usermod -aG docker jenkins

```

2. Restart Jenkins:

```bash

sudo systemctl restart jenkins

```
3. Verify Docker permissions:

```bash

ls -lah /var/run/docker.sock

```
4. If permissions are not set correctly, run:

```bash

sudo chown root:docker /var/run/docker.sock
sudo chmod 666 /var/run/docker.sock

```
## Step 6: Automate Credentials in Jenkins (Optional)

If you're using Jenkins to automate the process, you can store your Docker Hub credentials securely in Jenkins:

1. In Jenkins, go to Dashboard > Manage Jenkins > Manage Credentials.

2. Under Stores scoped to Jenkins, click Global credentials (unrestricted).

3. Click Add Credentials.

4. Fill in the details:

- Kind: Username and password
 
- Scope: Global

- Username: Your Docker Hub username

- Password: Your Docker Hub password

- ID: (Optional) A unique ID for these credentials (e.g., dockerhub-creds)

- Description: (Optional) A description for these credentials.

5. Click OK to save the credentials.

6. Update your Jenkins pipeline script to use these credentials:

## Step 7: Create a Jenkins Pipeline Job

1.In the Jenkins dashboard, click New Item.

2.Enter a name for your job (e.g., Django-App-Pipeline) and select Pipeline.

3.In the Pipeline section, add the following script:

4.Save the pipeline and click Build Now.

## Step 8: Access the Django Application

Once the pipeline job completes successfully, access the Django app via:

```bash

http://<EC2-Public-IP>:8000

```
### Troubleshooting

If the app is not accessible, check the following:

- Ensure the security group allows inbound traffic on port 8000.

- Verify the Docker container is running:

```bash

docker ps

```
### Notes:

- Replace your-dockerhub-username, django-note-app, and latest with your actual Docker Hub username, repository name, and tag.

- Always keep your Docker Hub credentials secure and avoid hardcoding them in scripts.