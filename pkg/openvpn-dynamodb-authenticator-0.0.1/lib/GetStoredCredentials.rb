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
    def get_stored_credentials(stringUserID)

        tableName = 'openvpn-access'

        begin

            # create a dynamodb client object
            client = Aws::DynamoDB::Client.new(
                region: 'ap-southeast-2'
            )

            # get the users password in dynamodb

            resp = client.get_item(
                table_name: tableName,
                key: {"Username" => stringUserID },
                projection_expression: "Password",
                consistent_read: false
            )


            #if we get a nil we know the user isn't found
            if resp.item == nil
                logonFailed('User not found in database')
            end

            returnUserPassword = resp.item["Password"]

            putsLog 'obtained store credentials from database'

        rescue
            logonFailed('Call to Get Stored Credentials in DynamoDB failed. Causes: User may not exist,
             table may not exist,iam role may have insuffcient access')
        end

        return returnUserPassword

    end

    #gets the aws region to make the call against based on the iam role
    def get_location

    end

end
