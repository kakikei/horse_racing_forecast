module Batch
  class HorseInformationScraper
    BASE_URL = 'https://db.netkeiba.com'
    TOP_URL = BASE_URL + '?pid=horse_top'
    require 'open-uri'

    def self.run
      top_page = Nokogiri::HTML.parse(URI.parse(TOP_URL).open)
      horses = top_page.css('.db_table > tbody').map do |ele|
        ele.children.map do |c|
          begin
            name = c.search('a').first.inner_text
            url = BASE_URL + c.search('a').first.attributes['href'].value
            horse_params(name, url)
          rescue
            next
          end
        end
      end.flatten.reject(&:blank?)

      Horse.upsert_all(horses, unique_by: :name)
      horse_details = horse_all.map do |horse|
        doc = Nokogiri::HTML.parse(URI.parse(BASE_URL + horse.url).open)
        children = doc.css('.db_h_race_results > tbody').first.children
        results = children.map { |c| c.inner_text.split }.reject(&:blank?)
        race_params(results, horse)
      end
      HorseDetail.upsert_all(horse_details)
    end

    def horse_all
      @horse_all ||= Horse.all
    end

    def horse_params(name, url)
      {
        name: name,
        url: url
      }
    end

    def race_params(d, horse)
      {
        horse: horse,
        date: d[0].to_date,
        weather: d[2],
        race_name: d[4],
        ranking: d[6].to_i,
        popularity: d[9].to_i,
        jockey: d[11],
        race_condition: d[13].slice(0),
        race_distance: d[13].slice(1..d[13].length).to_i,
        time: convert_to_seconds(d[16].split(/[:|.]/)),
        dressing_difference_time: d[17].to_f,
        body_weight: d[22].split('(').first.to_i
      }
    end

    def convert_to_seconds(time)
      case time.length
      when 2 then
        time[0].to_i + time[1].to_i / 10.0
      when 3 then
        time[0].to_i * 60 + time[1].to_i + time[2].to_i / 10.0
      end
    end
  end
end
