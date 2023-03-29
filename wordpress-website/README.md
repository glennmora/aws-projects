# Wordpress website using Elastic Beanstalk and Amazon RDS

### What are we building?

- We will be launching a webstack to host our *WordPress App using Elastic Beanstalk and Amazon Relational Database Service or RDS*. The Elastic Beanstalk will provision the infrastructure (Amazon EC2 instance) and stack components (web server, OS, etc.). The RDS creates a MySQL database.

### Imagery

![Screenshot 2023-03-24 105410](https://user-images.githubusercontent.com/108555140/227589408-db63bccf-fdc2-4169-89e7-7e28da88033d.png)

- As stated before we are creating a Wordpress website within AWS using Elastic Beanstalk to manage our underlying infrastructure and Amazon RDS to launch our MySQL database. Our configuration will have **Internet Gateway** so that our website has access to the internet. There will be an **S3 Bucket** pointing to the Internet Gateway. 

- The Elastic Beanstalk in this case will take care of configuring the **Elastic Load Balancer(ELB)** to handle all the requests coming in and directing traffic accordingly. The **Elastic Beanstalk** will have two **EC2 Web/App Servers** that will automatically scale according to need. Our two *Web/App servers* will then point to the our **Database Master(MySQL database in this case)** which we provisioned using **Amazon RDS**. Amazon RDS will also have another copy of our database (MySQL) in *multiple availability zones (Multi-AZ)*. 

- Also as you can tell by the black rectangles this stands for our security groups. The ELB, Web/Apps,and MySQL databases will each be configured with a security group.

- Now that we know what we are creating lets get started!

### First Step

1. First we are going to create the Amazon RDS instance. Go to https://console.aws.amazon.com/rds/home this will take you to the RDS dashboard. There on the left panel you will click on: 
* *"Databases"*
* *"Create database"* 
* *"Standard create"* 
* *"Aurora (MySQL Compatible)"* for Engine type
* Leave everything else the same but under **"Additional configuration"** you will rename the database to **"ebdb"**
* Then you will create a **Master username and password of your choice make sure to remember these credentials for later**.
* Create the database

2. Second we will configure the security group
* Go back to your RDS database panel
* Select your database
* You will then click on ebdb instance-1
* Click on the **VPC security groups** link under *Connectivity & security*
* Click on *Inbound rules*
* *Edit inbound rules*
* *Add Rule*
* For *Type* chose Aurora
* For Source use sg- and choose the security group that's attached to your Elastic Beanstalk or use the default one

3. Third we will download Wordpress and configure it using the following commands

- curl https://wordpress.org/wordpress-4.9.5.tar.gz -o wordpress.tar.gz
- wget https://github.com/aws-samples/eb-php-wordpress/releases/download/v1.1/eb-php-wordpress-v1.zip
- tar -xvf wordpress.tar.gz
- mv wordpress wordpress-beanstalk
- cd wordpress-beanstalk
- unzip ../eb-php-wordpress-v1.zip

4. Fourth we will create the Elastic Beanstalk

- https://console.aws.amazon.com/elasticbeanstalk/home#/newApplication?applicationName=tutorials&environmentType=LoadBalanced

- You will use leave everything as default and create the app

5. Now we will create and configure the security group

- https://console.aws.amazon.com/elasticbeanstalk
- Choose **environments, configuration, instances, and edit**.
- Under EC2 security groups choose the security group associated with the Elastic Beanstalk
- Click **Apply, Confirm**
- Next go back to **Configuration**, on the **Software** section click on **Edit**
- Scroll to the **Environment properties** and configure it accordingly

![Screenshot 2023-03-29 115055](https://user-images.githubusercontent.com/108555140/228611271-ebd1bc26-178a-4e67-b2d6-74629518a56e.png)

- Click **Apply**
