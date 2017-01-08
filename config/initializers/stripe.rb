# Store the environment variables on the Rails.configuration object
 # Rails.configuration.stripe = {
 #   publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
 #   secret_key: ENV['STRIPE_SECRET_KEY']
 # }

# Store the environment variables on the Rails.configuration object
 if(Rails.env == 'development' || Rails.env == 'staging')
   Rails.configuration.stripe = {
     publishable_key: ENV['STRIPE_PUBLISHABLE_KEY_TEST'],
     secret_key: ENV['STRIPE_SECRET_KEY_TEST']
   }
 elsif(Rails.env == 'production')
   Rails.configuration.stripe = {
     publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
     secret_key: ENV['STRIPE_SECRET_KEY']
   }
 end

 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.configuration.stripe[:secret_key]
