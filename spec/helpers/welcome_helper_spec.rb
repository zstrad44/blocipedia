RSpec.configure do |config|
   ...
   config.include Devise::Test::ControllerHelpers, type: :controller
   config.include Devise::Test::ControllerHelpers, type: :view
   ...
end

require 'rails_helper'

RSpec.describe WelcomeHelper, type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"
end
