module OvpnAuth

    ##################
    #
    # FUNCTION
    # Input: struct that contains 2 keys
    # => .username that contains the username
    # => .password that contains the password

    # Return: true if the username and password match with stored - else false
    #
    # Purpose: function will take supplied credentials and compare to stored creds
    #
    ##################
    def validate_credentials(structUserSuppliedCredentials)
        userPasswordandHashMatch = false


            #putsLog 'This is the username from file:'+structUserSuppliedCredentials.username

            #get the stored password for that user
            userStoredPassword = get_stored_credentials(structUserSuppliedCredentials.username)

            #putsLog 'This is from DB:'+userStoredPassword
            putsLog 'validating user'

            userPasswordandHashMatch = UnixCrypt.valid?(structUserSuppliedCredentials.password,userStoredPassword)

        return userPasswordandHashMatch

    end
end
