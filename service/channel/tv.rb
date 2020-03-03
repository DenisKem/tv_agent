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

  private

  def stop_current
    Process.kill('INT', @vlc_pid) if @vlc_pid
  end

  def open(address)
    @vlc_pid = spawn("vlc #{address} --fullscreen")
    Process.detach(@vlc_pid)
  end
end
