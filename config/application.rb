require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller
    @moesif_options = {
      'application_id' => 'Your Moesif Application Id',
      'debug' => false,
      'capture_outoing_requests' => false,
      'log_body' => true,
      'log_body_outgoing' => true
    }

    @moesif_options['identify_user'] = Proc.new{|env, headers, body|
      'my_user_id'
    }

    @moesif_options['identify_company'] = Proc.new{|env, headers, body|
      'my_company_id'
    }

    @moesif_options['identify_session'] = Proc.new{|env, headers, body|
      'session1'
    }

    @moesif_options['get_metadata'] = Proc.new{|env, headers, body|
      {
        'foo' => '123'
      }
    }

    @moesif_options['get_metadata_outgoing'] = Proc.new{|request, response|
      {
        'capture_outgoing' => 'true'
      }
    }

    @moesif_options['identify_user_outgoing'] = Proc.new{|request, response|
      'outgoing_user_id'
    }

    @moesif_options['identify_company_outgoing'] = Proc.new{|request, response|
      'outgoing_company_id'
    }

    @moesif_options['identify_session_outgoing'] = Proc.new{|request, response|
      'outgoing_session_token'
    }

    @moesif_options['skip_outgoing'] = Proc.new{|request, response|
      false
    }

    @moesif_options['mask_data_outgoing'] = Proc.new{|event_model|
      event_model
    }

    def self.moesif_options
      return @moesif_options
    end

    config.middleware.insert_before Rails::Rack::Logger, MoesifRack::MoesifMiddleware, @moesif_options

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
