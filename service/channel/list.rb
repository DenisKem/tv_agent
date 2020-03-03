module Service
  module Channel
    class List
      attr_reader :channels

      def initialize
        @channels = parse_channels
      end

      private

      def parse_channels
        lines = File.readlines(ENV["CHANNELS_FILE_PATH"]).map(&:strip)
        
        names =
          lines.select.with_index { |l, i| i.even? }
            .map { |line| line.split(",") }
            .map(&:last)

        addresses =
          lines.select.with_index { |l, i| i.odd? }

        names.zip(addresses).to_h
      end
    end
  end
end
