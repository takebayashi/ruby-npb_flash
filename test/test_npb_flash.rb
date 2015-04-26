require 'minitest_helper'

class TestNpbFlash < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::NpbFlash::VERSION
  end

  def test_crawler_fetches_6_games
    crawler = NpbFlash::Crawler.new(Date.new(2015, 3, 27))
    metadata = crawler.get_metadata
    assert metadata.size == 6
  end
end
