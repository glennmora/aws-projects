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

1. First we are going to make two directories and create the files. Type the following commands:
 * mkdir us-east-1
 * mkdir us-east-2   
 * cd us-east-1 
 * touch providers.tf
 * touch main.tf  
 * touch outputs.tf

2. Then with our files created we are going to validate that the resource types we are using are supported. First we will check the **VPC**

* aws cloudformation describe-type --type RESOURCE --type-name AWS::EC2::VPC --region us-east-1 | jq '.ProvisioningType'

![Screenshot 2023-03-22 111706](https://user-images.githubusercontent.com/108555140/226975160-02351cc9-f6dc-4f38-97b0-5627497abc39.png)

We will do the same for the **API Gateway**

* aws cloudformation describe-type --type RESOURCE --type-name AWS::ApiGateway::RestApi --region us-east-1 | jq '.ProvisioningType'

![Screenshot 2023-03-22 113841](https://user-images.githubusercontent.com/108555140/226975474-16ca7a0c-2e3f-49d9-a2e7-c32fd7409892.png)

You can also check this on the Terraform registry to see what resources are supported.

![verify-docs-vpc](https://user-images.githubusercontent.com/108555140/226975673-3025db90-7ec2-4587-a606-36212845c5b0.png)

### Third Step

1. Now that we've checked that all our resources are compatible with AWS provider we can initialize our environment and take a closer look at what exactly we are provisioning before we apply anything.

2. Let's first take a look at the **main.tf** file

![Screenshot 2023-03-22 113302](https://user-images.githubusercontent.com/108555140/226976371-cd98e40d-e168-4e9d-ac98-2709974302da.png)

- Starting from the top we can we are creating our **awscc_ec2_ipam" or our IPAM** we do this by specifying the different regions we are going to be using and giving it a tag with the name **global-ipam** . Also take note that we are also using a module **module.tags_shared.tags** modules are containers for multiple resources that are used together which consist of a bundle of **.tf** or **.tf.json files** .

- Then we create the **"awscc_ec2_ipam_pool" "root"** which is our IPAM root pool that we will reference to create the *useast1 pool* and the *useast2 pool*. We give it an address family which is *ipv4* and create the scope id *awscc_ec2_ipam.main.private_default_scope_id*  followed by the cidr block range and a tag.

![Screenshot 2023-03-22 115816](https://user-images.githubusercontent.com/108555140/226980958-b9449117-765e-4c9c-9bbf-ae75cd9c0ef2.png)


- Now with our root pool set in place we create the *useast1* pool. 

![Screenshot 2023-03-22 120030](https://user-images.githubusercontent.com/108555140/226981427-dc34c800-d169-4c65-aa86-b22aee3eb7d0.png)

- In here we us the same commands as before but make note that for our *scope_id* we are refencing the same scope that we used for our root pool. We also added the *locale* to specify the region and our source pool id is going to be the root pool id *awscc_ec2_ipam_pool.root.ipam_pool_id* . We will do the same commands for the us-east-2 pool with the only difference being the *locale* will be *"us-east-2"* .

- Next we look at vpc.

![Screenshot 2023-03-22 121101](https://user-images.githubusercontent.com/108555140/226984141-c0875b6f-33e3-4858-a777-c2c0d42a9d31.png)

- In here we are creating our vpc by making a resource block defining the type of resource *"aws_vpc"* and giving it a name *"useast1"*. We give it 
