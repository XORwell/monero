module RPC
  class Client

    def self.close!
      request("stop_wallet")
    end

    def self.request(method, params="")
      data = '{"jsonrpc":"2.0","id":"0","method": "'+method+'", "params": '+params.to_json+' }'

      args = ""
      args << " -s"
      args << " -u #{RPC.config.username}:#{RPC.config.password} --digest"
      args << " -X POST #{base_uri}/json_rpc"
      args << " -d '#{data}'"
      args << " -H 'Content-Type: application/json'"

      p "curl #{args}" if RPC.config.debug

      json = JSON.parse(`curl #{args}`)

      # Error handling
      if json["error"]
        raise "#{json["error"]["message"]} | code: #{json["error"]["code"]}"
      end

      json["result"]
    end

    private

    def self.base_uri
      "http://#{RPC.config.host}:#{RPC.config.port}"
    end

  end
end
