class UsersController < ApplicationController

before_action :authenticate_user!


  def downgrade
    current_user.update_attribute(:role, 'standard')
    flash[:notice] = "Account downgraded"

    redirect_to (root_path)
  end


end
