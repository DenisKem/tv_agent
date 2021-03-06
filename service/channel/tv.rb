class Service::Tv
  def initialize(channels_list)
    @channels_list = channels_list
    @vlc_pid = nil
  end

  def switch_to(next_channel)
    address = @channels_list.fetch(next_channel)
    stop_current
    open address
  end

  def stop_current
    Process.kill('INT', @vlc_pid) if @vlc_pid
    @vlc_pid = nil
  end

  private

  def open(address)
    @vlc_pid = spawn("vlc #{address} --fullscreen")
    Process.detach(@vlc_pid)
  end
end
