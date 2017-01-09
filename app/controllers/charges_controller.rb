class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user.email}",
     amount: Amount.default
   }
  end

  class Amount
    def self.default
      @amount = 15_00
    end
  end

  def create
    @user = current_user
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
    @user.change_user_role(1)
    flash[:notice] = "Thank you for signing up, #{current_user.email}! You are now a premium member."
    redirect_to user_path(current_user)

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def cancel_subscription
    @user = current_user
    @user.downgrade
    flash[:notice] = "#{current_user.email}, your premium membership has been cancled. All of your private wikis are now public."
    redirect_to user_path(current_user)
  end



end
