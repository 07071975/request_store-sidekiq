require "request_store"
require "sidekiq"

require "request_store/sidekiq/version"
require "request_store/sidekiq/server_middleware"
#added for test
require "request_store/sidekiq/client_middleware"
require "request_store/sidekiq/railtie" if defined?(Rails::Railtie)

module RequestStore
  module Sidekiq
    def self.add_custom_middleware!
      ::Sidekiq.configure_client do |config|
        config.client_middleware do |chain|
          chain.add ClientMiddleware
        end
      end
      ::Sidekiq.configure_server do |config|
        config.client_middleware do |chain|
          chain.add ClientMiddleware
        end
        config.server_middleware do |chain|
          chain.add ServerMiddleware
        end
      end
    end
  end
end
