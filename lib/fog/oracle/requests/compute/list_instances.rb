module Fog
  module Compute
    class Oracle
      class Real
      	def list_instances
          response = request(
            :expects  => 200,
            :method   => 'GET',
            :path     => "/instances/Compute-#{@identity_domain}/#{@username}/"
          )
          response
        end
      end
    end
  end
end
