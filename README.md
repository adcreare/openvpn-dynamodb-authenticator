# openvpn-dynamodb-authenticator
This tool provides a Openvpn authenticator using dynamodb.

It is designed for deployments where both PKI certificates and username and password are required to obtain a vpn connction.

This module allows openvpn to authenticate from this module instead of using /etc/shadow for a local user.

To support migration the password format in dynamoodb is in shadow format.

To obtian this module see the releases page, download the gem and install using 'gem install openvpn-dynamodb-authenticator.gem'



## Setup
#### DynamoDB table configuration
1. Application expects table name to be: **openvpn-access** (note: it is planned to make this a configuration in future)

2. Table to contain 2 columns with the following required names:
    * Column Name: **Username**  - Primary partition key -  Key Type:**Hash**
    * Column Name: **Password** - Attribute Type:**String**

3. Items inside the table look like the below in JSON format:
```json
{
  "Username": "username",
  "Password": "$6$phGQY812$vQq.acb67blSJ4nAUou1mSLRsCFX4vgyeSNQRQfAdGohPGQhwzGT9qiXYleogRX3HPo4kik3PQyucsK6zgf4n0"
}
```

---
#### Setup instance IAM role permissions to DynamoDB
The openvpn server is going to require access to the DynamoDB table - this is best handled with an IAM instance role
1. Assign your instance a role when you deploy it
2. Add the following IAM policy to your instance role - Update **$$SetToYourRegion$** to match your aws region and **$YourAWSAccountID$** your AWS account number.

```json

{
    "Statement": [
        {
            "Action": [
                "dynamodb:GetItem"
            ],
            "Resource": [
                "arn:aws:dynamodb:$SetToYourRegion$:$YourAWSAccountID$:table/openvpn-access"
            ],
            "Effect": "Allow"
        }
    ]
}
```    
For example if I was located in us-east-1 with the account number of 211111111113 then the resource line would look like this: ```arn:aws:dynamodb:us-east-1:211111111113:table/openvpn-access```


---
#### Install gem on your openvpn server
1. Download gem file from latest release https://github.com/adcreare/openvpn-dynamodb-authenticator/releases/latest

2. Install gem
```sh
sudo gem install openvpn-dynamodb-authenticator-*.gem
```

---

#### Configure openvpn
1. Locate the openvpn server config file - by default this will be located in **/etc/openvpn/** but may vary depend on your distribution
2. Edit server config and add the following to the config file to use the authenticator: ```auth-user-pass-verify /usr/local/bin/ovpn-auth via-file```  
3. Restart your openvpn server - dependant on your distribution:
```
sudo service openvpn restart
```
OR
```
sudo systemctl openvpn restart
```
OR
```
sudo /etc/init.d/openvpn restart
```

---
#### Final steps
1. Find a username and password to place into the table. This could be as simple as performing a ```adduser myvpnuser``` on any linux system and then coping the hash from ```/etc/shadow``` into the Password field of the table


---
#### TODO
1. Implement a configuration option for table name
2. 
