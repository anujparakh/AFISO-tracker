class PaymentsController < ApplicationController
  
  ### READ ###
  def index
    @payments = Payment.order("created_at ASC")
  end

  def show
    @payment = Payment.find(params[:id])
  end


  ### CREATE ###
  def new
    @payment = Payment.new
    @payment.paymentDate = DateTime.now
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.paymentDate = DateTime.now

    # Make sure associated member, officer, and semester exist
    if valid_relations(@payment)
      if @payment.save
        redirect_to(payments_path)
      else
        render('new')
      end
    else
      render('new')
    end
  end


  ### UPDATE ###
  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])

    if valid_relations(@payment)
      if @payment.update(payment_params)
        redirect_to(payment_path(@payment))
      else
        render('edit')
      end
    else 
      render('edit')
    end
  end

  ### DELETE ###
  def delete
    @payment = Payment.find(params[:id])
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    redirect_to(payments_path)
  end

  private
    
    def payment_params
      params.require(:payment).permit(:member_id, :semester_id, :officer_id, :paymentAmount)
    end

    def valid_relations(form_record)
      semester_exists = Semester.exists?(id: form_record.semester_id)
      officer_exists = Officer.exists?(id: form_record.officer_id)
      member_exists = Member.exists?(id: form_record.member_id)
      if semester_exists && officer_exists && member_exists
        true
      else
        false
      end
    end

end
