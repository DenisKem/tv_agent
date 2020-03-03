require "sinatra"
require_relative "service/channel/list"
require_relative "service/channel/tv"

channels_list = Service::Channel::List.new
tv = Service::Tv.new(channels_list.channels)

get '/' do
  @channels = channels_list.channels
  haml :home
end

post "/tv/on" do
  tv.switch_to(params[:next_channel])
  
  redirect to("/")
end

post "/tv/off" do
  tv.stop_current

  redirect to("/")
end
