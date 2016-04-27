# openvpn-dynamodb-authenticator
This tool provides a Openvpn authenticator using dynamodb.

It is designed for deployments where both PKI certificates and username and password are required to obtain a vpn connction.


This module allows openvpn to authenticate from this module instead of using /etc/shadow for a local user.

To support migration the password format in dynamoodb is in shadow format.

To obtian this module see the releases page, download the gem and install using 'gem install openvpn-dynamodb-authenticator.gem'