import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// [AppClient ]
  /// [HomeTabView]
  String get todaysDeals;
  String get productsAroundYou;
  String get todaysDealsLowercase;
  String get search;

  ///[ProductScreen]
  ////[PolicySection]
  String get policyDeliveryReturns;
  String get shipping;
  String get estimatedDeliveryTime;
  String get pickupReminder1;
  String get pickupReminder2;
  String get returnRefundWithShipping1;
  String get returnRefundWithShipping2;
  String get returnRefundWithShipping3;
  String get returnRefundWithShipping4;
  String get returnRefundWithoutShipping1;
  String get returnRefundWithoutShipping2;
  String get returnRefundWithoutShipping3;
  String get returnRefundWithoutShipping4;
  String get returnRefundOnlyShipping1;
  String get returnRefundOnlyShipping2;
  String get returnRefundOnlyShipping3;
  String get returnRefund;

  String get similarProducts;

  ///[StoreSection]
  String get monday;
  String get tuesday;
  String get wednesday;
  String get thursday;
  String get friday;
  String get saturday;
  String get sunday;
  String get closed;
  String get open;
  String get noWorkingHours;
  String get cancel;
  String get validate;
  String get goToStore;
  ///// [ActionsSection]
  ///
  String get addToCart;
  String get buyNow;

  String get ishop;
  String get ishopSlogan;

  String get dzd;

  /// [authentication]
  String get email;
  String get emailAddress;
  String get password;
  String get createPassword;
  String get confirmPassword;
  String get forgotPassword;
  String get weSentYouCode;
  String get weSentYouCodeMessage;
  String get verificationCode;
  String get didNotReceiveCode;
  String get firstName;
  String get lastName;
  String get whereAreYouLocated;
  String get birthDate;
  String get phoneNumber;
  String get addPhoneNumber;
  String get addPhoneNumberCaption;
  String get address;
  String get wilaya;
  Map<int, String> get wilayasMap;
  String get gender;
  Map<int, String> get genders;
  String get register;
  String get login;
  String get logout;
  String get termsAndConditions;
  String get byClickingNextYouAgreeToTermsAndConditions;
  String get createYourIshopAccount;

  String get next;
  String get gettingStarted;
  String get collapse;

  ///[SideMenu ]

  String get settingsText;
  String get editProfileText;
  String get verifyIdentityText;
  String get editGlobalPolicyText;
  String get statisticsText;
  String get settingsButtonText;
  String get appearanceText;
  String get languageText;
  String get notificationsText;
  String get aboutText;
  String get rateSmartCityText;
  String get contactSupportText;
  String get logoutText;

  /// [UserHomePage]
  String get home;
  String get searchProduct;
  String get todayDeals;

  /// [SelleHomePage]
  String get welcome;

  /// [Cart]
  String get cart;
  String get totalPrice;
  String get productDeletionMessage;
  String get orderDeletionMessage;
  String get emptyCartCaption;

  /// [Wishlist]
  String get wishlist;
  String get emptyWishlistCaption;

  /// [Profile]
  String get profile;
  String get editProfile;
  String get editProfileImage;
  String get editProfileTitle;
  String get personalInfoTitle;
  String get emailTitle;
  String get phoneNumberTitle;
  String get addressTitle;
  String get selectAddressButton;
  String get streetAddressLine1Hint;
  String get streetAddressLine2Hint;
  String get countryHint;
  String get regionHint;
  String get cityHint;
  String get postalCodeHint;
  String get infoMessage;
  String get updateButton;

  /// [Policy]
  String get globalPolicyTitle;
  String get storePolicyTitle;
  String get productPolicyTitle;
  String get shippingTitle;
  String get shippingPolicyTitle;
  String get shippingPolicyInfo;
  String get deliveryToggleTitle;
  String get selfPickupToggleTitle;
  String get maxDaysToPickUpHint;
  String get ordersTitle;
  String get notificationsTitle;
  String get realTimeNotificationsToggleTitle;
  String get hourlyNotificationsToggleTitle;
  String get batchNotificationsToggleTitle;
  String get notifyEveryHint;
  String get batchNotificationFrequencyHint;
  String get orderNotificationPreferencesTitle;
  String get inPlatformNotificationsToggleTitle;
  String get popUpNotificationsToggleTitle;
  String get emailNotificationsToggleTitle;
  String get smsNotificationsToggleTitle;
  String get returnTitle;
  String get returnPolicyTitle;
  String get returnPolicyInfo;
  String get allowReturnsToggleTitle;
  String get maxDaysToReturnHint;
  String get returnStatusHint;
  String get returnMethodHint;
  String get refundPolicyTitle;
  String get shippingFeesToggleTitle;
  String get fullRefundToggleTitle;
  String get partialRefundToggleTitle;
  String get partialRefundAmountHint;

  String get updateProfile;
  String get myUserId;
  String get personalInformation;
  String get personalInformationMessage;
  String get about;
  String get help;
  String get edit;
  String get promote;
  String get freeze;
  String get delete;

  /// [Settings]
  String get settings;
  String get language;
  String get selectedLanguage;
  String get theme;
  String get systemTheme;
  String get lightTheme;
  String get darkTheme;
  String get reportProblem;
  String get seeAll;

  /// [Order]
  // common
  String get order;
  String get orders;
  String get orderDetails;
  String get yourOrderID;
  String get orderDate;
  String get deliveryDate;
  String get showOrderedProducts;
  String get qty;
  String get yourRating;
  String get total;
  String get emptyOrdersCaption;
  @override
  String get pending;
  @override
  String get selfPickup;
  @override
  String get delivery;
  @override
  String get returnOrder;
  @override
  String get refund;
  @override
  String get rejected;
  @override
  String get noPendingOrders;
  @override
  String get noRefundOrders;
  String get all;
  String get orderSuccess;
  String get done;
  String get payment;
  String get bills;
  String get items;
  String get back;
  String get reservationBill;
  String get deliveryBill;
  String get pickupBill;
  String get paymentTotalBill;
  String get shippingAddress;
  String get pickupBy;
  String get expirationDate;
  String get billDetails;
  String get reservation;

  String get finishYourOrder;
  String get contactInformation;
  String get namePerson;

  String get deliveryInfos;
  String get setDeliveryArea;
  String get pickupInfos;
  String get personNIN;

  String get noOnTheWayOrders;
  String get onTheWay;
  String get noDeliveredOrders;
  String get noDeliveryOrders;

  String get noRejectedOrders;

  String get noWaitingForReturnOrders;
  String get waitingForReturn;
  String get noReturnedOrders;
  String get noReturnOrders;
  String get returned;

  String get itemDeletedSuccessfully;

  String get leftToPay;
  String get deliveryPriceFixedAt;
  String get distance;

  String get inPreparation;
  String get awaitingRecovery;
  String get recovered;
  String get noInPreparationOrders;
  String get noAwaitingRecoveryOrders;
  String get noRecoveredOrders;
  String get noSelfPickupOrders;

  // that of user
  String get unpaidOrders;
  String get toBeDelivered;
  String get orderHistory;
  String get delivered;
  String get checkout;
  // that of seller
  String get recentOrders;
  String get pendingOrders;
  String get deliveryToll;

  /// [Shop]
  String get shop;
  String get name;
  String get description;
  String get category;
  String get categories;
  Map<int, String> get categoriesMap;
  String get yourShops;
  String get addShop;
  String get newShop;
  String get newShopMessage;
  String get editShop;
  String get freezeShop;
  String get freezeShopMessage;
  String get deleteShop;
  String get deleteShopMessage;
  String get reportShop;
  String get aboutShop;

  /// [ShopAdderScreen] and [ShopEditScreen]
  String get storeDetails;
  String get storeName;
  String get storeDescription;
  String get storeCrn;
  String get storeWorkingTime;
  String get storeWorkingTimeFixed;
  String get storeWorkingTimeCustom;
  @override
  String get storeSelectStoreLocation;

  @override
  String get storeSelectAddress;

  String get storeImage;
  String get storeTo;
  String get storeAddWorkingTime;
  String get storeAdress;
  String get storeAdressLine1;
  String get storeAdressLine2;
  String get storeAdressCountry;
  String get storeAdressRegion;
  String get storeAdressCity;
  String get storePostalCode;
  String get storePolicy;
  String get storeKeepPolicy;
  String get storeSetCustomPolicy;
  @override
  @override
  String get storeSelectWorkingTimeOption;
  @override
  String get storeCommercialRegistrationNumber;
  @override
  String get storeWorkingTimeDescription;

  @override
  String get storeSetGlobalPolicy;
  @override
  String get storeGlobalPolicyDescription;

  String get createANewShop;
  String get updateShop;
  String get shopOwner;
  String get shopDetails;
  String get hintShopName;
  String get hintShopCategory;
  String get hintShopDescription;
  String get shopAddress;
  String get hintShopAddress;
  String get shopCoverImage;
