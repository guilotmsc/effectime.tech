require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Business
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths << Rails.root.join('lib')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.enabled = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.action_mailer.default_url_options = { host: 'http://157.245.8.44', port: 4060 }
      # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        address:              'smtp.gmail.com',
        port:                 587,
        domain:               'gmail.com',
        user_name:            'guilotmsc@gmail.com',
        password:             'raposa280975',
        authentication:       :plain,
        enable_starttls_auto: true,
    }

    config.exception_handler = { dev: true }

    # config.exception_handler = {
    #   dev:        nil, # allows you to turn ExceptionHandler "on" in development
    #   db:         nil, # allocates a "table name" into which exceptions are saved (defaults to nil)
    #   email:      nil, # sends exception emails to a listed email (string // "you@email.com")

    #   # Custom Exceptions
    #   custom_exceptions: {
    #     #'ActionController::RoutingError' => :not_found # => example
    #   },

    #   # This is an entirely NEW structure for the "layouts" area
    #   # You're able to define layouts, notifications etc ↴

    #   # All keys interpolated as strings, so you can use symbols, strings or integers where necessary
    #   exceptions: {

    #     :all => {
    #       layout: "403", # define layout
    #       notification: true, # (false by default)
    #       deliver: #something here to control the type of response
    #     },
    #     :4xx => {
    #       layout: nil, # define layout
    #       notification: true, # (false by default)
    #       deliver: #something here to control the type of response    
    #     },    
    #     :5xx => {
    #       layout: "exception", # define layout
    #       notification: true, # (false by default)
    #       deliver: #something here to control the type of response    
    #     },
    #     500 => {
    #       layout: "exception", # define layout
    #       notification: true, # (false by default)
    #       deliver: #something here to control the type of response    
    #     },

    #     # This is the old structure
    #     # Still works but will be deprecated in future versions

    #     501 => "exception",
    #     502 => "exception",
    #     503 => "exception",
    #     504 => "exception",
    #     505 => "exception",
    #     507 => "exception",
    #     510 => "exception"

    #   }
    # }
  end
end