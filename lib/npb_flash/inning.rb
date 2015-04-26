module NpbFlash

  class Inning
    include Comparable

    attr_accessor :events, :id, :title

    def initialize(id, title, team)
      @id = id
      @title = title
      @team = team
      @events = []
    end

    def inning_index
      @id.match(/[\d]+$/)[0].to_i
    end

    def top?
      @id.match(/^[i]+/)[0].size == 1
    end

    def bottom?
      not self.top?
    end

    def inning
      [self.inning_index, self.top? ? :top : :bottom]
    end

    def <=>(other)
      e =  self.inning_index <=> other.inning_index
      if e == 0
        if self.top?
          if other.top?
            e = 0
          else
            e = -1
          end
        else
          if other.top?
            e = 1
          else
            e = 0
          end
        end
      end
      e
    end

    def self.from_node(node)
      id = node['id']
      title = node.xpath('.//h3/b/text()')[0].text
      team = node['class'].split(' ')[1]
      inning = Inning.new(id, title, team)
      node.xpath('./ul/li').each do |li|
        raw_text = li.text
        text_index, text = raw_text.split('：', 2)
        inning.events.push(text)
      end
      inning
    end

  end

end
