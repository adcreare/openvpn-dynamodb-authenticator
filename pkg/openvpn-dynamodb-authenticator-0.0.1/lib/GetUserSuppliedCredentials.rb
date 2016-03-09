module OvpnAuth

    ##################
    #
    # FUNCTION
    # Input: 1 x string that contains the path to the file to read in
    #
    # Return:1 x Struct that contains two objects
    # =>                .username that contains the username
    # =>                .password that contains the users password
    #
    # Purpose: function will take take a file path and get the users supplied
    # => credentials that are stored with in it. Object returned that contains
    # => username and password
    #
    ##################
    def get_user_supplied_credentials(stringFilePath)

            arrayLinesFromFile = []

            begin
                #read each line in from the file and add into the array
                File.open(stringFilePath, "r") do |f|
                    f.each_line do |line|
                        arrayLinesFromFile << line.strip
                    end
                end

            rescue
                logonFailed('Unable to open file on path supplied')
            end


            #check that the array isn't later than 0 and 1 (ie 2 elements)
            if arrayLinesFromFile.length > 2
                logonFailed('Input seemed to contain more than 2 lines (Username and password)')
            end

            #check that the array isn't too small
            if arrayLinesFromFile.length < 2
                logonFailed('Input seemed to contain less than 2 lines! Need usernamd and password on seperate lines')
            end


            #create a struct to return
            credentials = OpenStruct.new
            credentials.username = arrayLinesFromFile[0]
            credentials.password = arrayLinesFromFile[1]

            putsLog 'obtained credentials from file for user: '+credentials.username

        return credentials

    end
end
