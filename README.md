----------------------------------------------------AWS--------------------------------------------------------------
Created IAM user and created access key for this user. Downloaded csv.
Created IAM role and added permission to this role to create a resource defined in terraform script.
Created ec2 instance and attached this IAM role to the instance.
SSHed into the instance and rab below commands to install terraform,git and config manager:

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
sudo yum install git -y

Exported user access key:
export AWS_ACCESS_KEY_ID=access key
export AWS_SECRET_ACCESS_KEY=secret key

Checked  access key whether exported:
env
env | grep AWS
Created directory to code checkout:
mkdir aws-terraform-activity
cd aws-terraform-activity
Commited code to repo. Created AMI of ec2 instance to use in terraform script to create new ec2 based on this AMI.
Cloned repo to get terraform script:
sudo git clone https://github.com/Cloud-Computing-2023/automation_with_terraform_across_clouds.git
-----------------------------------------------------------------------
lopes-user must have permissions to create resource.
terraform init ---is mandatory to initiate provider
teraform apply
---------------------------------------------------GCP--------------------------------------------------------------------------



---------------------------------------------------Azure------------------------------------------------------------------------
