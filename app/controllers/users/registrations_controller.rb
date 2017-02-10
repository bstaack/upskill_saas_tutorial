class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  
  #extend default devise gem behavior so users signing up with pro account (planid2)
  #save with a special stripe subscription function.
  #otherwise devise signs up user as usual.
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end  
      end
    end  
  end
  
  private
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a memebership plan to sign up."
        redirect_to root_path
      end  
    end
end  