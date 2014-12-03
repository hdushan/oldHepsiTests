--02/12/2014--
@735 @storefront Feature: Sync master color mappings to Storefront database on a regular basis
@94 @storefront Feature: Display suggested products on product details page

------------------------ In Progress -------------------------
@739 @storefront Feature: Do not show 'Topsellers' and 'Discounted Product' lists on Category Landing Pages -- Lack of categories makes this difficult
@253 @storefront Feature: Filter search results by subcategories - acceptance criteria 2 almost finished apart from last step
@139 @storefront Feature: Show the best instalment option prominently to the customer on product details page

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
@467 @storefront Feature: "Show Undiscounted Price on ""Deal of the Day"""
@481 @storefront Feature: Feedback Mechanism for Beta
@140 @storefront Feature: Display product specific return policy
@47 @storefront Feature: Browse 1st level categories
@48 @storefront Feature: Browse by 2nd-level subcategories
@523 @storefront Feature: Display Campaign Banners in Flyout Menu
@189 @storefront Feature: Static announcement banners
@301 @storefront Feature: Split and label variants
@138 @storefront Feature: Display discount - i.e. original price & percentage on image
@371 @storefront Feature: Display SEO Friendly Content Area on Category Landing Page
@305 @storefront Feature: Browse Categories by 3rd
@428 @storefront Feature: Browse by 4th level
@466 @storefront Feature: Using Carousel images for desktop
@448 @storefront Feature: Mega flyout menu for desktop -- done assumption dependant (two AC not tested)
@429 @storefront Feature: Expose breadcrumbs on category landing pages
@249 @storefront Feature: Display breadcrumbs on product details page
@304 @storefront Feature: See number items in shopping cart as I am shopping
@137 @storefront Feature: See if a product has more options / variants on the the results page
@658 @storefront Feature: Optimise storefront desktop as a responsive site
@42  @storefront Feature: See products discount percentage on results page
@632 @storefront Feature: Change variants selection from dropdown to radio buttons for numbers
@390 @storefront Feature: Change variants selection from dropdown to radio buttons for numbers (Same as @632...?)
@259 @storefront Feature: Show filters applied and allow them to be cleared individually
@113 @storefront Feature: Add a product to cart from the results page
@97	 @storefront Feature: Display "Top Selling Products" in Lowest Product Subcategory on Product Details Page
@33	 @storefront Feature: Autofill functionality when searching
@118 @storefront Feature: Add Multiple to Basket from Product Details - need product details page up and running to continue
@30 @storefront Feature: Display free shipping on category and search results page

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
@60  @storefront Feature: Display multiple images on details page
@116 @storefront Feature: Remember my basket without login
@246 @storefront Feature: Clear all enabled filters
@264 @storefront Feature: Manually remove toast messages (mobile only)
@698 @storefront Feature: Track when an Andorid user clicks on the smart banner app (mobile only)
@665 @storefront Feature: Smart app banners for mobile site
@167 @storefront Feature: Shorten product name


-- Other elements could not be tested --
@64  @storefront Feature: Display 2-slot/scheduled delivery --- unable to determine whether or not product should satisfy 'same day delivery' conditions without DB access
@248 @storefront Feature: Footer -- Cannot test order tracking appearing in footer as do not have a login
@276 @storefront Feature: Understand old category page URLs -- Story empty on mingle
@373 @storefront Feature: "Display Top ""10"" Discounted Items of a Category on Category Landing Page" -- it looks like the 'swipe' scenario doesn't apply to the category landing page
@372 @storefront Feature: Display Top Sellers of a Category on Category Landing Page --- need to check what the 'sorting displayed products' scenario refers to
@358 @storefront Feature: Error Handling for Merchant Listings on Details Page --- need to be able to control other services (stubs?)


-- Test judged to be not required ---
@261 @storefront Feature: Remove filter & sort on 0 results
@263 @storefront Feature: Turn off native auto suggest

--- Testing difficult due to insufficient information in the Mingle story or not relevant acceptance / regression test ---

-- 21/08/14 --
@295 @storefront Feature: Indicate which filter is on

-- 07/10/14 --
@492 @storefront Feature: Fixing top exception
@491 @storefront Feature: Remove parent categories call (performance)
@476 @storefront Feature: Search results page enhancements on desktop
@427 @storefront Feature: Implementing output cache

-- 14/10/14 --
@528 @storefront Feature: Broken modules on homepage should not effect the entire homepage -- If testable is this a valid regression / acceptance test?
@522 @storefront Feature: Fix logging for kibana
@483 @storefront Feature: Homepage campaign banners next to carousel

-- 21/10/14 --
@626 @storefront Feature: Schedule job in logging machine to prevent disk space problem
@622 @storefront Feature: Bug bash 10 Oct (part 1)
@620 @storefront Feature: Fix contract tests
@619 @storefront Feature: Tab nav hover delay optimisation 
@329 @storefront Feature: anonymize comments with gender names for privacy of customer - need test accounts - "we cant create a user and leave comments in our new system. that happens in the old system. all we are doing in the current site is anonymize  the existing comments in the old system"

-- 28/10/14 --
@642 @storefront Feature: Spike for displaying available variant price on results
@631 @storefront Feature: Spike brand filtered category pages
@624 @storefront Feature: Bug bash 10 Oct (Part 2)
@625 @storefront Feature: Bug bash 10 Oct (Part 3)

-- 04/11/14 --
@635 @storefront Feature: Introduce hover style throw out beta
@634 @storefront Feature: Review common exceptions reported from Kibana dashboard
@628 @storefront Feature: Replace sprite image with font icons

-- 11/11/14 --
@676 @storefront Feature: Align with changed Fredhopper response at services
@672 @storefront Feature: Add caching support for deal of the day end point
@637 @storefront Feature: Properly redirecting brand filtered URLs
@636 @storefront Feature: Investigate most expensive operations in opnet

-- 18/11/14 --
@715 @storefront Feature: Remove port numbers from port numbers from canonical URLs
@704 @storefront Feature: Replace carousel plugin

-- 28/11/14 --
@695 @storefront Feature: Include query parameters in new URL structure of brand filtered pages
@384 @storefront Feature: Create XML Sitemaps

-- Other --
@423 @storefront Feature: "Keeping the ""Closest Match"" Functionality on Variants"  --- needs clarification
@312 @storefront Feature: Include deactive state for clear -- On Mobile the buttons are only inactive if you do not hover on them
@183 @storefront Feature: Allow Customers to Buy Merchant Offers on Details Page -- Merchant offer is dependant on Marketplace - needs clarification
@221 @storefront Feature: Display merchant offers on details page
@488 @storefront Feature: Display Tax Added Price for On Sale Products --- Just check that product page for discounted product shows original and discounted price?  Can't easily check whether includes tax from front end
@417 @storefront Feature: Clean URL structure for brand filtered category pages - bug in this URL doesn't match the acceptance criteria