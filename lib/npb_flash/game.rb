module NpbFlash

  class Game

    attr_accessor :home, :visitor, :innings

    def initialize(id)
      @id = id
      @innings = []
    end

    def self.from_node(node, id)
      game = Game.new(id)

      game.visitor, game.home = node.xpath('//div[@id="txt_ibd"]//table/tbody/tr[position() = 2 or position() = 3]/th/@class').map do |t|
        t.text
      end

      game.innings = node.xpath('//div[@id="txt_live"]//div[contains(concat(" ", @class, " "), " item ")]').map do |i|
        Inning::from_node(i)
      end

      game
    end

  end

end
