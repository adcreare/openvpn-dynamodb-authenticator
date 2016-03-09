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

            #read each line in from the file and add into the array
            File.open(stringFilePath, "r") do |f|
                f.each_line do |line|
                    arrayLinesFromFile << line
                end
            end

            #check that the array isn't later than 0 and 1 (ie 2 elements)
            if arrayLinesFromFile.length > 1
                throw "Input seemed to contain more than 2 lines!"
            end

            #create a struct to return
            credentials = OpenStruct.new
            credentials.username = arrayLinesFromFile[0]
            credentials.password = arrayLinesFromFile[1]


        return credentials

    end
end
