class Ad < ActiveRecord::Base

    def generate_PDF
      unless template.blank?
           myRecord={"company"=>company, "phone"=>phone, "business_item"=>business_item,  "copy1"=>copy1, "copy2"=>copy2, "fax"=>fax, "phone2"=>phone2,"www"=>www, "hp"=>hp,"image1"=>phone,"image2"=>phone,"image3"=>phone }
           generate_mJob(myRecord)
           path="#{RAILS_ROOT}/public/Jobs/"+"#{phone}"
           jobPath="#{path}"+".mJob"
           `open "#{jobPath}"`

      else
           puts "No template for #{phone}"
      end

    end

    def  generate_mJob(myRecord)
                # This is the DTD
                front="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
                <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\
                <plist version=\"1.0\">\n<dict>\n"

                # This is the closing section
                rear="  </dict>\n</plist>\n"

                mjobPath="#{RAILS_ROOT}/public/Jobs/"+"#{phone}"
                pdfFile= "#{RAILS_ROOT}/public/Output/#{phone}"
                keyString= myRecord.keys.join("\t")
                valueString= myRecord.values.join("\t")
                templatePath= "#{RAILS_ROOT}/public/Templates/#{template}.mlayoutP"

                middle="<key>JobType</key>
                   <string>label</string>
                   <key>ProjectPath</key>
                 	<string>#{RAILS_ROOT}/public/images/#{kind}</string>
                 	<key>TemplatePath</key>
                 	<string>#{templatePath}</string>
                 	<key>HeaderString</key>
                 	<string>#{keyString}</string>
                  <key>DataString</key>
                 	<string>#{valueString}</string>
                  <key>OutputFilePath</key>
                 	<string>#{pdfFile}</string>\n"
                 jobString=front +middle+ rear
                 filename="#{mjobPath}.mJob"
                 File.open(filename,'w') { |f| f.write jobString }
    end
  end

