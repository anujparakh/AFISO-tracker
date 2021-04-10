# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def help; end

  def settings
    @officers = Officer.order('email ASC')
    @officer = Officer.new
    @semester = "None"

    if params[:theme] != nil
      if params[:theme] == "dark"
        cookies[:theme] = "dark"
      else
        cookies[:theme] = "light"
      end
      flash[:notice] = "Changed to " + cookies[:theme] + " mode"
    end
  end

  def members
    #delete inactive members that havent been active since the semesters
    @semester = params[:semester]
    # do filtering and then deleting
    # @semester = Semester.find(@semester)
    if @semester != "None"
      @members = deleteInactive(@semester)
      Member.where(:id => @members).destroy_all
    end
    redirect_to('/home/settings', notice: "Old inactive members in the semester were removed")
  end

  def deleteInactive(semester)
    # look at payments for given semester
    @semester = Semester.find(semester)
    @payments = Due.where(semester_id_1: @semester.id).or(Due.where(semester_id_2: @semester.id))
    active_ids = []
    @payments.each_with_index do |payment, index|
      active_ids.push(payment.member_id)
    end
    # grab members who made payments in given semester
    @members = []
    @all_members = Member.order('name ASC')
    isactive = false
    @all_members.each_with_index do |member, index|
      isactive = false
      active_ids.each_with_index do |active, index|
        if(member.id == active)
          isactive = true
        end
      end
      if(!isactive)
        @members.push(member)
      end
    end
    return @members
  end


end
