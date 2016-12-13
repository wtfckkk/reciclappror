class PagesController < ApplicationController
  def welcome
  end

  def contact
  end

  def team
  end
  def index
		if current_user.user_type == 'admin'
			redirect_to pages_admin_path
		else
		 	redirect_to new_order_path
		end
	end
  def admin
    if current_user.user_type == 'admin'
      @orders = Order.where.not(:status => "pre")
    else
      redirect_to new_order_path
    end
  end
end
