class ChargesController < ApplicationController
  before_action :authenticate_user!

  DEFAULT_AMOUNT = 15_00

  def new
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: "BigMoney Membership - #{current_user.email}",
      amount: DEFAULT_AMOUNT
    }
  end
# rubocop:disable MethodLength
  def create # Creates a Stripe Customer object, for associating # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: DEFAULT_AMOUNT,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
    current_user.update_attributes(role: 'premium') unless current_user.role == 'premium'
    flash[:notice] = "Thanks for all the money, #{current_user.email}.  Pay me some more!"
    redirect_to root_path
    rescue Stripe::CardError => e
      current_user.update_attribute(:role, 'standard')
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
