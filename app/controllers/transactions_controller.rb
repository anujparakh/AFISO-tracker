class TransactionsController < ApplicationController
  # before_action :check_for_lockup

  ### READ ###
  def index
    if params[:format] == nil or params[:format] == 'None'
      @selected = 0
      @total = 0.0
      @transactions = Transaction.order("created_at DESC")
    else
      @selected = params[:format]
      @transactions = Transaction.get_specific_type(params[:format])
      @total = Transaction.get_total(@transactions)
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  ### CREATE ###
  def new
    @officers = Officer.order("name ASC")
    @transaction = Transaction.new
    #@transaction.transactionDate = DateTime.now
  end

  def create
    @officers = Officer.order("name ASC")

    @transaction = Transaction.new(transaction_params)
    #@transaction.transactionDate = DateTime.now

    # Make sure associated member, officer, and semester exist
    if valid_relations(@transaction)
      if @transaction.save
        flash[:notice] = "transaction Successfully Created!"
        redirect_to(transactions_path)
      else
        flash[:errors] = "Invalid fields"
        render("new")
      end
    else
      flash[:errors] = "Invalid officer"
      render("new")
    end
  end

  ### UPDATE ###
  def edit
    @transaction = Transaction.find(params[:id])
    @officers = Officer.order("name ASC")
  end

  def update
    @transaction = Transaction.find(params[:id])
    @officers = Officer.order("name ASC")

    if @transaction.update(transaction_params)
      flash[:notice] = "transaction Successfully Updated!"
      redirect_to(transactions_path)
    else
      flash[:errors] = "Invalid fields"
      render("edit")
    end
  end

  ### DELETE ###
  def delete
    @transaction = Transaction.find(params[:id])
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    flash[:notice] = "Transaction has been deleted"
    redirect_to(transactions_path)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:officer_id, :transaction_amount, :transaction_date, :transaction_type, :transaction_category)
  end

  def valid_relations(form_record)
    officer_exists = Officer.exists?(id: form_record.officer_id)

    if officer_exists
      true
    else
      false
    end
  end
end
