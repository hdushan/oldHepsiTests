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
     
@47 We have assumed that identifying the presence of the 1st level navigation by checking the presence of the selector 
    .browser-by-category combined with the presence of the text "Elektronik Beyaz Eşya", "Ev, Yaşam Ofis" and 
    "Oto, Bahçe Yapı Market" is sufficient. 
    
@47 We assume that the text inside the main navbar will remain as it currently is, we select "Elektronik Beyaz Eşya" and
    then click on "", finally we assume that checking a page has the title "Bilgisayar Fiyatları ve Modelleri & 
    %45 indirim & Taksit Avantajı" is sufficient to assert we have navigated to the correct page.
    
@144 We assume that a radio button being checked is sufficient to assert that a user can select a product variant. 
     Previous tests were looking for URL changes which appears to not be the case.
     
@48 We assume that hovering over a category in the nav bar and clicking on a second level category then checking the 
    title of a the new page is sufficient to assert that you can navigate to second level categories. 