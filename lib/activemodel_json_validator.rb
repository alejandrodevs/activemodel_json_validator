require 'json-schema'
require 'active_model'

require 'active_model/json_validator/version'
require 'active_model/json_validator/validator'

ActiveSupport.on_load(:i18n) do
  I18n.load_path << File.expand_path('active_model/json_validator/locale/en.yml', __dir__)
end
