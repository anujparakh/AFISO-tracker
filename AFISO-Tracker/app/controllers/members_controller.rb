class MembersController < ApplicationController
  def index
  end

  def show
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
  end

  def delete
  end
  
  private
	def member_params
		params.require(:member).permit(:name, :email)
	end
end
