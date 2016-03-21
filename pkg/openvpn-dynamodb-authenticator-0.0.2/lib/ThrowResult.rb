module OvpnAuth

    ##################
    #
    # FUNCTION
    # Input:
    # Return:
    # Purpose:
    #
    ##################

    def logonFailed(logonError='')
        putsLog 'Logon failed. ' +logonError
        exit 1

    end

    def logonSuccessful(message='')
        putsLog 'Logon Successful. ' +message
        exit 0

    end
end
