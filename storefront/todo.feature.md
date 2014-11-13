@423 @storefront Feature: "Keeping the ""Closest Match"" Functionality on Variants"  --- needs clarification

@295 @storefront Feature: Indicate which filter is on  --- needs clarification
@301 @storefront Feature: Split and label variants 

@312 @storefront Feature: Include deactive state for clear -- On Mobile the buttons are only inactive if you do not hover on them

@167 @storefront Feature: Shorten product name   -- Mobile Only
@183 @storefront Feature: Allow Customers to Buy Merchant Offers on Details Page
@189 @storefront Feature: Static announcement banners 

@221 @storefront Feature: Display merchant offers on details page
@315 @storefront Feature: Display non-TL prices (e.g. USD) correctly on results --- Really need DB access for this

@488 @storefront Feature: Display Tax Added Price for On Sale Products --- Just check that product page for discounted product shows original and discounted price?  Can't easily check whether includes tax from front end

@305 @storefront Feature: Browse Categories by 3rd
@428 @storefront Feature: Browse by 4th level

------------------------ In Progress -------------------------
@138 @storefront Feature: Display discount - i.e. original price & percentage on image --Martina working on it
@371 @storefront Feature: Display SEO Friendly Content Area on Category Landing Page--Linda working on it
---------------------------- Done ----------------------------

@16 @storefront Feature: Basic search
@18 @storefront Feature: Display one product price on result
@19 @storefront Feature: Show image for products in results
@23 @storefront Feature: Filter by Price Range
@25 @storefront Feature: Filter by one type of rating
@27 @storefront Feature: Filter by 1st level category
@28 @storefront Feature: Filter by one brand
@51 @storefront Feature: Login using e-mail & password
@56 @storefront Feature: Display product name on details page
@61 @storefront Feature: Display one product image on details page
@62 @storefront Feature: Display basic product description on details page
@67 @storefront Feature: Add one to basket from details page
@68 @storefront Feature: Show Installments by Bank on Details Page
@73 @storefront Feature: Display tech specs on details page
@103 @storefront Feature: Display free shipping on details page
@143 @storefront Feature: Display one product price
@144 @storefront Feature: Display variants on details page
@190 @storefront Feature: "Show ""Deal of the Day"" on Homepage"
@212 @storefront Feature: Separate sort & filter on results
@343 @storefront Feature: Display Filter by Product Specific Attributes
@460 @storefront Feature: "Transform ""Add to Basket"" Button to ""Finish Shopping"" on Click"
@467 @storefront Feature: "Show Undiscounted Price on ""Deal of the Day"""
@481 @storefront Feature: Feedback Mechanism for Beta
@140 @storefront Feature: Display product specific return policy
@47 @storefront Feature: Browse 1st level categories
@48 @storefront Feature: Browse by 2nd-level subcategories
@523 @storefront Feature: Display Campaign Banners in Flyout Menu

-- Some scenarios not tested due to data--
@17 @storefront Feature: Display more search results -- Cannot test 'more' button disappearing due to data
@26 @storefront Feature: Sort by price -- Cannot test scenario 4 due to data, or scenario 5 as it is mobile specific
@31 @storefront Feature: Sort by best selling -- Cannot test order without being able to modify the data
@65 @storefront Feature: Display super fast on details page -- can't test that flag is not visible when product does not have super-fast shipping
@78 @storefront Feature: Display generic return policy on details page -- Could assert content of returns policy as is currently blank
@83 @storefront Feature: Show ratings of a products on details & results -- Cannot check that item without ratings does not show ratings due to data
@84 @storefront Feature: Show comments about a product on details page -- Done, but depends on the test product having more than 3 reviews
@255 @storefront Feature: "Fix ""extra fee"" product pricing" -- Can not test as appears data specific


-- Mobile Scenarios not tested --
@60 @storefront Feature: Display multiple images on details page
@116 @storefront Feature: Remember my basket without login
@246 @storefront Feature: Clear all enabled filters


-- Other elements could not be tested --
@64 @storefront Feature: Display 2-slot/scheduled delivery --- unable to determine whether or not product should satisfy 'same day delivery' conditions without DB access
@248 @storefront Feature: Footer -- Cannot test order tracking appearing in footer as do not have a login
@276 @storefront Feature: Understand old category page URLs -- Story empty on mingle
@373 @storefront Feature: "Display Top ""10"" Discounted Items of a Category on Category Landing Page" -- it looks like the 'swipe' scenario doesn't apply to the category landing page
@372 @storefront Feature: Display Top Sellers of a Category on Category Landing Page --- need to check what the 'sorting displayed products' scenario refers to
@358 @storefront Feature: Error Handling for Merchant Listings on Details Page --- need to be able to control other services (stubs?)


-- Test judged to be not required ---
@261 @storefront Feature: Remove filter & sort on 0 results
@263 @storefront Feature: Turn off native auto suggest