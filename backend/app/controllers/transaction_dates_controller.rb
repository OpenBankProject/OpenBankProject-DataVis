
class TransactionDatesController < ApplicationController
  # GET /transaction_dates
  # GET /transaction_dates.json
  def index
    @transaction_dates = TransactionDate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transaction_dates }
    end
  end

  # GET /transaction_dates/1
  # GET /transaction_dates/1.json
  def show
    @transaction_date = TransactionDate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction_date }
    end
  end

  # GET /transaction_dates/new
  # GET /transaction_dates/new.json
  def new
    @transaction_date = TransactionDate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction_date }
    end
  end

  # GET /transaction_dates/1/edit
  def edit
    @transaction_date = TransactionDate.find(params[:id])
  end

  # POST /transaction_dates
  # POST /transaction_dates.json
  def create
    @transaction_date = TransactionDate.new(params[:transaction_date])

    respond_to do |format|
      if @transaction_date.save
        format.html { redirect_to @transaction_date, notice: 'Transaction date was successfully created.' }
        format.json { render json: @transaction_date, status: :created, location: @transaction_date }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transaction_dates/1
  # PUT /transaction_dates/1.json
  def update
    @transaction_date = TransactionDate.find(params[:id])

    respond_to do |format|
      if @transaction_date.update_attributes(params[:transaction_date])
        format.html { redirect_to @transaction_date, notice: 'Transaction date was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_dates/1
  # DELETE /transaction_dates/1.json
  def destroy
    @transaction_date = TransactionDate.find(params[:id])
    @transaction_date.destroy

    respond_to do |format|
      format.html { redirect_to transaction_dates_url }
      format.json { head :no_content }
    end
  end
end
