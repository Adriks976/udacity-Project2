# Udacity - Deploy a High-Availability Web App using CloudFormation

## Introduction

This repository if for my second project of Udacity: Deploy a High-Availability Web App using CloudFormation.

You can find in it 3 CF stacks: network, bastion and webapp and one script do_stack.sh which is responsible for deploying all stacks.

## U-D(i)agram

![Udagram](AWS-Diagram.png)
 
## Deploy it

### Secure

Create:

```bash
./do_stack.sh create secure
```

Delete:

```bash
./do_stack.sh delete secure
```

With this first step you will:
- find your local IP and store it on aws parameter store
- Generate a SSH key (RSA 4096)
- Store the ssh key in paramater store as a secured string
- Import the key in EC2 key pair

Good you have your prerequis done!

### Network

Create: 

```bash
./do_stack.sh create network
```

Update: 

```bash
./do_stack.sh update network
```

Delete:

```bash
./do_stack.sh delete network
```


This stack is about network so you will deploy the CF stack network:

- 1 VPC
- 2 Public Subnets
- 2 Private Subnets
- Internet Gateway
- 2 NAT Gateways with EIP
- Private Routes
- Public Routes
- Default Security Group


