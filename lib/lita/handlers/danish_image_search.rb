module Lita
  module Handlers
    class DanishImageSearch < Handler
      # insert handler code here
 	URL = "https://www.googleapis.com/customsearch/v1"
      	VALID_SAFE_VALUES = %w(high medium off)

      config :safe_search, types: [String, Symbol], default: :high do
       validate do |value|
        unless VALID_SAFE_VALUES.include?(value.to_s.strip)
      "valid values are :high, :medium, or :off"
       end
        end
         end

      route(/(?:image|img)(?:\s+me)? (.+)/i, :fetch, command: true, help: {
        "image QUERY" => "Displays a random image from Google Images matching the query."
      })

      route(/(?:animate|gif)(?:\s+me)? (.+)/i, :fetch_anim, command: true, help: {
        "animate QUERY" => "Displays a random animation from Google Images matching the query."
      })

      def fetch_anim(response)
        fetch(response, true)
      end

      def fetch(response, animated = false)
        query = response.matches[0][0]

  query_params = {
          v: "1.0",
          searchType: 'image',
          q: query,
          safe: config.safe_search,
          fields: 'items(link)',
          rsz: 8,
          cx: 'a0ee38aab0d0f7bcc',
          key: 'AIzaSyDyY2ijQCoSf9z5rqaE2aeKX9Ul-pEUnWQ'
        }

        if animated
          animated_params = {
            fileType: "gif",
            hq: "animated",
            tbs: "itp:animated"
          }
          query_params.merge!(animated_params)
        end

        http_response = http.get(
          URL,
          query_params
        )

        data = MultiJson.load(http_response.body)

        if http_response.status == 200
  choice = data["items"].sample if data["items"]
          if choice
            response.reply ensure_extension(choice["link"])
          else
            response.reply %{No images found for "#{query}".}
          end
        else
          reason = data["error"]["message"] || "unknown error"
          Lita.logger.warn(
            "Couldn't get image from Google: #{reason}"
          )
        end
      end

      private

      def ensure_extension(url)
        if [".gif", ".jpg", ".jpeg", ".png"].any? { |ext| url.end_with?(ext) }
          url
        else
          "#{url}#.png"
        end
      end
    end

      Lita.register_handler(DanishImageSearch)

  end
end
