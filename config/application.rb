require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VideoShare
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    # carrierwaveのおまじない
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    #libを読み込む
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    #Ajaxが読み込めない場合に画面遷移させる。
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
