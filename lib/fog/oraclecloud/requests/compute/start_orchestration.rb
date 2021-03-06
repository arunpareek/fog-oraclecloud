module Fog
  module Compute
    class OracleCloud
      class Real
      	def start_orchestration (name)
          if !name.start_with?("/Compute-") then
            # They haven't provided a well formed name, add their name in
            name = "/Compute-#{@identity_domain}/#{@username}/#{name}"
          end   
          request(
            :method   => 'PUT',
            :expects  => 200,
            :path     => "/orchestration#{name}?action=start",
            :headers  => {
              'Content-Type' => 'application/oracle-compute-v3+json'
            }
          )
      	end
      end

      class Mock
        def start_orchestration (name)
          response = Excon::Response.new
          clean_name = name.sub "/Compute-#{@identity_domain}/#{@username}/", ''

          if self.data[:orchestrations][clean_name] 
            self.data[:orchestrations][clean_name]['status'] = 'running'
            instance = self.data[:orchestrations][clean_name]
            response.status = 200
            response.body = instance
            response
          else
            raise Fog::Compute::OracleCloud::NotFound.new("Orchestration #{name} does not exist");
          end
        end
      end
    end
  end
end
