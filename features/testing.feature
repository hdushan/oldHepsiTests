
Feature: Test
  @blah2 @blah1
  Scenario: Test things 1
    Given I test things one

  Scenario: Test things 1
    Given I test things one



        Scenario: Browse to a category
          Given I visit mobile main page
          When I navigate to Mobile_Category
            | Foto / Kamera  |
          Then I select a sub category in mobile
            | Aksesuarlar | Fotoğraf Makinesi Çantaları | SLR Omuz Çantaları |