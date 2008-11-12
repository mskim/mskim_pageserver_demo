namespace :adbase do
  desc "layout ad" 
  task :layout_all_ads => :environment do
    ads=Ad.all
    for ad in ads
      generate_PDF(ad)
    end
  end
  
  
  def generate_PDF(ad)
    unless ad.template.blank?
      myRecord={"company"=>company.name, "phone"=>ad.phone, "business_item"=>ad.business_item,  "copy1"=>ad.copy1, "copy2"=>ad.copy2, "fax"=>ad.fax, "phone2"=>ad.phone2,"www"=>ad.www, "hp"=>ad.hp,"image1"=>ad.phone,"image2"=>ad.phone }
         generate_mJob(ad, myRecord)
         path="#{RAILS_ROOT}/public/Jobs/"+"#{combinedNameAsUniqueID}"
         jobPath="#{path}"+".mJob"
         `open "#{jobPath}"`

    else
         puts "Fatal error! No template for #{ad.phone}"
    end

  end
  
  def  generate_mJob(ad, myRecord)
              # This is the DTD
              front="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
              <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\
              <plist version=\"1.0\">\n<dict>\n"

              # This is the closing section
              rear="  </dict>\n</plist>\n"

              mjobPath="#{RAILS_ROOT}/public/Jobs/"+"#{ad.phone}"
              pdfFile= "#{RAILS_ROOT}/public/Output/#{ad.phone}"
              keyString= aRecord.keys.join("\t")
              valueString= aRecord.values.join("\t")
              templatePath= "#{RAILS_ROOT}/public/Templates/#{ad.template}.mlayoutP"

              middle="<key>JobType</key>
                 <string>label</string>
                 <key>ProjectPath</key>
               	<string>#{RAILS_ROOT}/public/images/#{ad.kind}</string>
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
