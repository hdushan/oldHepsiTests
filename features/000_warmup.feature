#encoding: UTF-8
Feature: Warmup so that the tests run smoother

  Scenario: Set default wait time
    Then I set default wait time to "10" seconds

  Scenario Outline: Hover an menu items and check content
    Given I visit main page on warmup
    And I hover on menu item "<item>" for warmup
    When I store links from this menu item on warmup
    Then I visit these links on warmup
  Examples:
    | item                    |
    | Elektronik              |
    | Ev, Yaşam Ofis          |
    | Oto, Bahçe Yapı Market  |
    | Anne, Bebek Oyuncak     |
    | Spor Outdoor            |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |
    | Kitap, Müzik Film, Hobi |
    | Giyim, Takı Aksesuar    |

    Scenario Outline: I search for items on warmup
      Given I visit main page on warmup
      When I make a search for item "<item>" on warmup
      Then I open search result no "1" on warmup
      Examples:
      | item |
      | AILEABC941 |
      | AILEBABYJEMBJ01785 |
      | AILEBNDBL2401 |
      | AILENUK725459M |
      | altın |
      | ayakkabı |
      | AYKP38462CGBBZ37 |
      | BD800472 |
      | BD800476 |
      | bebek bezi |
      | cd |
      | deterjan |
      | EAKMETGM153-90190 |
      | EAKSAN1MP-VP80V0 |
      | EVSAM32H5373 |
      | FTKAMEVERST1 |
      | GYPI23RL16BEM |
      | iPhone |
      | kedi maması |
      | KIMGE033 |
      | kitap |
      | kitap |
      | KTIMAS43484 |
      | kulaklık |
      | köpek maması |
      | Michelin lastik |
      | MTARCELIK6230BULAS |
      | MTSUNOCKE03 |
      | OUTHZTTPVFOT-03 |
      | OUTPA80156 |
      | OYUNAR522 |
      | PTTROPP-1710 |
      | saat |
      | samsung |
      | sennheiser |
      | SGBABYLISS087307 |
      | sony |
      | Spigen sgp galaxy note 4 |
      | TELCEPNOKLU620-B |
      | TELCEPSAMN9000-B |
      | TELKULSENN10109 |
      | terlik |
      | TV |
      | usb bellek |
      | yüzük |
      | ZYPYON2897 |
      | ZYPYON400538462 |
      | çakı |
      | çeyrek altın |

  Scenario: Revert to default wait time
    Then I revert to default wait time