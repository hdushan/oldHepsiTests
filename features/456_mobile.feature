Feature: 456 - Using Legacy site links on mobile page
  As a mobile user
  I should be able to use original site links

  Scenario: Check for original prices on deal of the day carousel
    Given I visit mobile main page
    And I am at mobile main page

  Scenario Outline: Visit mobile site with links from legacy site
    When I use this link form old site to access mobile site "<link>"
    Then I don't get the error page
    Examples:
    | link |
    | /liste/sony-playstation-4-500-gb-oyun-konsolu/productDetails.aspx?productId=oyunsonyplays4&categoryId=60003892&SKU=OYUNSONYPLAYS4 |
    | /liste/prima-bebek-bezi-aktif-bebek-aylik-paketi-cesitleri-prima-islak-havlu-hediyeli-/productDetails.aspx?productId=zypyon2897&categoryId=60001049&SKU=ZYPYON2897 |
    | /liste/petlas-175-70-r13-82t-snow-master-w601-kis-oto-lastigi-uretim-yili-2014-/productDetails.aspx?productId=otozsu20550&categoryId=259720&SKU=OTOZSU20550 |
    | /liste/mini-masallar-seti-3-10-kitap/productDetails.aspx?productId=ktimas43484&categoryId=9928&SKU=KTIMAS43484 |
    | /liste/ceyrek-altin-kulplu/productDetails.aspx?productId=eakszynt7&categoryId=16032976&SKU=EAKSZYNT7 |