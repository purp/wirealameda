class PageController < ApplicationController
  def news
    @page_title = 'News'
    blog_url = 'http://purp.typepad.com/wirealameda'
    moz_user_agent = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_4_11; en) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10'
    doc = Nokogiri::HTML(open(blog_url, 'User-Agent' => moz_user_agent))
    @news = doc.at("//div[@id='pagebody']").inner_html
  end

  def home
    @page_title = 'Home'
  end

  def learn
    @page_title = 'Learn More'
  end

  def get_involved
    @page_title = 'Get Involved'
  end

  def about
    @page_title = 'About'
  end

end
