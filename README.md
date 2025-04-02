Terraform installation:

# wget [https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip](https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip)

wget https://releases.hashicorp.com/terraform/1.11.3/c

apt install unzip

unzip terraform_1.11.3_linux_amd64.zip

mv terraform /usr/local/bin/

terraform -v

apt update -y

apt install awscli

aws configure

# jenkins-terraform

jenkins-terraform

sudo amazon-linux-extras install java-openjdk11 -y

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo

sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key 

sudo yum install jenkins -y

sudo systemctl enable jenkins

sudo systemctl start jenkins
