module Service
  module Channel
    class List
      def channels
        lines = File.readlines(ENV["CHANNELS_FILE_PATH"]).map(&:strip)
        
        names =
          lines.select.with_index { |l, i| i.even? }
            .map { |line| line.split(",") }
            .map(&:last)

        addresses =
          lines.select.with_index { |l, i| i.odd? }

        names.zip(addresses).map do |name, address|
          { name: name, address: address}
        end  
      end
    end
  end
end