/////[Store]
  @override
  String get storeProducts;
  @override
  String get allProducts;
  @override
  String get storeOffers;
  @override
  String get newItem;

  /// [Product]
  // common
  String get product;
  String get products;
  String get brand;
  String get price;
  String get quantity;
  String get outOfStock;
  String get likes;
  String get sells;
  String get rating;
  String get aboutProduct;
  @override
  String get stopPromoting;
  @override
  String get offerStock;
  @override
  String get discount;
// that of user
  String get reviews;
  String get left;

  String get addToCartMessage;
  String get addToWishlist;
  String get addToWishlistMessage;
  String get removeFromWishlistMessage;
  String get reportProduct;
  // that of seller
  String get addProduct;
  String get newProduct;
  String get productDetails;

  String get editProduct;
  String get deleteProduct;
  String get deleteProductMessage;

  /// [ProductAdderScreen] and [ProductEditScreen]
  String get createNewProduct;
  String get updateProduct;
  String get hintProductShop;
  String get hintProductName;
  @override
  String get productVariants;

  @override
  String get moreVariants;

  @override
  String get productCreateNew;

  @override
  String get productName;

  @override
  String get productSelectCategory;

  @override
  String get productDescription;

  @override
  String get productImage;

  @override
  String get productYourOffer;

  @override
  String get productPriceIn;

  @override
  String get productQuantity;

  @override
  String get productAddVariants;

  @override
  String get productOptions;

  @override
  String get productAddOptions;

  @override
  String get productPolicy;

  @override
  String get productKeepStorePolicy;
  @override
  String get productCategoryInfo;

  @override
  String get productPriceQuantityInfo;

  @override
  String get productGlobalPolicyInfo;

  @override
  String get productUpdateButton;

  @override
  String get productConfirmButton;

  String get hintProductBrand;
  String get hintProductDescription;
  String get yourOffer;
  String get hintProductPrice;
  String get hintProductQuantity;
  String get productImages;
  //[ add options ]
  @override
  String get variantsCharacteristic;
  @override
  String get characteristicDescription;
  @override
  String get addNewValue;
  @override
  String get addNewOption;

  @override
  String get submit;

  @override
  String get optionDialogTitle;
  @override
  String get optionDialogOptionName;
  @override
  String get customOptionName;
  @override
  String get optionDialogSubmit;
  @override
  String get deleteOptionDialogTitle;
  @override
  String get deleteOptionDialogCancel;
  @override
  String get deleteOptionDialogDelete;
  @override
  String get valueDialogTitle;
  @override
  String get valueDialogValueName;
  @override
  String get valueDialogSubmit;
  //stat
  String get globalStatistics;
  String get views;
  String get sales;
  String get productViewed;
  String get productSold;
  String get productCategory;
  String get week;
  String get day;
  String get month;
  String get geographicSales;
  String get productSales;
  String get storeSales;
  String get storeViews;
  String get totalViews;
  String get productViews;
  String get noProductViewed;
  String get totalSales;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
// Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
