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
      flash.now[:notice] = "Changed to " + cookies[:theme] + " mode"
    end
  end

  def members
    if (params[:semester] == "None") || (params[:semester2] == "None")
      flash[:error] = "Select both semesters"
      redirect_to('/home/settings')
      return
    end
    #delete inactive members that havent been active since the semesters
    @semester = params[:semester]
    @semester2 = params[:semester2]
    # do filtering and then deleting
    # @semester = Semester.find(@semester)
    if (@semester != "None") && (@semester2 != "None")
      @members = deleteInactive(@semester, @semester2)
      Member.where(:id => @members).destroy_all
    end
    redirect_to('/home/settings', notice: "Old inactive members were removed")
  end

  def deleteInactive(semester, semester2)
    # look at payments for given semester
    @semester = Semester.find(semester)
    @semester2 = Semester.find(semester2)
    @payments = Due.where(semester_id_1: @semester.id).or(Due.where(semester_id_2: @semester.id))
    @payments2 = Due.where(semester_id_1: @semester2.id).or(Due.where(semester_id_2: @semester2.id))

    # gets a list of members that were active in the first semester (ideally the older semester)
    active_ids = []
    @payments.each_with_index do |payment, index|
      active_ids.push(payment.member_id)
    end


    # gets a list of members that were active in the second semester (ideally the more recent semester)
    active_ids_2 = []
    @payments2.each_with_index do |payment, index|
      active_ids_2.push(payment.member_id)
    end

    # gets a list of members that were inactive in the second semester (ideally the more recent semester)
    @all_members = Member.order('name ASC')
    inactive_ids_2 = []
    inactive_in_2 = true
    @all_members.each_with_index do |member, index|
      inactive_in_2 = true
      active_ids_2.each_with_index do |active_mem_in_2, index|
        if (member.id == active_mem_in_2)
          inactive_in_2 = false
        end
      end

      if (inactive_in_2)
        inactive_ids_2.push(member.id)
      end
    end


    # grab members who made payments in the first semester and did NOT make a payment in the second semester
    @members_to_delete = []
    may_be_removed = false
    will_be_removed = false
    @all_members.each_with_index do |member, index|
      may_be_removed = false
      will_be_removed = false
      
      # checks if a particular member is in our list of active id's for semester 1
      active_ids.each_with_index do |mem_id, index|
        if(member.id == mem_id)
          may_be_removed = true
        end
      end

      # checks if a particular member is NOT in our list of active id's for semester 2, but WAS in the list for semester 1
      if(may_be_removed)
        inactive_ids_2.each_with_index do |mem_id, index|
          if (member.id == mem_id) 
            will_be_removed = true
          end
        end
      end

      if(will_be_removed)
        @members_to_delete.push(member)
      end
    end
    return @members_to_delete
  end


end
