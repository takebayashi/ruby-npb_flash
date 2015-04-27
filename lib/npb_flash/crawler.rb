require 'npb_flash/game'
require 'npb_flash/inning'

module NpbFlash

  class Crawler

    def initialize(date = Date::today)
      @date = date
    end

    def get_metadata
      uri = 'http://baseball.yahoo.co.jp/npb/schedule/?date=' + @date.strftime('%Y%m%d')
      begin
        doc = Nokogiri::HTML(open(uri), uri, 'utf-8')
      rescue OpenURI::HTTPError => e
        return nil
      end
      metadata = doc.xpath('//div[@id="gm_sch"]//table[@class="teams"]').map do |g|
        visitor, home = g.xpath('.//tr//th[1]//a/div/@class').map do |s|
          s.text.split(/\s/)[1]
        end
        ref = g.xpath('.//table[@class="score"]//tr[2]//a')
        if ref.size == 1
          id = ref[0]['href'].match(/[\d]+/)[0]
          {
            id: id,
            home: home,
            visitor: visitor
          }
        else
          nil
        end
      end
      metadata.compact
    end

    def get_game(id)
      uri = 'http://baseball.yahoo.co.jp/npb/game/' + id + '/text'
      begin
        doc = Nokogiri::HTML(open(uri), uri, 'utf-8')
      rescue OpenURI::HTTPError => e
        return nil
      end
      Game::from_node(doc, id)
    end

    def get_game_by_team(team)
      meta = get_metadata.find do |m|
        m[:home] == team or m[:visitor] == team
      end
      meta.nil? ? nil : get_game(meta[:id])
    end

  end

end
