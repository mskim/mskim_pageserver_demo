require 'csv'

class AdsController < ApplicationController
  # GET /ads
  # GET /ads.xml
  def index
    @ads = Ad.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ads }
    end
  end

  # GET /ads/1
  # GET /ads/1.xml
  def show
    @ad = Ad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ad }
    end
  end

  # GET /ads/new
  # GET /ads/new.xml
  def new
    @ad = Ad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ad }
    end
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.find(params[:id])
  end

  # POST /ads
  # POST /ads.xml
  def create
    @ad = Ad.new(params[:ad])

    respond_to do |format|
      if @ad.save
        flash[:notice] = 'Ad was successfully created.'
        # Create PDF
        @ad.generate_PDF
        format.html { redirect_to(@ad) }
        format.xml  { render :xml => @ad, :status => :created, :location => @ad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ads/1
  # PUT /ads/1.xml
  def update
    @ad = Ad.find(params[:id])

    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        flash[:notice] = 'Ad was successfully updated.'
        # Create PDF
        @ad.generate_PDF
        format.html { redirect_to(@ad) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.xml
  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy

    respond_to do |format|
      format.html { redirect_to(ads_url) }
      format.xml  { head :ok }
    end
  end
  
  # Export the Ad Model contents as excel file
  def export
    headers['Content-Type']="application/vnd.ms-excel"
    headers['Content-Disposition']='attachment; filename="ads.xls"'
    headers['Cache-Control']=''
    @ads = Ad.find(:all)
    render :layout=>'export'
    
  end
  
  # import the Ad Model from csv file
  def import
    @parsed_file=CSV::Reader.parse(params[:dump][:file])
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
    end
    if c.save
       n=n+1
       GC.start if n%50==0
    end
    flash.now[:message]="CSV Import Successful,  #{n} new records added to data base"
    
  end
end
