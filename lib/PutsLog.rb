
module OvpnAuth

    ##################
    #
    # FUNCTION
    # Input: string containing information to put
    # Return: none
    # Purpose: function will take the an input string and depending on flags with write it to a file
    #           and echo it to console
    #
    ##################
    def putsLog(stringToWrite)

       begin
          #File.open(Onus.config.folderPath+Onus.config.logFileName,'a+') do | file1 | file1.puts Time.now.strftime("%F %T.%L : ")+stringToWrite end
          puts stringToWrite

       rescue => e

          puts 'ERROR logging failed'
          puts 'Message: '+stringToWrite+' Exception:'+e.message
       end

    end


end
