require 'singleton'
module RPC
  class Config
    include Singleton
    attr_accessor :host, :port, :username, :password, :debug, :transfer_clazz
  end

end
