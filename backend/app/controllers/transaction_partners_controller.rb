
class TransactionPartnersController < ApplicationController
  # GET /transaction_partners
  # GET /transaction_partners.json
  def index
    @transaction_partners = TransactionPartner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transaction_partners }
    end
  end

  # GET /transaction_partners/1
  # GET /transaction_partners/1.json
  def show
    @transaction_partner = TransactionPartner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction_partner }
    end
  end

  # GET /transaction_partners/new
  # GET /transaction_partners/new.json
  def new
    @transaction_partner = TransactionPartner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction_partner }
    end
  end

  # GET /transaction_partners/1/edit
  def edit
    @transaction_partner = TransactionPartner.find(params[:id])
  end

  # POST /transaction_partners
  # POST /transaction_partners.json
  def create
    @transaction_partner = TransactionPartner.new(params[:transaction_partner])

    respond_to do |format|
      if @transaction_partner.save
        format.html { redirect_to @transaction_partner, notice: 'Transaction partner was successfully created.' }
        format.json { render json: @transaction_partner, status: :created, location: @transaction_partner }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction_partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transaction_partners/1
  # PUT /transaction_partners/1.json
  def update
    @transaction_partner = TransactionPartner.find(params[:id])

    respond_to do |format|
      if @transaction_partner.update_attributes(params[:transaction_partner])
        format.html { redirect_to @transaction_partner, notice: 'Transaction partner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction_partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_partners/1
  # DELETE /transaction_partners/1.json
  def destroy
    @transaction_partner = TransactionPartner.find(params[:id])
    @transaction_partner.destroy

    respond_to do |format|
      format.html { redirect_to transaction_partners_url }
      format.json { head :no_content }
    end
  end
end
