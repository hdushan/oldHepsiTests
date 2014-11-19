# encoding: UTF-8
  class Footer < SitePrism::Section
    section :social_links, '.social' do
      element :facebook_icon, '.icon-facebook'
      element :linkedin_icon, '.icon-linkedin'
      element :google_plus_icon, '.icon-google-plus'
      element :pinterest_icon, '.icon-pinterest'
      element :instagram_icon, '.icon-instagram'
      element :youtube_icon, '.icon-youtube'
    end
    element :icon_security_link, '.icon-security-link'
    element :copyright_message, '.copyright'
  end

  class DealOfTheDayCarousel < SitePrism::Section
    elements :deals, '.article'
    elements :old_price, '.product-old-price'
  end

  class Header < SitePrism::Section
    section :search, '.home-search-panel' do
      element :field, 'input#productSearch'
      element :button, 'button#buttonProductSearch'
    end

    def search_for(search_term)
      search.field.set(search_term)
      search.button.click
    end
  end

  class Homepage < SitePrism::Page
    set_url ''
    section :header, Header, '.header-wrapper'
    section :dealOfTheDayCarousel, DealOfTheDayCarousel, "div#dealOfTheDayCarousel"
    section :footer, Footer, "footer.footer-global"
  end



