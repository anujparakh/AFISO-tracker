# frozen_string_literal: true

class MembersController < ApplicationController
  # before_action :check_for_lockup

  def index
    @searchVal = ''
    if !params[:semesterId].nil? && (params[:semesterId] != 'None')
      @selected = params[:semesterId]
      @members = Member.get_active_in_semester(params[:semesterId])
    elsif !params[:search].nil?
      @searchVal = params[:search]
      @members = Member.all.where('lower(name) LIKE ? OR lower(email) LIKE ?', "%#{@searchVal.downcase}%",
                                  "%#{@searchVal.downcase}%").order('name ASC')
    else
      @selected = 0
      @members = Member.order('name ASC')
    end
    @mailing_list = generate_mailing_list(@members)
  end

  def show
    @semesters_active = Member.member_active_in_semesters(params[:id])
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
      flash[:error] = 'Invalid Fields'
      render('new')
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to(members_path, notice: 'Member information updated!')
    else
      flash[:error] = 'Invalid Fields'
      render('edit')
    end
  end

  def delete
    @member = Member.find(params[:id])
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to(members_path, flash: { notice: 'Member deleted from list!' })
  end

  private

  def member_params
    params.require(:member).permit(:name, :email)
  end
end
