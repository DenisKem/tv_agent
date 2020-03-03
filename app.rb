require "sinatra"
require_relative "service/channel/list"

get '/' do
  @channels = Service::Channel::List.new.channels
  haml :home
end
