# Managing Cloud Resources w/ Terraform

## Objective

### 

<p> The objective of this project is to use multiple providers to manage cloud resources with Terraform. We will be using terraform providers to configure a Terraform file using HCL Terraform's language to provision different resources within the file. We will be using the following resources.</p>

1. AWS
2. Terraform
3. IPAM Pools
4. VPC
5. Cloud9

This is how our environment will look after we're done.

### Visualization

![Screenshot 2023-03-22 081953](https://user-images.githubusercontent.com/108555140/226919840-99549603-778f-4faf-a477-63fcf43e6821.png)


## Let's Get Started!

###

### First step

1. We need to first open Cloud9 and provision a new virtual machine. If you don't have one created already you can simply click on "Create environment" leave everything as default and scroll down and click on create.

2. Then we install Terraform by using the command. " sudo yum install terraform -y "


### Second Step

1. First we are going to make two directories. Type the following commands: 'mkdir us-east-1' . 'mkdir us-east-2' . 'cd us-east-1' . 'touch providers.tf'
2.   
