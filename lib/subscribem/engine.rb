module Subscribem
  class Engine < ::Rails::Engine
    isolate_namespace Subscribem
    require 'warden'
    require 'dynamic_form'

    config.generators do |g|
      g.test_framework :rspec, view_spec: false
    end

    initializer 'subscribem.middleware.warden' do
      Rails.application.config.middleware.use Warden::Manager do |manager|
        manager.serialize_into_session do |user|
          user.id
        end
        manager.serialize_from_session do |id|
          Subscribem::User.find(id)
        end
      end
    end
  end
end
