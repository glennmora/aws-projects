# Wordpress website using Elastic Beanstalk and Amazon RDS

### What are we building?

- We will be launching a webstack to host our *WordPress App using Elastic Beanstalk and Amazon Relational Database Service or RDS*. The Elastic Beanstalk will provision the infrastructure (Amazon EC2 instance) and stack components (web server, OS, etc.). The RDS creates a MySQL database.

### Imagery

![Screenshot 2023-03-30 073325](https://user-images.githubusercontent.com/108555140/228837128-a4f37ebe-fad8-4fed-bca8-ebaacb064c5f.png)

- As stated before we are creating a Wordpress website within AWS using Elastic Beanstalk to manage our underlying infrastructure and Amazon RDS to launch our MySQL database. Our configuration will have **Internet Gateway** so that our website has access to the internet. There will be an **S3 Bucket** pointing to the Internet Gateway. 

- The Elastic Beanstalk in this case will take care of configuring the **Elastic Load Balancer(ELB)** to handle all the requests coming in and directing traffic accordingly. The **Elastic Beanstalk** will have two **EC2 Web/App Servers** that will automatically scale according to need. Our two *Web/App servers* will then point to the our **Database Master(MySQL database in this case)** which we provisioned using **Amazon RDS**.

- Also as you can tell by the black rectangles this stands for our security groups. The ELB, Web/Apps,and MySQL databases will each be configured with a security group.

- Now that we know what we are creating lets get started!

### First Step

1. First we are going to create the Amazon RDS instance. Go to https://console.aws.amazon.com/rds/home this will take you to the RDS dashboard. There on the left panel you will click on: 

* *"Databases"*
* *"Create database"* 
* *"Standard create"* 
* *"MySQL"* for Engine type
* Leave everything else the same but under **"Additional configuration"** you will rename the database to **"ebdb"**
* Then you will create a **Master username and password of your choice make sure to remember these credentials for later**.
* Create the database

![Screenshot 2023-03-30 070647](https://user-images.githubusercontent.com/108555140/228872695-9133bc65-9edb-46ce-b10a-b9c352e0d0d5.png)


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

![Screenshot 2023-03-30 074847](https://user-images.githubusercontent.com/108555140/228873138-ecfa2a19-a3c4-4776-8a6e-7716c39af45d.png)


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

![Screenshot 2023-03-30 070703](https://user-images.githubusercontent.com/108555140/228873463-860468d4-47e6-486b-bd08-4951cc1ea831.png)

5. Now we will create and configure the security group

- https://console.aws.amazon.com/elasticbeanstalk
- Choose **environments, configuration, instances, and edit**.
- Under EC2 security groups choose the security group associated with the Elastic Beanstalk
- Click **Apply, Confirm**
- Next go back to **Configuration**, on the **Software** section click on **Edit**
- Scroll to the **Environment properties** and configure it accordingly

![Screenshot 2023-03-29 115055](https://user-images.githubusercontent.com/108555140/228611271-ebd1bc26-178a-4e67-b2d6-74629518a56e.png)

- Click **Apply**


### Second Step

1. First we're going to configure our application and deployment

- **.ebextensions/dev.config** in this file we're going to change the IP address with your computer's public IP
- **.ebextensions/efs-create.config** in this file change the VPC and subnet IDS with your own
- Then create a source bundle with the following command
* **zip ../wordpress-beanstalk.zip -r * .[^.]**
- https://console.aws.amazon.com/elasticbeanstalk
- click on **environments, Upload and deploy, upload your source bundle, click on Deploy**
- Then choose the site URL to access your website in a new tab
- Here you will go through the WordPress installation wizard

![Screenshot 2023-03-30 093747](https://user-images.githubusercontent.com/108555140/228874197-67c7f0e7-90b5-42c7-932d-7ccde794c39a.png)

2. Next we will update the keys and salts

- https://console.aws.amazon.com/elasticbeanstalk
- Click on **Environments, Configuration, Software, Edit**
- For the **Environment properties** you will configure it accordingly

![Screenshot 2023-03-29 121923](https://user-images.githubusercontent.com/108555140/228617868-14e09323-c08f-491c-881d-f214e033c8d4.png)
- click **Apply**

3. Next we will remove access restrictions

- Use the following commands
* **rm .ebextensions/loadbalancer-sg.config**
* **zip ../wordpress-beanstalk-v2.zip -r * .[^.]* **
- https://console.aws.amazon.com/elasticbeanstalk
- click on **Environments,upload and deploy**
- Use the aws console to upload the source bundle and click on **deploy**

### Third Step

1. Now we're going to customize our Auto Scaling group

- https://console.aws.amazon.com/elasticbeanstalk
- click on **Environments, Configuration, Capacity, Edit**
- In the **Auto Scaling group** area, select **Min instances** to **2**
- Click on **Apply**

## Fourth Step

1. We will know update our WordPress website by installing the latest version.

- In the WordPress admin console we will use the export tool to export our environment and post to an XML file
- Then install and deploy the updated WordPress website to Elastic Beanstalk by following our previous steps that we used to install the previous version. 
- In the new version of WordPress install the **Importer tool** and use to import our XML file

2. Now we will clean up our project.

- https://console.aws.amazon.com/elasticbeanstalk
- Go to **Environments** select your the Elastic Beanstalk we created
- Click on **Actions, Terminate environment**
- Next navigate to https://console.aws.amazon.com/rds
- Choose **Databases** select the one we created
- Click on **Actions, Delete**
