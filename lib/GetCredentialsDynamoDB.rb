module OvpnAuth

    ##################
    #
    # FUNCTION
    # Input: 1 string
    # => string contains the username
    #
    # Return: String containing the stored users hash as a string or throws an exception if that row isn't found
    #
    # Purpose: get the users hashed password from dynamodb
    #
    ##################
    def get_credentials_dynamodb(stringUserID)



        get_credentials_dynamodb

        tableName = 'openvpn-access'

        # create a dynamodb client object
        client = Aws::DynamoDB::Client.new(
            region: 'ap-southeast-2'
        )

        # get the users password in dynamodb
        user = client.get_item(
            table_name: tableName,
            key: [
                {"Username" => stringUserID }
            ],
            attributes_to_get: ["Password"],
            consistent_read: false
        )

        putsLog user.Password

        return user.Password

    end

    #gets the aws region to make the call against based on the iam role
    def get_location

    end

end
