--------------Any Assumptions made about cards ------------------

@19 All products have images

@56 assuming URL is correct as currently implemented, not as given in scenario 2 --- not tested

@61 assumes that the image filename (i.e. telephon_15322435.jpg) is the same for all image resolutions
@62 assumes that product always has a description

@116 This story was intended to include the preservation of the shopping cart when returning to the site after leaving as AC
@116 Scenario 2, showing the visual indication on cart has been moved to #244

@141 refers to the 'Only' filter rather than 'Shipping style' which does not appear to be present on the page

@248 A login link is no longer required in the footer

@276 Nothing to test for this as it appears to be a placeholder

@373 Div containing offer flags should be distinguished by a class

@460 Should create two buttons, one to add another item and one to go to the cart
@460 When adding two of the same item to the cart, that item should only appear once in the cart but with a quantity of 2

@467 We assume that all items in the 'deal of the day' list should have a discounted price, and hence an original price. (not the case in the QA environment, as of 2014-10-28)

@140 We have assumed that the presence of the text "İncelediğiniz ürün, Mesafeli Sözleşmelere Dair Yönetmeliğin 7." 
     (rough translation: "Products you have viewed , the Regulation on Distance Contracts 7 .") is enough to be certain
     specific returns policy are displayed for the media product in question

@47 We assume that the text inside the main navbar will remain as it currently is, we select "Elektronik Beyaz Eşya" and
    then click on "", finally we assume that checking a page has the title "Bilgisayar Fiyatları ve Modelleri & 
    %45 indirim & Taksit Avantajı" is sufficient to assert we have navigated to the correct page.
     
@47/@448 
    We have assumed that identifying the presence of the 1st level navigation by checking the presence of the selector 
    .browser-by-category and assert there are 9 entries in the navbar.
     
@48/@448
    We assume that hovering over a category in the nav bar and clicking on a second level category then checking the 
    title of a the new page is sufficient to assert that you can navigate to second level categories.
     
@448 For the AC "Using escape fragments for seo" our reading determined we would have to create a new user agent to view
     the website as a Google Bot. When compared with the other tests remaining it was decided that effort could be better
     used elsewhere. Same rationale for AC "Analytics"

@144 We assume that a radio button being checked is sufficient to assert that a user can select a product variant. 
     Previous tests were looking for URL changes which appears to not be the case.

@523 We assume that finding the "flyout-campaign-wrapper" class is sufficient when hovering on the 2nd level category menu.

@189 We assume that finding the static banner and its list elements by its class ('.static-banners li') and asserting 
     that there exists at least to elements is sufficient to assert that the static banners are displayed.    
     
@428 We assume that navigating by home page -> Electronic Appliances -> Computer -> Computer Components -> Memory (RAM)
     and then checking for the presence of the RAM breadcrumb id ('breadcrumbFor-47') is sufficient to assert correct 
     navigation.     
     
@466 We assume there is value in asserting the product image in the carousel is of the expected size.
     For asserting that clicking the banners lead to a new page we assume that storing the current URL clicking on a 
     banner and checking the new URL is different from the previous is sufficient to assert banner navigation.
     For asserting the thumbnails work for changing banners, we assume that getting the image src for the first banner,
     clicking the second thumbnail and making sure the img src is different is sufficient to assert that changing banners
     via thumbnails is working.
     
@429 We assume that navigating to the RAM subcategory (Home | Computer | Components | Computer Memory ( RAM )), then 
     clicking "Components" and asserting that the title of the page == to the the expected component title is sufficient 
     to assert the functionality of breadcrumb navigation

@137 We assume that there will always be a product that has variants when searching for Samsung. We also assume that testing
     for the class 'product-with-variant' is sufficient to test if a product has variations.
     
@137 For the second test for story 137, we assume that the specific product being searched will never have variants, and therefore the product
     variant class will never be found.

@658 Both relevant acceptance criteria have been tested by shrinking the size of the window and assert there is no 
     horizontal scrollbar. I assume this is what was meant when the term responsive was used, additionally, checking for
     no horizontal scrolling should be more robust than checking for specific ordering of elements.

@42  We assume that testing that the discount badge being present is sufficient for testing that the discount percentage
     is displayed. The acceptance criteria for the discount badge not being present on a product out of stock was not
     tested because there are no products that will be consistently out of stock. We might need to stub the data for this
     test from Fredhopper or the db, or move the test out of the regression test suite. 

@695 The test for the referel URL was redundant since nothing more than actually visiting the URL was happening. Thus the
     test was only giving the URL (with a referel)to visit and then testing that the URL had the referel property set on
     the header. This is why there is no explicit test for referel URLs.

@97  We assume that testing for the class of the whole section which displays "Bestsellers" is sufficient enough to know
     that the bestsellers section is being displayed on a product page.

@118 We assume that testing for the ID and default value for the quantity spinner are sufficient to test for the ability
     to indicate the product quantity the customer wants. 

@33  There is an acceptance criteria stating "Search should still work without search suggestions if FredHopper is 
     unavailable". This has not been tested due to not being able to easily programmatically disable Fredhopper and 
     manually intercepting the Ajax was deemed to much work for the reward with other functionality requiring testing.
     
@384 AC for the sitemap xml story requires the file to be validated by Google tools making automated testing troublesome.