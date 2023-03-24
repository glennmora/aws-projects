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

- 
