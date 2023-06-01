# Configuration Management

For the task, I chose an Ubuntu 22 AMI Image on AWS EC2.
Also, I used the SSH public key in my local machine to create a key-pair on AWS.

## Running the Entire Infrastructure

Leveraging the Makefile in the repository, run the following command to provision the EC2 instance and run the Ansible playbook.

```bash
make automate
```

> **N/B:** The terraform code creates a local state in the local folder. For production environment, leverage AWS S3 to hold the state and DynamoDB for state locking.
