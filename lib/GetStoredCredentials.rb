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
                region: get_aws_region() #call function to get the region
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
             table may not exist,iam role may have insuffcient access. The table schema could also be wrong')
        end

        return returnUserPassword

    end

    ##################
    #
    # FUNCTION
    # Input: none
    #
    # Return: String containing the region the ec2 instance is in for the dynamodb lookup
    # Purpose: Used to workout which aws region this instance is in and then for for a dynamodb table that matches in that region
    #
    ##################
    def get_aws_region


        begin

            url = 'http://169.254.169.254/latest/dynamic/instance-identity/document'
            uri = URI(url)
            response = Net::HTTP.get(uri)

            hashOfLookupValues = JSON.parse(response)
            lookupRegion = hashOfLookupValues["region"]

        rescue
            logonFailed('Unable to perform region lookup. Is this an EC2 instance? and does it have access to http://169.254.169.254')
        end

        return lookupRegion

    end

end
