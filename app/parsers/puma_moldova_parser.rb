class PumaMoldovaParser
  require 'open-uri'

  def self.call(url)
    new.call(url)
  end

  def call(url)
    fetch(url)
  end

  private

  def fetch(url)
    URI.open(url, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.112 Safari/537.36').read
  end
end