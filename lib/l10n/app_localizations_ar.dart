import 'package:proximity/l10n/app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  /// [AppClient ]
  /// [HomeTabView]
  String get todaysDeals => 'عروض اليوم';
  String get productsAroundYou => 'المنتجات حولك';
  String get todaysDealsLowercase => 'عروض اليوم';
  String get search => 'بحث';

  ///[ProductScreen]
  ////[policySection]
  String get policyDeliveryReturns => "سياسة الشحن والإرجاع .";
  String get shipping => "الشحن";
  String get estimatedDeliveryTime =>
      "التسليم المتوقع يستغرق أيام. سيتم التفاوض على رسوم الشحن لهذا المنتج";
  String get pickupReminder1 => "تذكير بالتقاط طلبك من متجرنا خلال ";
  String get pickupReminder2 =>
      "يومًا ، وإلا سيتم إعادته إلى الرفوف. لا تفوت الفرصة لجعله ملكًا لك!";
  String get returnRefundWithShipping1 => "يمكنك إرجاع العنصر الخاص بك خلال";
  String get returnRefundWithShipping2 =>
      "أيام من استلامه لاسترداد الأموال ، بشرط أن يكون العنصر";
  String get returnRefundWithShipping3 =>
      "في حالة قبول العودة ، سيقوم المتجر بإرجاع رسوم الشحن و";
  String get returnRefundWithShipping4 => "٪ من السعر";
  String get returnRefundWithoutShipping1 => "يمكنك إرجاع العنصر الخاص بك خلال";
  String get returnRefundWithoutShipping2 =>
      "أيام من استلامه لاسترداد الأموال ، بشرط أن يكون العنصر";
  String get returnRefundWithoutShipping3 =>
      "في حالة قبول العودة ، سيقوم المتجر بإرجاع";
  String get returnRefundWithoutShipping4 =>
      "٪ من السعر ، ولا يتم استرداد رسوم الشحن";
  String get returnRefundOnlyShipping1 => "يمكنك إرجاع العنصر الخاص بك خلال";
  String get returnRefundOnlyShipping2 =>
      "أيام من استلامه لاسترداد الأموال ، بشرط أن يكون العنصر";
  String get returnRefundOnlyShipping3 =>
      "في حالة قبول العودة ، سيقوم المتجر بإرجاع رسوم الشحن";
  String get returnRefund => "الإرجاع والاسترداد  ";
  String get similarProducts => "منتجات مماثلة.";

  ///[StoreSection]
  String get monday => 'الاثنين';
  String get tuesday => 'الثلاثاء';
  String get wednesday => 'الأربعاء';
  String get thursday => 'الخميس';
  String get friday => 'الجمعة';
  String get saturday => 'السبت';
  String get sunday => 'الأحد';
  String get closed => 'مغلق';
  String get open => 'مفتوح';
  String get noWorkingHours => 'لا توجد ساعات عمل متاحة';

  String get goToStore => 'الانتقال إلى المتجر';

  ///[ActionSection]
  String get addToCart => "إضافة إلى السلة";
  String get buyNow => "اشترِ الآن";

  @override
  String get dzd => 'دج';

  @override
  String get ishop => 'Ishop';
  @override
  String get ishopSlogan => 'The best shopping experience.';

  /// [authentication]
  @override
  String get email => 'البريد الإلكتروني';
  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';
  @override
  String get password => 'كلمة المرور';
  @override
  String get createPassword => 'ضع كلمة مرور';
  @override
  String get confirmPassword => 'تأكيد كلمة المرور';
  @override
  String get forgotPassword => 'هل نسيت كلمة السر؟';
  @override
  String get weSentYouCode => 'تم إرسال رمز التأكيد إلى هاتفك';
  @override
  String get weSentYouCodeMessage => 'أدخل الرمز أدناه للتحقق من رقم هاتفك.';
  @override
  String get verificationCode => 'رمز التأكيد';
  @override
  String get didNotReceiveCode => 'لم يصلك رمز التأكيد؟';
  @override
  String get firstName => 'الإسم';
  @override
  String get lastName => 'اللقب العائلي';
  @override
  String get whereAreYouLocated => 'من أي ولاية أنت؟';
  @override
  String get birthDate => 'تاريخ الميلاد';
  @override
  String get phoneNumber => 'رقم الهاتف';
  @override
  String get addPhoneNumber => 'إضافة رقم هاتف';
  @override
  String get addPhoneNumberCaption =>
      'أدخل رقم الهاتف الذي ترغب بربطه بحساب iShop الخاص بك في الأسفل.';
  @override
  String get address => 'العنوان';
  @override
  String get wilaya => 'الولاية';
  @override
  Map<int, String> get wilayasMap => {
        1: 'أدرار',
        2: 'الشلف',
        3: 'الأغواط',
        4: 'أم البواقي',
        5: 'باتنة',
        6: 'بجاية',
        7: 'بسكرة',
      };
  @override
  String get gender => 'الجنس';
  @override
  Map<int, String> get genders => {
        0: 'أنثى',
        1: 'ذكر',
      };
  @override
  String get register => 'حساب جديد';
  @override
  String get login => 'تسجيل الدخول';
  @override
  String get logout => 'تسجيل الخروج';
  @override
  String get termsAndConditions => 'الشروط والأحكام';
  @override
  String get byClickingNextYouAgreeToTermsAndConditions =>
      'بالظغط على التالي، فإنك توافق على شروطنا أي أنك قرأت الشروط والأحكام الخاصة بنا.';
  @override
  String get createYourIshopAccount => 'قم بإنشاء حساب iShop الخاص بك';
  @override
  String get validate => 'ثبت';
  @override
  String get cancel => 'إلغاء';
  @override
  String get next => 'التالي';
  @override
  String get gettingStarted => 'ابدء';
  @override
  String get collapse => 'إخفاء';

  ///[SideMenu ]
  //
  String get settingsText => 'الإعدادات';
  String get editProfileText => 'تعديل الملف الشخصي.';
  String get verifyIdentityText => 'تحقق من الهوية.';
  String get editGlobalPolicyText => 'تحرير السياسة العامة.';
  String get statisticsText => 'الإحصائيات .';
  String get settingsButtonText => 'الإعدادات.';
  String get appearanceText => 'المظهر.';
  String get languageText => 'اللغة.';
  String get notificationsText => 'الإشعارات.';
  String get aboutText => 'حول.';
  String get rateSmartCityText => 'تقييم المدينة الذكية.';
  String get contactSupportText => 'الاتصال بالدعم.';
  String get logoutText => 'تسجيل الخروج.';

  /// [Cart]
  @override
  String get cart => 'السَلَّة';
  @override
  String get totalPrice => 'السُّومَةُ الكلية';
  @override
  String get productDeletionMessage => 'تم حذف المنتج بنجاح من سلة التسوق!';
  @override
  String get orderDeletionMessage => 'تم حذف الطلب بنجاح من سلة التسوق!';
  @override
  String get emptyCartCaption =>
      'سَلَّة التسوق الخاصة بك فارغة ، ضع في اعتبارك إضافة منتجات إليها.';
  @override
  String get stopPromoting => 'إيقاف الترويج';
  @override
  String get offerStock => 'مخزون العرض';
  @override
  String get discount => 'خصم';
  @override
  String get productVariants => 'المتغيرات المنتج.';

  @override
  String get moreVariants => 'المزيد من المتغيرات';

  /// [Wishlist]
  @override
  String get wishlist => 'قائمة الرَّغبَات';
  @override
  String get emptyWishlistCaption => '💔\nقائمة رغباتك خاوية.';

  /// [UserHomePage]

  @override
  String get home => 'إكتشف';
  @override
  String get searchProduct => 'البحث عن منتج...';
  @override
  String get todayDeals => 'عروض اليوم';

  /// [SellerHomePage]
  @override
  String get welcome => 'إكتشف';
  String get editStore => 'تعديل المتجر';
  String get freezeStore => 'تجميد المتجر';
  String get deleteStore => 'حذف المتجر';

  /// [Profile]
  @override
  String get profile => 'الحساب';
  // Arabic Translations
  String get editProfileTitle => 'تعديل الملف الشخصي.';
  String get personalInfoTitle => 'معلومات شخصية.';
  String get emailTitle => 'البريد الإلكتروني.';
  String get phoneNumberTitle => 'رقم الهاتف.';
  String get addressTitle => 'العنوان.';
  String get selectAddressButton => 'اختر العنوان.';
  String get streetAddressLine1Hint => 'الشارع 1.';
  String get streetAddressLine2Hint => 'الشارع 2.';
  String get countryHint => 'الدولة.';
  String get regionHint => 'المنطقة.';
  String get cityHint => 'المدينة.';
  String get postalCodeHint => 'الرمز البريدي.';
  String get infoMessage => 'سيتم استخدام عنوانك تلقائيًا كعنوان الشحن.';
  String get updateButton => 'تحديث.';
  String get editProfileImage => 'تحرير صورة الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';
  @override
  String get updateProfile => 'تحديث الملف';
  @override
  String get myUserId => 'اﻟـId الخاص بي: ';
  @override
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get personalInformationMessage =>
      'قدم معلوماتك الشخصية رغما على أنّ غرض الحساب تجاري. هاته المعلومات  لن تكون ظاهرة للجميع.';
  @override
  String get about => 'حول';
  @override
  String get help => 'مساعدة';
  @override
  String get edit => 'تعديل';
  @override
  String get promote => 'ترويج';
  @override
  String get freeze => 'تجميد';
  @override
  String get delete => 'حذف';

  ///[Policy]
  String get globalPolicyTitle => 'السياسة العامة.';
  String get storePolicyTitle => 'سياسة المتجر';
  String get productPolicyTitle => 'سياسة المنتج';
  String get shippingTitle => 'الشحن';
  String get shippingPolicyTitle => 'سياسة الشحن.';
  String get shippingPolicyInfo =>
      'حدد نوع التسليم الذي يدعمه متجرك وقم بتعيين قيمة ضريبة التسليم في حال قمت بتوصيل طلباتك.';
  String get deliveryToggleTitle => 'التوصيل';
  String get selfPickupToggleTitle => 'استلام ذاتي';
  String get maxDaysToPickUpHint => 'أقصى عدد من الأيام للاستلام.';
  String get ordersTitle => 'الطلبات';
  String get notificationsTitle => 'الإشعارات.';
  String get realTimeNotificationsToggleTitle => 'إشعارات فورية';
  String get hourlyNotificationsToggleTitle => 'إشعارات ساعية';
  String get batchNotificationsToggleTitle => 'إشعارات دفعية';
  String get notifyEveryHint => 'أرغب في الحصول على إشعار كل.';
  String get batchNotificationFrequencyHint => 'تكرار إشعارات الدفعة.';
  String get orderNotificationPreferencesTitle => 'تفضيلات إشعار الطلب.';
  String get inPlatformNotificationsToggleTitle => 'إشعارات داخل المنصة';
  String get popUpNotificationsToggleTitle => 'إشعارات منبثقة';
  String get emailNotificationsToggleTitle => 'إشعارات بالبريد الإلكتروني';
  String get smsNotificationsToggleTitle => 'إشعارات الرسائل النصية';
  String get returnTitle => 'الإرجاع';
  String get returnPolicyTitle => 'سياسة الإرجاع.';
  String get returnPolicyInfo =>
      'هنا يمكنك اختيار قبول الإرجاعات وتعيين الشروط مثل المدة الزمنية وحالة المنتج ورسوم إعادة التخزين. ستكون سياسة الإرجاع الخاصة بك مرئية للعملاء على صفحات المنتجات الخاصة بك، لذا كن واضحًا ودقيقًا. تواصل مع فريق الدعم لدينا إذا كنت بحاجة إلى مساعدة أو إذا كان لديك أي أسئلة.';
  String get allowReturnsToggleTitle => 'السماح بالإرجاعات';
  String get maxDaysToReturnHint => 'أقصى عدد من الأيام للإرجاع.';
  String get returnStatusHint => 'حالة الإرجاع';
  String get returnMethodHint => 'طريقة الإرجاع';
  String get refundPolicyTitle => 'سياسة الاسترداد.';
  String get shippingFeesToggleTitle => 'رسوم الشحن.';
  String get fullRefundToggleTitle => 'استرداد كامل';
  String get partialRefundToggleTitle => 'استرداد جزئي';
  String get partialRefundAmountHint => 'مبلغ الاسترداد الجزئي.';

  /// [Settings]
  @override
  String get settings => 'الإعدادات';
  @override
  String get language => 'اللغات';
  @override
  String get selectedLanguage => 'العربية';
  @override
  String get theme => 'نظام الألوان';
  @override
  String get systemTheme => 'نمط النظام';
  @override
  String get lightTheme => 'النمط المشرق';
  @override
  String get darkTheme => 'النمط المظلم';
  @override
  String get reportProblem => 'التبليغ عن مشكل تقني';
  @override
  String get seeAll => 'اظهار الكل';

  /// [Order]
  // common
  @override
  String get order => 'طلب';
  @override
  String get orders => 'الطلبات';
  @override
  String get orderDetails => 'تفاصيل الطلب';
  @override
  String get yourOrderID => 'اﻟـId الخاص بطلبك';
  @override
  String get orderDate => 'تاريخ الطلب';
  @override
  String get deliveryDate => 'تاريخ التوصيل';
  @override
  String get showOrderedProducts => 'عرض المنتجات المطلوبة';
  @override
  String get qty => 'الكمية';
  @override
  String get yourRating => 'تقييمك';
  @override
  String get total => 'المجموع';
  @override
  String get emptyOrdersCaption => 'قائمة الطلبات فارغة';
  // that of user
  @override
  String get unpaidOrders => 'طلبات غير مدفوعة';
  @override
  String get toBeDelivered => 'طلبات قيد التوصيل';
  @override
  String get orderHistory => 'تاريخ الطلبات';
  @override
  String get delivered => 'الطلبات الموصلة';
  @override
  String get checkout => 'دفع الثمن';
  @override
  String get pending => 'قيد الانتظار';
  @override
  String get selfPickup => 'استلام ذاتي';
  @override
  String get delivery => 'توصيل';
  @override
  String get returnOrder => 'إرجاع';
  @override
  String get refund => 'استرداد';
  @override
  String get rejected => 'مرفوض';
  @override
  String get noPendingOrders => 'لا توجد طلبات قيد الانتظار.';
  @override
  String get noRefundOrders => 'لا توجد طلبات استرداد.';
  String get all => 'الكل';
  String get orderSuccess =>
      'تم إجراء طلبك بنجاح ، سنبلغك بمجرد أن يتم التحقق منه';
  String get done => 'تم';
  String get payment => 'الدفع';
  String get bills => 'الفواتير';
  String get items => 'العناصر';
  String get back => 'العودة';
  String get reservationBill => 'فاتورة الحجز';
  String get deliveryBill => 'فاتورة التوصيل';
  String get pickupBill => 'فاتورة الاستلام';
  String get paymentTotalBill => 'فاتورة الدفع الإجمالية';
  String get shippingAddress => 'عنوان التوصيل';
  String get pickupBy => 'استلام بواسطة';
  String get expirationDate => 'تاريخ الانتهاء';
  String get billDetails => 'تفاصيل الفاتورة';
  String get reservation => 'الحجز';

  String get leftToPay => 'المتبقي للدفع';
  String get deliveryPriceFixedAt => 'تكلفة التوصيل ثابتة عند';
  String get distance => 'المسافة';

  String get inPreparation => 'قيد التحضير';
  String get awaitingRecovery => 'في انتظار الاستلام';
  String get recovered => 'تم استلامها';
  String get noInPreparationOrders => 'لا توجد طلبات قيد التحضير.';
  String get noAwaitingRecoveryOrders => 'لا توجد طلبات في انتظار الاستلام.';
  String get noRecoveredOrders => 'لا توجد طلبات تم استلامها.';
  String get noSelfPickupOrders => 'لا توجد طلبات للاستلام الذاتي.';

  String get finishYourOrder => 'أنهِ الطلب';
  String get contactInformation => 'معلومات الاتصال';
  String get name => 'الاسم';
  String get itemDeletedSuccessfully => 'تم حذف العنصر بنجاح';
  // that of seller
  @override
  String get recentOrders => 'الطلبات الأخيرة';
  @override
  String get pendingOrders => 'الطلبات المعلقة';
  @override
  String get deliveryToll => 'معدل التوصيل';

  String get deliveryInfos => 'معلومات التوصيل.';
  String get setDeliveryArea => 'تعيين منطقة التوصيل.';
  String get pickupInfos => 'معلومات الاستلام.';
  String get personNIN => 'الرقم الوطني للهوية (NIN)';

  String get noOnTheWayOrders => 'لا توجد طلبات قيد التوصيل حاليًا.';
  String get onTheWay => 'قيد التوصيل';
  String get noDeliveredOrders => 'لا توجد طلبات تم توصيلها.';
  String get noDeliveryOrders => 'لا توجد طلبات توصيل.';

  String get noRejectedOrders => 'لا توجد طلبات مرفوضة.';

  String get noWaitingForReturnOrders => 'لا توجد طلبات في انتظار الإرجاع.';
  String get waitingForReturn => 'في انتظار الإرجاع';
  String get noReturnedOrders => 'لا توجد طلبات تم إرجاعها.';
  String get noReturnOrders => 'لا توجد طلبات إرجاع.';
  String get returned => 'تم الإرجاع';

  /// [Shop]
  @override
  String get shop => 'متجر';
  @override
  String get namePerson => 'الإسم';
  @override
  String get description => 'التفاصبل';
  @override
  String get category => 'الفئة';
  @override
  String get categories => 'الفئات';
  @override
  Map<int, String> get categoriesMap => {
        0: 'ملابس',
        1: 'هواتف محمولة',
        2: 'ألعاب الكترونية',
        3: 'محل تجميل',
        4: 'سيارات',
        5: 'معدات رياضية',
        6: 'كتب',
        7: 'فئة أخرى',
      };
  @override
  String get yourShops => 'متاجرك';
  @override
  String get addShop => 'إضافة المتجر';
  @override
  String get newShop => 'متجر جديد';
  @override
  String get newShopMessage =>
      'فتح متجر موجود بعناوين مختلفة يبقى ممكنا طالماَ أنّ المالك واحد.';
  @override
  String get editShop => 'تعديل المتجر';
  @override
  String get freezeShop => 'تجميد المتجر';
  @override
  String get freezeShopMessage =>
      'إذا كنت ترغب في إغلاق متجرك مؤقتًا، لغرض إجازة لبضعة أيام أو شيئا ما، قم بتجميده إذا ❄';
  @override
  String get deleteShop => 'حذف المتجر';
  @override
  String get deleteShopMessage =>
      'تحذير: من المحتمل أن يكون هذا إجراءً مدمرًا.';
  @override
  String get reportShop => 'الإبلاغ عن المتجر';
  @override
  String get aboutShop => 'حول المتجر';

  /// [ShopAdderScreen] and [ShopEditScreen]
  @override
  String get storeDetails => 'تفاصيل المتجر';
  @override
  String get storeName => 'اسم المتجر';
  @override
  String get storeDescription => 'وصف المتجر';
  @override
  String get storeCrn => 'التسجيل التجاري للمتجر';
  @override
  String get storeWorkingTime => 'وقت عمل المتجر';
  @override
  String get storeWorkingTimeFixed => 'وقت عمل ثابت';
  @override
  String get storeWorkingTimeCustom => 'وقت عمل مخصص';
  @override
  String get storeImage => 'صورة المتجر';
  @override
  String get storeTo => 'إلى';
  @override
  String get storeAddWorkingTime => 'إضافة وقت العمل';
  @override
  String get storeAdress => 'عنوان المتجر';
  @override
  String get storeAdressLine1 => 'العنوان الأول';
  @override
  String get storeAdressLine2 => 'العنوان الثاني';
  @override
  String get storeAdressCountry => 'الدولة';
  @override
  String get storeAdressRegion => 'المنطقة';
  @override
  String get storeAdressCity => 'المدينة';
  @override
  String get storePostalCode => 'الرمز البريدي';
  @override
  String get storePolicy => 'سياسة المتجر';
  @override
  String get storeKeepPolicy => 'الإبقاء على السياسة';
  @override
  String get storeSetCustomPolicy => 'تعيين سياسة مخصصة';
  @override
  String get storeSelectWorkingTimeOption => 'حدد خيار وقت العمل.';
  @override
  String get storeSelectStoreLocation =>
      'حدد موقع متجرك من محدد العناوين ، ثم قم بتعديل معلومات العنوان لمزيد من الدقة.';

  @override
  String get storeSelectAddress => 'حدد عنوان.';
  @override
  String get storeCommercialRegistrationNumber =>
      'يرجى تقديم رقم التسجيل التجاري الخاص بك. هذا هو معرف فريد يتم تعيينه لشركتك من قبل السلطة الحكومية المعنية.';

  @override
  String get storeWorkingTimeDescription =>
      'من خلال تحديث ساعات عملك في التطبيق، سيتم إبلاغ عملائك عندما تكون مفتوحًا لاستلام الطلبات. خذ لحظة لإضافة ساعات عملك والحفاظ على عملائك على اطلاع.';

  @override
  String get storeSetGlobalPolicy =>
      'يرجى تعيين السياسة العامة الخاصة بك قبل إنشاء متجر جديد.';
  @override
  String get storeGlobalPolicyDescription =>
      'لضمان التسلسل في جميع متاجرك، من المهم تحديد سياسة عامة تنطبق على جميع متاجرك. يمكن أن تتضمن هذه السياسة التفاصيل مثل سياسات الشحن والإرجاع، شروط الخدمة ومعلومات مهمة أخرى لعملائك.\n\nلتحديد السياسة العامة الخاصة بك، يُرجى النقر على زر "تعيين السياسة" أدناه. إذا كنت غير مستعد لتحديد السياسة في الوقت الحالي، يمكنك النقر على "إلغاء".';

  @override
  String get createANewShop => 'إنشاء متجر جديد';
  @override
  String get updateShop => 'تحديث المتجر';
  @override
  String get shopOwner => 'مالك المتجر';
  @override
  String get shopDetails => 'تفاصيل المتجر';
  @override
  String get hintShopName => 'أعط اسم لمتجرك';
  @override
  String get hintShopCategory => 'حدد فئة مستهدفة';
  @override
  String get hintShopDescription => 'اكتب تفاصيل متجرك هنا ...';
  @override
  String get shopAddress => 'عنوان المتجر';
  @override
  String get hintShopAddress => 'اختر عنوانًا';
  @override
  String get shopCoverImage => 'صورة المتجر';
  @override
  //[Store]
  @override
  String get storeProducts => 'منتجات المتجر.';
  @override
  String get allProducts => 'جميع المنتجات.';
  @override
  String get storeOffers => 'عروض المتجر.';
  @override
  String get newItem => 'جديد';

  /// [Product]
  // common
  @override
  String get product => 'المنتج';
  @override
  String get products => 'المنتوجات';
  @override
  String get brand => 'الماركة';
  @override
  String get price => 'السعر';
  @override
  String get quantity => 'الكمية';
  @override
  String get outOfStock => 'لم يتبقى';
  @override
  String get likes => 'الإعجابات';
  @override
  String get sells => 'المبيعات';
  @override
  String get rating => 'التقييم';
  @override
  String get aboutProduct => 'حول المنتج';
  // that of user
  @override
  String get reviews => 'تقييم';
  @override
  String get left => 'باقي';

  @override
  String get addToCartMessage => 'تمت إضَافة المنتج إلى السَلة بنجاح!';
  @override
  String get addToWishlist => 'أَضِف إلى قائمة الرَّغبَات';
  @override
  String get addToWishlistMessage => 'تمت إضَافة المنتج إلى قائمة الرَّغبات!';
  @override
  String get removeFromWishlistMessage => 'تم حذف المنتج من قائمة الرَّغبات!';
  @override
  String get reportProduct => 'الإبلاغ عن المنتج';
  // that of seller
  @override
  String get addProduct => 'إضافة المنتوج';
  @override
  String get newProduct => 'منتوج جديد';
  @override
  @override
  String get productCreateNew => 'إنشاء منتج جديد';
  @override
  String get productName => 'اسم المنتج';
  @override
  String get productDetails => 'تفاصيل المنتج';
  @override
  String get productSelectCategory => 'اختر الفئة';
  @override
  String get productDescription => 'وصف المنتج';
  @override
  String get productImage => 'صورة المنتج';
  @override
  String get productYourOffer => 'عرضك';
  @override
  String get productPriceIn => 'السعر بـ';
  @override
  String get productQuantity => 'الكمية';
  @override
  String get productAddVariants => 'إضافة الاختلافات';
  @override
  String get productOptions => 'خيارات';
  @override
  String get productAddOptions => 'إضافة خيارات';
  @override
  String get productPolicy => 'سياسة المنتج';
  @override
  String get productKeepStorePolicy => 'الإبقاء على سياسة المتجر';
  @override
  String get productSetProductPolicy => 'تعيين سياسة المنتج';
  @override
  String get productCategoryInfo =>
      'يجب أن ينتمي كل منتج إلى فئة واحدة. تصنيف المنتجات بدقة للترويج وزيادة الرؤية.';
  @override
  String get productPriceQuantityInfo =>
      'يرجى إدخال السعر والكمية لكل منتج بدقة. إذا قدمت متغيرات المنتجات، حدد التفاصيل الأساسية والاختلافات. حافظ على معلومات منتجك محدثة لتجربة بيع سلسة.';
  @override
  String get productVariations => 'اختلافات.';
  @override
  String get productGlobalPolicyInfo =>
      'تضمن السياسة العالمية إجراءات عادلة وشفافة. عند إنشاء متجر جديد، يمكنك الاحتفاظ بهذه السياسة لجميع المتاجر الخاصة بك أو إنشاء سياسة مخصصة لكل متجر. قم بمراجعة السياسة وإنشاء سياسات مخصصة لبناء الثقة مع عملائك.';
  @override
  String get productUpdateButton => 'تحديث.';
  @override
  String get productConfirmButton => 'تأكيد.';

  @override
  String get editProduct => 'تعديل المنتوج';
  @override
  String get deleteProduct => 'حذف المنتوج';
  @override
  String get deleteProductMessage =>
      'تحذير: من المحتمل أن يكون هذا إجراءً مدمرًا.';

  /// [ProductAdderScreen] and [ProductEditScreen]
  @override
  String get createNewProduct => 'إنشاء منتوج جديد';
  @override
  String get updateProduct => 'تحديث المنتوج';
  @override
  String get hintProductShop => 'إختر متجر المنتوج';
  @override
  String get hintProductName => 'سمي منتوجك';
  @override
  String get hintProductBrand => 'أي شركة صنعت هذا المنتج؟';
  @override
  String get hintProductDescription => 'اكتب بضعة أسطر تصف منتجك لزبائنك ...';
  @override
  String get yourOffer => 'عرضك';
  @override
  String get hintProductPrice => 'كم السعر وحدة واحدة؟';
  @override
  String get hintProductQuantity => 'المخزون الافتتاحي لهذا المنتوج';
  @override
  String get productImages => 'صور المنتوج';

  ///[Addoptions]
  @override
  String get variantsCharacteristic => 'سمة الاختلافات.';
  @override
  String get characteristicDescription =>
      'هنا يمكنك تعيين سمات منتجك.\nمثال: اللون، الحجم، اللغة ... إلخ';
  @override
  String get addNewValue => 'إضافة قيمة جديدة.';
  @override
  String get addNewOption => 'إضافة خيار جديد.';

  @override
  String get submit => 'إرسال.';
  @override
  String get optionDialogTitle => 'إضافة خيار جديد.';
  @override
  String get optionDialogOptionName => 'اسم الخيار';
  @override
  String get customOptionName => 'اسم خيار مخصص';
  @override
  String get optionDialogSubmit => 'إرسال';
  @override
  String get deleteOptionDialogTitle =>
      'هل أنت متأكد من رغبتك في حذف هذا الخيار؟';
  @override
  String get deleteOptionDialogCancel => 'إلغاء';
  @override
  String get deleteOptionDialogDelete => 'حذف';
  @override
  String get valueDialogTitle => 'إضافة قيمة جديدة.';
  @override
  String get valueDialogValueName => 'اسم القيمة';
  @override
  String get valueDialogSubmit => 'إرسال';
  ////{ Stat }
  String get globalStatistics => 'الإحصائيات العامة';
  String get views => 'المشاهدات';
  String get sales => 'المبيعات';
  String get productViewed => 'تمت مشاهدة المنتج';
  String get productSold => 'تم بيع المنتج';
  String get productCategory => 'فئة المنتج';
  String get week => 'أسبوع';
  String get day => 'يوم';
  String get month => 'شهر';
  String get geographicSales => 'مبيعات جغرافية';

  String get productSales => 'مبيعات المنتج';
  String get storeSales => 'مبيعات المتجر';
  String get storeViews => 'مشاهدات المتجر';
  String get totalViews => 'إجمالي المشاهدات';
  String get productViews => 'مشاهدات المنتج';
  String get noProductViewed => 'لم يتم مشاهدة أي منتج';
  String get totalSales => 'إجمالي المبيعات:';
}
