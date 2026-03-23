provider "aws" {
  region = "eu-north-1"
}

resource "aws_elastic_beanstalk_application" "app" {
    name = "java-war-app-2"
    description = "Java WAR from existing s3"
  
}
resource "aws_elastic_beanstalk_application_version" "app_version" {
    name = "V1"
    application = aws_elastic_beanstalk_application.app.name
    bucket = "java-app-bucket-01"
    key = "dptweb-1.0.war "

}
resource "aws_elastic_beanstalk_environment" "env" {
name = "java-war-env"
application = aws_elastic_beanstalk_application.app.name
version_label = aws_elastic_beanstalk_application_version.app_version.name

solution_stack_name = "64bit Amazon Linux 2 v5.8.4 running Tomcat 9 Corretto 11"

setting {
namespace = "aws:autoscaling"
name = "InstanceType"
value = "t3.micro"
}
}