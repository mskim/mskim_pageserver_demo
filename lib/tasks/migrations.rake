require 'csv'

namespace :adbase do
  
  desc "parse excel file saved as csv and upload it ot Ad" 
  task :parse_ads => :environment do
    filename="#{RAILS_ROOT}/public/data/ads.csv"
    # read the excel file
    file=File.open(filename,'r') { |f| f.read}
    puts file
    parse(file)
  end
  def parse(file)
    @parsed_file=CSV::Reader.parse(file)
    n=0
    @parsed_file.each  do |row|
      c=Ad.new
      c.name=row[1]
      c.phone=row[2]
      c.company=row[3]
      c.business_item=row[4]
      c.copy1=row[5]
      c.copy2=row[6]
      c.phone2=row[7]
      c.fax=row[8]
      c.www=row[9]
      c.hp=row[10]
      c.kind=row[11]
      c.size=row[12]
      c.template=row[13]
      if c.save
         n=n+1
         GC.start if n%50==0
      end
      
    end
    puts "CSV Import Successful,  #{n} new records added to data base"
    
  end
  
  
  
  
  
end
