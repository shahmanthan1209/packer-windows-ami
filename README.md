# Provision a Windows AMI using Packer

Sometimes it's quite challenging to find a standard way of installing software on a windows machine using CLI tools. i.e Powershell. I have used [chocolatey](https://chocolatey.org/) since I am planning to use external softwares.

## Dependencies
 - Install [packer](http://packer.io)
 - There should be a default VPC in your AWS account, otherwise you have to indicate your VPC ID.
 - Packer will authenticate to AWS using your exported AWS\* credentials or your ~/.aws/credentials file.
 
PLEASE do not set any credentials in files that are checked in your code repository.

## Key Features:
 - Download files from S3 securely
 - Creation of users from CSV and adding them to Windows Local Groups and setting up password retention policy
 - Adding Remote Desktop Server Licensing feature
 - Changing the internet gateway route as windows machine won't have open internet access

## Usage
There is a variables section on top of the script that is used to define default variables:

```
"variables": {
  "base_ami_id": ""
}
```

If default values are present, they can be overridden from the command line, this is how you provision a new AMI from the command line using packer:

```
sudo packer build -var "base_ami_id=ami-******" provision-windows.json
```

Source: https://github.com/oerazo/packer-windows-ami
