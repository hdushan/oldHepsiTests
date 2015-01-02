#encoding: UTF-8
@mobile_journey
  Feature: Sort and more results for mobile

    Scenario: Browse to a category
      Given I visit mobile main page
      When I navigate to Mobile_Category
        | Hobi ve Oyun Konsolları |
      Then I select a sub category in browsing
        | Oyun & Oyun Konsolları | Aksesuarlar | Tümünü Gör |
      When There are some results available

    Scenario: Use more results button
      Given There are "20" results displayed
      When I click load more results
      Then There are more than "20" results

    Scenario Outline: Sort results
      Given I search for "playstation ps 3"
      And There are some results available
      When I sort with "<sort_criteria>" filter on mobile
      Then Results are sorted according to "<sort_criteria>" filter on mobile
      Examples:
      | sort_criteria      |
      | smart              |
      | most-selling       |
      | lowest-price       |
      | highest-price      |


