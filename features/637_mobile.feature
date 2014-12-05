#encoding: UTF-8

Feature: 637 - Use legacy site urls in mobile site
  As a campaign manager
  I want to redirect old websites brand filtered urls to mobile website
  So that i can make proper mail marketing

  Scenario: Go to mobile main page
    Given I visit mobile main page
    Then I am at mobile main page

  Scenario Outline: Use some single brand filtered links from old site on new site
    When I use this link form old site to access mobile site "<link>"
    Then I am on results mobile page
    And These filters are present on mobile page "<brand-list>"
  Examples:
    | link                                                                                                             | brand-list |
    | /liste/dark-bilgisayarlar/department.aspx?categoryId=3000500&qs=%2fbrand%3d%7bdark%7d                            | Dark       |
    | /liste/matras-erkek/department.aspx?categoryId=12087177&qs=%2fbrand%3d%7bmatra015f%7d                            | Matraş     |

  Scenario Outline: Use multiple brand filtered links from old site on mobile site
    When I use this link form old site to access mobile site "<link>"
    Then I am on results page
    And These filters are present on mobile page "<brand-list>"
  Examples:
    | link                                                                                                                 | brand-list |
    | /liste/bilgisayarlar/department.aspx?categoryId=3000500&qs=%2fbrand%3d%7bdark%3btoshiba%7d                           | Dark - Toshiba       |
    | /liste/fotograf-makinesi-cantalari/department.aspx?categoryId=81481&qs=%2fbrand%3d%7bvanguard%3blowepro%3bsamsung%7d | Lowepro - Vanguard - Samsung  |