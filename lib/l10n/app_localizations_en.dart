import 'package:proximity/l10n/app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  /////////////////// [AppClient ]/////////////////////////
  /// [HomeTabView]
  String get todaysDeals => "Today's Deals";
  String get productsAroundYou => 'Products Around You';
  String get todaysDealsLowercase => 'Todays deals';
  String get search => "Search";

  ///[ProductScreen]
///// [PolicySection]
  String get policyDeliveryReturns => "policy de livraison et de retours .";
  String get shipping => "Shipping";
  String get estimatedDeliveryTime =>
      "Estimated delivery time is  days. Shipping fees will negotiate for this product";
  String get pickupReminder1 =>
      "Remember to pick up your order from our store within ";
  String get pickupReminder2 =>
      "days, or it will be returned to the shelves. Don't miss out on the chance to make it yours!.";
  String get returnRefundWithShipping1 => "You may return your item within";

  String get returnRefundWithShipping2 =>
      "days of receipt for a refund, provided that the item is";
  String get returnRefundWithShipping3 =>
      ". in case the return is accepted , the store will refund shipping fees and";
  String get returnRefundWithShipping4 => "% of the price";
  String get returnRefundWithoutShipping1 => "You may return your item within";
  String get returnRefundWithoutShipping2 =>
      "days of receipt for a refund, provided that the item is";
  String get returnRefundWithoutShipping3 =>
      ". in case the return is accepted , the store will refund ";
  String get returnRefundWithoutShipping4 =>
      "% of the price , shipping fees are not refunded";

  String get returnRefundOnlyShipping1 => "You may return your item within";
  String get returnRefundOnlyShipping2 =>
      "days of receipt for a refund, provided that the item is";
  String get returnRefundOnlyShipping3 =>
      "in case the return is accepted , the store will refund shipping fees";

  String get returnRefund => "Return and Refund  ";
  String get similarProducts => "Similar Products.";

  ///[StoreSection]
  String get monday => 'Monday';
  String get tuesday => 'Tuesday';
  String get wednesday => 'Wednesday';
  String get thursday => 'Thursday';
  String get friday => 'Friday';
  String get saturday => 'Saturday';
  String get sunday => 'Sunday';
  String get closed => 'Closed';
  String get open => 'Open';
  String get noWorkingHours => 'No working hours available';
  String get cancel => 'Cancel';

  String get goToStore => 'Go to Store';
  ///// [ActionsSection]
  String get addToCart => "Add to Cart.";
  String get buyNow => "Buy Now.";
  @override
  String get ishop => 'Ishop';
  @override
  String get ishopSlogan => 'The best shopping experience.';

  @override
  String get dzd => 'DZD';

  /// [authentication]
  @override
  String get email => 'Email';
  @override
  String get emailAddress => 'Email Address';
  @override
  String get password => 'Password';
  @override
  String get createPassword => 'Create a Password';
  @override
  String get confirmPassword => 'Confirm Password';
  @override
  String get forgotPassword => 'Forgot Password?';
  @override
  String get weSentYouCode => 'We sent you a code';
  @override
  String get weSentYouCodeMessage =>
      'Enter below your code to verify your phone number.';
  @override
  String get verificationCode => 'Verification Code';
  @override
  String get didNotReceiveCode => "Didn't receive code?";
  @override
  String get firstName => 'First name';
  @override
  String get lastName => 'Last name';
  @override
  String get whereAreYouLocated => 'Where are you located?';
  @override
  String get birthDate => 'Birth date';
  @override
  String get phoneNumber => 'Phone number';
  @override
  String get addPhoneNumber => 'Add a phone number';
  @override
  String get addPhoneNumberCaption =>
      'Enter the phone number you want to associated with your iShop account down below.';
  @override
  String get address => 'Address';
  @override
  String get wilaya => 'Wilaya';
  @override
  Map<int, String> get wilayasMap => {
        1: 'Adrar',
        2: 'Chlef',
        3: 'Laghouat',
        4: 'Oum El Bouaghi',
        5: 'Batna',
        6: 'Bejaia',
        7: 'Biskra',
      };
  @override
  String get gender => 'Gender';
  @override
  Map<int, String> get genders => {
        0: 'Female',
        1: 'Male',
      };
  @override
  String get register => 'Register';
  @override
  String get login => 'Login';
  @override
  String get logout => 'Logout';
  @override
  String get termsAndConditions => 'Terms & Conditions';
  @override
  String get byClickingNextYouAgreeToTermsAndConditions =>
      'By clicking Next, you agree to our terms and that you have read our Terms & Conditions.';
  @override
  String get createYourIshopAccount => 'Create your iShop account';
  @override
  String get validate => 'Validate';

  @override
  String get next => 'Next';
  @override
  String get gettingStarted => 'Getting Started';
  @override
  String get collapse => 'Collapse';

  /// [Cart]
  @override
  String get cart => 'Cart';
  @override
  String get totalPrice => 'Total Price';
  @override
  String get productDeletionMessage =>
      'Product successfully deleted from Cart!';
  @override
  String get orderDeletionMessage => 'Order successfully deleted from Cart!';
  @override
  String get emptyCartCaption =>
      'Your Cart is empty, consider adding products to it.';
  @override
  String get submit => 'Submit';
  @override
  String get stopPromoting => 'Stop Promoting';
  @override
  String get offerStock => 'Offer Stock';
  @override
  String get discount => 'Discount';

  /// [Wishlist]
  @override
  String get wishlist => 'Wishlist';
  @override
  String get emptyWishlistCaption => '💔\nYour Wishlist is empty.';

  /// [UserHomePage]
  @override
  String get home => 'Home';
  @override
  String get searchProduct => 'Search a product...';
  @override
  String get todayDeals => "Today's Deals";

  ///
  String get welcome => "Welcome";
  //// [ManageStores]

  String get editStore => 'Edit Store';
  String get freezeStore => 'Freeze Store';
  String get deleteStore => 'Delete Store';

  ///[Side Menu ]
  ///
  String get settingsText => 'Settings';
  String get editProfileText => 'Edit Profile.';
  String get verifyIdentityText => 'Verify Identity.';
  String get editGlobalPolicyText => 'Edit Global Policy.';
  String get statisticsText => 'Statistics .';
  String get settingsButtonText => 'Settings.';
  String get appearanceText => 'Appearance.';
  String get languageText => 'Language.';
  String get notificationsText => 'Notifications.';
  String get aboutText => 'About.';
  String get rateSmartCityText => 'Rate SmartCity.';
  String get contactSupportText => 'Contact Support.';
  String get logoutText => 'Log out.';

  /// [Profile]
  @override
  String get profile => 'Profile';
  @override
  String get editProfile => 'Edit profile';
  String get editProfileImage => 'Edit Profile Image';
  String get editProfileTitle => 'Edit Profile.';
  String get personalInfoTitle => 'Personal Info.';
  String get emailTitle => 'Email.';
  String get phoneNumberTitle => 'Phone Number.';
  String get addressTitle => 'Address.';
  String get selectAddressButton => 'Select Address.';
  String get streetAddressLine1Hint => 'Street Address Line 1.';
  String get streetAddressLine2Hint => 'Street Address Line 2.';
  String get countryHint => 'Country.';
  String get regionHint => 'Region.';
  String get cityHint => 'City.';
  String get postalCodeHint => 'Postal Code.';
  String get infoMessage =>
      'Your address will be automatically used as the shipping address.';
  String get updateButton => 'Update.';

  @override
  String get updateProfile => 'Update profile';
  @override
  String get myUserId => 'My user ID: ';
  @override
  String get personalInformation => 'Personal information';
  @override
  String get personalInformationMessage =>
      "Provider your personal information, even though the account is for business use. These info won't be public to everyone.";
  @override
  String get about => 'About';
  @override
  String get help => 'Help';
  @override
  String get edit => 'Edit';
  @override
  String get promote => 'Promote';
  @override
  String get freeze => 'Freeze';
  @override
  String get delete => 'Delete';

  ///[Policy]
  String get globalPolicyTitle => 'Global Policy.';
  String get storePolicyTitle => 'Store Policy';
  String get productPolicyTitle => 'Product Policy';
  String get shippingTitle => 'Shipping';
  String get shippingPolicyTitle => 'Shipping Policy.';
  String get shippingPolicyInfo =>
      'Select the type of Deliveries your store supports, and set a delivery tax value in case you deliver your orders.';
  String get deliveryToggleTitle => 'Delivery';
  String get selfPickupToggleTitle => 'Self Pickup';
  String get maxDaysToPickUpHint => 'Max Days to Pick Up.';
  String get ordersTitle => 'Orders';
  String get notificationsTitle => 'Notifications .';
  String get realTimeNotificationsToggleTitle => 'Real-time notifications';
  String get hourlyNotificationsToggleTitle => 'Hourly notifications';
  String get batchNotificationsToggleTitle => 'Batch notifications';
  String get notifyEveryHint => 'I want to be notified every.';
  String get batchNotificationFrequencyHint => 'Batch Notification Frequency.';
  String get orderNotificationPreferencesTitle =>
      'Order notification preferences.';
  String get inPlatformNotificationsToggleTitle => 'In-platform notifications';
  String get popUpNotificationsToggleTitle => 'Pop-up notifications';
  String get emailNotificationsToggleTitle => 'Email notifications';
  String get smsNotificationsToggleTitle => 'SMS notifications';
  String get returnTitle => 'Return';
  String get returnPolicyTitle => 'Return policy.';
  String get returnPolicyInfo =>
      'Here, you can choose to accept returns and set conditions like timeframe, product condition, and restocking fees. Your return policy will be visible to customers on your product pages, so be clear and specific. Contact our support team if you need help or have any questions.';
  String get allowReturnsToggleTitle => 'Allow Returns';
  String get maxDaysToReturnHint => 'Max Days to Return.';
  String get returnStatusHint => 'Return status';
  String get returnMethodHint => 'Return method';
  String get refundPolicyTitle => 'Refund Policy.';
  String get shippingFeesToggleTitle => 'Shipping Fees.';
  String get fullRefundToggleTitle => 'Full Refund';
  String get partialRefundToggleTitle => 'Partial Refund';
  String get partialRefundAmountHint => 'Partial Refund Amount .';

  /// [Settings]
  // rajout de qr code en mode anglais
  @override
  String get qrCodeScreen => 'Qr Code';
  // ---------------------
  @override
  String get settings => 'Settings';
  @override
  String get language => 'Language';
  @override
  String get selectedLanguage => 'English';
  @override
  String get theme => 'Theme';
  @override
  String get systemTheme => 'System Theme';
  @override
  String get lightTheme => 'Light Theme';
  @override
  String get darkTheme => 'Dark Theme';
  @override
  String get reportProblem => 'Report a Problem';
  @override
  String get seeAll => 'SEE ALL';

  /// [Order]
  // common
  @override
  String get order => 'Order';
  @override
  String get orders => 'Orders';
  @override
  String get orderDetails => 'Order Details';
  @override
  String get yourOrderID => 'Your Order ID';
  @override
  String get orderDate => 'Order Date';
  @override
  String get deliveryDate => 'Delivery Date';
  @override
  String get showOrderedProducts => 'Show Ordered Products';
  @override
  String get qty => 'Qty';
  @override
  String get yourRating => 'Your Rating';
  @override
  String get total => 'Total';
  @override
  String get emptyOrdersCaption => 'The orders list is empty.';
  String get orderSuccess =>
      'Your order has been made successfully, we will inform you once it is validated';
  String get done => 'Done';
  String get payment => 'Payment';
  String get bills => 'Bills';
  String get items => 'Items';
  String get back => 'Back';
  String get reservationBill => 'Reservation Bill';
  String get deliveryBill => 'Delivery Bill';
  String get pickupBill => 'Pickup Bill';
  String get paymentTotalBill => 'Payment Total Bill';
  String get shippingAddress => 'Shipping Address';
  String get pickupBy => 'Pickup By';
  String get expirationDate => 'Expiration Date';
  String get billDetails => 'Bill Details';
  String get reservation => 'Reservation';

  String get leftToPay => 'Left to Pay';
  String get deliveryPriceFixedAt => 'Delivery Price Fixed at';
  String get distance => 'Distance';

  String get itemDeletedSuccessfully => 'Item Deleted Successfully';
  String get finishYourOrder => 'Finish your order';
  String get contactInformation => 'Contact information';
  String get name => 'Name';

  String get noOnTheWayOrders => 'There are no On the way Orders.';
  String get onTheWay => 'On the way';
  String get noDeliveredOrders => 'There are no delivered Orders.';
  String get noDeliveryOrders => 'There are no Delivery Orders.';

  String get noRejectedOrders => 'There are no Rejected Orders.';
  String get noWaitingForReturnOrders =>
      'There are no Waiting for return Orders.';
  String get waitingForReturn => 'Waiting for return';
  String get noReturnedOrders => 'There are no Returned Orders.';
  String get noReturnOrders => 'There are no Return Orders.';
  String get returned => 'Returned';

  // that of user
  @override
  String get unpaidOrders => 'Unpaid Orders';
  @override
  String get toBeDelivered => 'To be delivered';
  @override
  String get orderHistory => 'Order History';
  @override
  String get delivered => 'Delivered';
  @override
  String get checkout => 'Checkout';
  // that of seller
  @override
  String get recentOrders => 'Recent orders';
  @override
  String get pendingOrders => 'Pending orders: ';
  @override
  String get deliveryToll => 'Delivery toll: ';
  @override
  String get pending => 'Pending';
  @override
  String get selfPickup => 'Self Pickup';
  @override
  String get delivery => 'Delivery';
  @override
  String get returnOrder => 'Return';
  @override
  String get refund => 'Refund';
  @override
  String get rejected => 'Rejected';
  @override
  String get noPendingOrders => 'There are no Pending Orders.';
  @override
  String get noRefundOrders => 'There are no Refund Orders.';
  String get all => 'All';

  String get inPreparation => 'In preparation';
  String get awaitingRecovery => 'Awaiting Recovery';
  String get recovered => 'Recovered';
  String get noInPreparationOrders => 'There are no In Preparation Orders.';
  String get noAwaitingRecoveryOrders =>
      'There are no Awaiting Recovery Orders.';
  String get noRecoveredOrders => 'There are no Recovered Orders.';
  String get noSelfPickupOrders => 'There are no Self Pickup Orders.';

  String get deliveryInfos => 'Delivery Infos.';
  String get setDeliveryArea => 'Set Delivery Area.';
  String get pickupInfos => 'Pickup Infos.';
  String get personNIN => 'Person NIN';

  /// [Shop]
  @override
  String get shop => 'Shop';
  @override
  String get namePerson => 'Name';
  @override
  String get description => 'Description';
  @override
  String get category => 'Category';
  @override
  String get categories => 'Categories';
  @override
  Map<int, String> get categoriesMap => {
        0: 'Fashion',
        1: 'Phones',
        2: 'Video games',
        3: 'Beauty',
        4: 'Automotive',
        5: 'Sports',
        6: 'Books',
        7: 'Other',
      };
  @override
  String get yourShops => 'Your shops';
  @override
  String get addShop => 'Add shop';
  @override
  String get newShop => 'New shop';
  @override
  String get newShopMessage =>
      'Creating an existing shop with different addresses remains possible as long as the owner is one.';
  @override
  String get editShop => 'Edit shop';
  @override
  String get freezeShop => 'Freeze shop';
  @override
  String get freezeShopMessage =>
      "If you wish to temporarily close your shop, maybe take a vacation for a few days, consider freezing it ❄";
  @override
  String get deleteShop => 'Delete shop';
  @override
  String get deleteShopMessage =>
      'Warning: This is potentially a destructive action.';
  @override
  String get reportShop => 'Report Shop';
  @override
  String get aboutShop => 'About';

  /// [ShopAdderScreen] and [ShopEditScreen]
  @override
  String get storeDetails => 'Store Details';
  @override
  String get storeName => 'Store Name';
  @override
  String get storeDescription => 'Store Description';
  @override
  String get storeCrn => 'Store CRN';
  @override
  String get storeWorkingTime => 'Store Working Time';
  @override
  String get storeWorkingTimeFixed => 'Fixed Working Time';
  @override
  String get storeWorkingTimeCustom => 'Custom Working Time';
  @override
  String get storeImage => 'Store Image';
  @override
  String get storeTo => 'to';
  @override
  String get storeAddWorkingTime => 'Add Working Time';
  @override
  String get storeAdress => 'Store Address';
  @override
  String get storeAdressLine1 => 'Address Line 1';
  @override
  String get storeAdressLine2 => 'Address Line 2';
  @override
  String get storeAdressCountry => 'Country';
  @override
  String get storeAdressRegion => 'Region';
  @override
  String get storeAdressCity => 'City';
  @override
  String get storePostalCode => 'Postal Code';
  @override
  String get storePolicy => 'Store Policy';
  @override
  String get storeKeepPolicy => 'Keep Policy';
  @override
  String get storeSetCustomPolicy => 'Set Custom Policy';

  @override
  String get storeSelectWorkingTimeOption => 'Select working time option.';
  @override
  String get storeWorkingTimeDescription =>
      'By updating your working hours in the app, your clients will be informed about when you\'re open for pickups. Take a moment to add your working hours and keep your customers in the loop';

  @override
  String get storeSetGlobalPolicy =>
      'Please set your global policy before creating a new store.';
  @override
  String get storeGlobalPolicyDescription =>
      'To ensure consistency across all your stores, it is important to set a global policy that will apply to all your stores. This policy can include details such as shipping and return policies, terms of service, and other important information for your customers.\n\nTo set your global policy, please click the "Set Policy" button below. If you are not ready to set your policy yet, you can click "Cancel".';
  @override
  String get storeSelectStoreLocation =>
      'Select your Store Location from the Address Picker, then edit the address info for more accuracy.';
  @override
  String get storeCommercialRegistrationNumber =>
      'Please provide your commercial registration number. This is a unique identifier assigned to your business by the relevant government authority.';

  @override
  String get storeSelectAddress => 'Select Address.';

  @override
  String get createANewShop => 'Create a new shop';
  @override
  String get updateShop => 'Update shop';
  @override
  String get shopOwner => 'Shop owner';
  @override
  String get shopDetails => 'Shop details';
  @override
  String get hintShopName => 'Give your shop a name';
  @override
  String get hintShopCategory => 'Select a targeted category';
  @override
  String get hintShopDescription => 'Write your shop description here...';
  @override
  String get shopAddress => 'Shop address';
  @override
  String get hintShopAddress => 'Select an address';
  @override
  String get shopCoverImage => 'Shop cover image';
  @override
  String get shopCrn => 'Shop CRN';
  @override
  String get shopWorkingTime => 'Shop Working Time';
  @override
  String get shopWorkingTimeFixed => 'Fixed Working Time';
  @override
  String get shopWorkingTimeCustom => 'Custom Working Time';

  /// [ store]
  @override
  String get storeProducts => 'Store Products.';
  @override
  String get allProducts => 'All Products.';
  @override
  String get storeOffers => 'Store Offers.';
  @override
  String get newItem => 'New';

  /// [Product]
  // common
  @override
  String get product => 'Product';
  @override
  String get products => 'Products';
  @override
  String get brand => 'Brand name';
  @override
  String get price => 'Price';
  @override
  String get quantity => 'Quantity';
  @override
  String get outOfStock => 'Out of Stock!';
  @override
  String get likes => 'Likes';
  @override
  String get sells => 'Sells';
  @override
  String get rating => 'Rating';
  @override
  String get aboutProduct => 'About';
  // that of user
  @override
  String get reviews => 'Reviews';
  @override
  String get left => 'left';

  @override
  String get addToCartMessage => 'Product added to Cart';
  @override
  String get addToWishlist => 'Add to Wishlist';
  @override
  String get addToWishlistMessage => 'Product added to Wishlist';
  @override
  String get removeFromWishlistMessage => 'Product removed from Wishlist';
  @override
  String get reportProduct => 'Report Product';
  @override
  String get productCategoryInfo =>
      'Every product must belong to a single category. Categorizing products accurately for better promotion and visibility.';
  @override
  String get productPriceQuantityInfo =>
      'Please enter the price and quantity for each product accurately. If you offer product variants, specify the base details and variations. Keep your product information up to date for a smooth selling experience.';
  @override
  String get productVariations => 'Variations.';
  @override
  String get productGlobalPolicyInfo =>
      'Keep global policy ensures fair and transparent transactions. When creating a new store, you can keep this policy for all your stores or create a custom policy for each store. Review the policy and create custom policies to build trust with your customers.';
  @override
  String get productUpdateButton => 'Update.';
  @override
  String get productConfirmButton => 'Confirm.';

  // that of seller
  @override
  @override
  String get productCreateNew => 'Create New Product';
  @override
  String get productName => 'Product Name';
  @override
  String get productDetails => 'Product Details';
  @override
  String get productSelectCategory => 'Select Category';
  @override
  String get productDescription => 'Product Description';
  @override
  String get productImage => 'Product Image';
  @override
  String get productYourOffer => 'Your Offer';
  @override
  String get productPriceIn => 'Price in';
  @override
  String get productQuantity => 'Quantity';
  @override
  String get productAddVariants => 'Add Variants';
  @override
  String get productOptions => 'Options';
  @override
  String get productAddOptions => 'Add Options';
  @override
  String get productPolicy => 'Product Policy';
  @override
  String get productKeepStorePolicy => 'Keep Store Policy';
  @override
  String get productSetProductPolicy => 'Set Product Policy';

  String get addProduct => 'Add product';
  @override
  String get newProduct => 'New products';

  @override
  String get editProduct => 'Edit product';
  @override
  String get deleteProduct => 'Delete a Product';
  @override
  String get deleteProductMessage => 'Product successfully deleted!';

  /// [ProductAdderScreen] and [ProductEditScreen]

  @override
  String get createNewProduct => 'Create a new product';
  @override
  String get updateProduct => 'Update product';
  @override
  String get hintProductShop => "Choose your product's shop";
  @override
  String get hintProductName => "Your product's name here";
  @override
  String get hintProductBrand => 'Who manufactured this product?';
  @override
  String get hintProductDescription =>
      'Write few lines describing your product to your customers...';
  @override
  String get productVariants => 'Product Variants.';

  @override
  String get moreVariants => 'more Variants';

  @override
  String get yourOffer => 'Your offer';
  @override
  String get hintProductPrice => 'How much for one unit?';
  @override
  String get hintProductQuantity => 'Opening stock of this product';
  @override
  String get productImages => 'Product images';

  ///[ AddingOptions ]
  @override
  String get variantsCharacteristic => 'Variants Characteristic.';
  @override
  String get characteristicDescription =>
      'Here you set the characteristics your product has.\nEx: Color, Size, Language... etc';
  @override
  String get addNewValue => 'Add new Value.';
  @override
  String get addNewOption => 'Add new Option.';

  @override
  String get optionDialogTitle => 'Add a new Option.';
  @override
  String get optionDialogOptionName => 'Option Name';
  @override
  String get customOptionName => 'Custom Option Name';
  @override
  String get optionDialogSubmit => 'Submit';
  @override
  String get deleteOptionDialogTitle =>
      'Are you sure you want to remove this Option?';
  @override
  String get deleteOptionDialogCancel => 'Cancel';
  @override
  String get deleteOptionDialogDelete => 'Delete';
  @override
  String get valueDialogTitle => 'Add a new Value.';
  @override
  String get valueDialogValueName => 'Value Name';
  @override
  String get valueDialogSubmit => 'Submit';
  //Stat
  String get globalStatistics => 'Global Statistics';
  String get views => 'Views';
  String get sales => 'Sales';
  String get productViewed => 'product was viewed';
  String get productSold => 'product was sold';
  String get productCategory => 'Product Category';
  String get week => 'week';
  String get day => 'day';
  String get month => 'month';
  String get geographicSales => 'Geographic Sales';
  //String get productViewed => 'product was viewed';
  //String get productSold => 'product was sold';
  String get productSales => 'Product Sales';
  String get storeSales => 'Store Sales';
  String get storeViews => 'Store Views';
  String get totalViews => 'Total Views';
  String get productViews => 'Product Views';
  String get noProductViewed => 'No product was viewed this';
  String get totalSales => 'Total Sales:';
}
