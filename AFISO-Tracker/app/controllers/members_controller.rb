class MembersController < ApplicationController
  before_action :check_for_lockup

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end
  
  def create
	@member = Member.new(member_params)
	name = @member.name
	
	if @member.save
		redirect_to(members_path, notice: "#{name} added to list!")
	else
		render('new')
	end

  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
	     @member = Member.find(params[:id])
	     puts member_params[:published_date]
	     if @member.update(member_params)
		       redirect_to(member_path(@member), notice: "Member information updated!")
	     else
		       render('edit')
	     end
  end

  def delete
    @member = Member.find(params[:id])
  end

  def destroy
	  @member = Member.find(params[:id])
	  @member.destroy
	  redirect_to(members_path, :flash => {notice: "Member deleted from list!"})
  end
  
  private
	def member_params
		params.require(:member).permit(:name, :email)
	end

end

