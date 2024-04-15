import 'package:proximity/l10n/app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  /// [AppClient ]
  /// [HomeTabView]
  String get todaysDeals => 'Offres du jour';
  String get productsAroundYou => 'Produits à proximité';
  String get todaysDealsLowercase => 'Offres du jour';
  String get search => 'Recherche';

  ///[ProductScreen]
  ////[PolicySection]
  String get policyDeliveryReturns => "Politique de livraison et de retours .";
  String get shipping => "Expédition";
  String get estimatedDeliveryTime =>
      "Le délai de livraison estimé est de jours. Les frais d'expédition seront négociés pour ce produit";
  String get pickupReminder1 =>
      "N'oubliez pas de récupérer votre commande dans notre magasin dans un délai de ";
  String get pickupReminder2 =>
      "jours, sinon elle sera remise en rayon. Ne manquez pas cette occasion de l'avoir !.";
  String get returnRefundWithShipping1 =>
      "Vous pouvez retourner votre article dans les";
  String get returnRefundWithShipping2 =>
      "jours suivant la réception pour un remboursement, à condition que l'article soit";
  String get returnRefundWithShipping3 =>
      ". en cas d'acceptation du retour, le magasin remboursera les frais d'expédition et";
  String get returnRefundWithShipping4 => "% du prix";
  String get returnRefundWithoutShipping1 =>
      "Vous pouvez retourner votre article dans les";
  String get returnRefundWithoutShipping2 =>
      "jours suivant la réception pour un remboursement, à condition que l'article soit";
  String get returnRefundWithoutShipping3 =>
      ". en cas d'acceptation du retour, le magasin remboursera";
  String get returnRefundWithoutShipping4 =>
      "% du prix, les frais d'expédition ne sont pas remboursés";
  String get returnRefundOnlyShipping1 =>
      "Vous pouvez retourner votre article dans les";
  String get returnRefundOnlyShipping2 =>
      "jours suivant la réception pour un remboursement, à condition que l'article soit";
  String get returnRefundOnlyShipping3 =>
      "en cas d'acceptation du retour, le magasin remboursera les frais d'expédition";
  String get returnRefund => "Retour et remboursement  ";

  String get similarProducts => "Produits similaires.";

  /// [StoreSection]
  String get monday => 'Lundi';
  String get tuesday => 'Mardi';
  String get wednesday => 'Mercredi';
  String get thursday => 'Jeudi';
  String get friday => 'Vendredi';
  String get saturday => 'Samedi';
  String get sunday => 'Dimanche';
  String get closed => 'Fermé';
  String get open => 'Ouvert';
  String get noWorkingHours => 'Pas d\'heures de travail disponibles';
  String get cancel => 'Annuler';

  String get goToStore => 'Aller au magasin';

  ///// [ActionsSection]
  String get addToCart => "Add to Cart.";
  String get buyNow => "Acheter";

  @override
  String get ishop => 'Ishop';
  @override
  String get ishopSlogan => 'The best shopping experience.';

  @override
  String get dzd => 'DZD';

  /// [authentication]
  @override
  String get email => 'E-mail';
  @override
  String get emailAddress => 'Adresse électronique';
  @override
  String get password => 'Mot de passe';
  @override
  String get createPassword => 'Créer un mot de passe';
  @override
  String get confirmPassword => 'Confirmez le mot de passe';
  @override
  String get forgotPassword => 'Mot de passe oublié?';
  @override
  String get weSentYouCode => 'Nous vous avons envoyé un code';
  @override
  String get weSentYouCodeMessage =>
      'Entrez ci-dessous votre code pour vérifier votre numéro de téléphone.';
  @override
  String get verificationCode => 'Code de vérification';
  @override
  String get didNotReceiveCode => "Vous n'avez pas reçu de code?";
  @override
  String get firstName => 'Prénom';
  @override
  String get lastName => 'Nom de famille';
  @override
  String get whereAreYouLocated => 'Où es-tu Situé?';
  @override
  String get birthDate => 'Date de naissance';
  @override
  String get phoneNumber => 'N° Tel';
  @override
  String get addPhoneNumber => 'Ajouter un Numéro de téléphone';
  @override
  String get addPhoneNumberCaption =>
      'Entrez le numéro de téléphone que vous souhaitez associer à votre compte iShop ci-dessous.';
  @override
  String get address => 'Adresse';
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
  String get gender => 'Genre';
  @override
  Map<int, String> get genders => {
        0: 'Femelle',
        1: 'Mâle',
      };
  @override
  String get register => "S'inscrire";
  @override
  String get login => 'Se connecter';
  @override
  String get logout => 'Se déconnecter';
  @override
  String get termsAndConditions => 'Termes et Conditions';
  @override
  String get byClickingNextYouAgreeToTermsAndConditions =>
      'En cliquant sur Suivant, vous acceptez nos conditions et que vous avez lu nos conditions générales.';
  @override
  String get createYourIshopAccount => 'Créez votre compte iShop';
  @override
  String get validate => 'Valider';

  @override
  String get next => 'Suivant';
  @override
  String get gettingStarted => 'Commencer';
  @override
  String get collapse => 'Réduire';

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

  /// [Wishlist]
  @override
  String get wishlist => 'Wishlist';
  @override
  String get emptyWishlistCaption => '💔\nYour Wishlist is empty.';

  /// [UserHomePage]
  @override
  String get home => 'Home';
  @override
  String get searchProduct => '';
  @override
  String get todayDeals => '';

  String get welcome => "Bienvenue";
  //// [ManageStores]
  String get editStore => 'Modifier la boutique ';
  String get freezeStore => 'Suspendre la boutique ';
  String get deleteStore => 'Supprimer la boutique ';

  /// [Profile]
  @override
  String get profile => 'Profil';
  @override
  String get editProfileTitle => 'Modifier le profil.';
  String get editProfileImage => 'Modifier la photo de profile';
  String get personalInfoTitle => 'Informations personnelles.';
  String get emailTitle => 'Email.';
  String get phoneNumberTitle => 'Numéro de téléphone.';
  String get addressTitle => 'Adresse.';
  String get selectAddressButton => 'Sélectionner une adresse.';
  String get streetAddressLine1Hint => 'Adresse ligne 1.';
  String get streetAddressLine2Hint => 'Adresse ligne 2.';
  String get countryHint => 'Pays.';
  String get regionHint => 'Région.';
  String get cityHint => 'Ville.';
  String get postalCodeHint => 'Code postal.';
  String get infoMessage =>
      'Votre adresse sera automatiquement utilisée comme adresse de livraison.';
  String get updateButton => 'Mettre à jour.';

  String get editProfile => 'Modifier mon profil';
  @override
  String get updateProfile => 'Mettre à jour mon profil';
  @override
  String get myUserId => 'Mon identifiant';
  @override
  String get personalInformation => 'Informations personnelles';
  @override
  String get personalInformationMessage =>
      'Fournissez vos informations personnelles, même si le compte est à usage professionnel. Ces informations ne seront pas publiques pour tout le monde.';
  @override
  String get about => 'À propos';
  @override
  String get help => 'Aide';
  @override
  String get edit => 'Modifier';
  @override
  String get promote => 'Promouvoir';
  @override
  String get freeze => 'Geler';
  @override
  String get delete => 'Supprimer';

  ///[Policy]
  String get globalPolicyTitle => 'Politique globale.';
  String get storePolicyTitle => 'Politique du boutique ';
  String get productPolicyTitle => 'Politique des produits';
  String get shippingTitle => 'Livraison';
  String get shippingPolicyTitle => 'Politique de livraison.';
  String get shippingPolicyInfo =>
      'Sélectionnez le type de livraisons que votre boutique  prend en charge, et définissez une taxe de livraison en cas de livraison de vos commandes.';
  String get deliveryToggleTitle => 'Livraison';
  String get selfPickupToggleTitle => 'Ramassage en boutique ';
  String get maxDaysToPickUpHint => 'Nombre de jours maximum pour le retrait.';
  String get ordersTitle => 'Commandes';
  String get notificationsTitle => 'Notifications.';
  String get realTimeNotificationsToggleTitle => 'Notifications en temps réel';
  String get hourlyNotificationsToggleTitle => 'Notifications horaires';
  String get batchNotificationsToggleTitle => 'Notifications groupées';
  String get notifyEveryHint => 'Je souhaite être notifié chaque.';
  String get batchNotificationFrequencyHint =>
      'Fréquence des notifications groupées.';
  String get orderNotificationPreferencesTitle =>
      'Préférences de notification ';
  String get inPlatformNotificationsToggleTitle =>
      'Notifications dans la plateforme';
  String get popUpNotificationsToggleTitle => 'Notifications pop-up';
  String get emailNotificationsToggleTitle => 'Notifications par e-mail';
  String get smsNotificationsToggleTitle => 'Notifications SMS';
  String get returnTitle => 'Retour';
  String get returnPolicyTitle => 'Politique de retour.';
  String get returnPolicyInfo =>
      'Ici, vous pouvez choisir d\'accepter les retours et définir des conditions telles que le délai, l\'état du produit et les frais de réapprovisionnement. Votre politique de retour sera visible par les clients sur les pages de vos produits, soyez clair et précis. Contactez notre équipe d\'assistance si vous avez besoin d\'aide ou si vous avez des questions.';
  String get allowReturnsToggleTitle => 'Autoriser les retours';
  String get maxDaysToReturnHint => 'Nombre de jours maximum pour le retour.';
  String get returnStatusHint => 'État du retour';
  String get returnMethodHint => 'Méthode de retour';
  String get refundPolicyTitle => 'Politique de remboursement.';
  String get shippingFeesToggleTitle => 'Frais d\'expédition.';
  String get fullRefundToggleTitle => 'Remboursement complet';
  String get partialRefundToggleTitle => 'Remboursement partiel';
  String get partialRefundAmountHint => 'Montant du remboursement partiel.';

  /// [Settings]
  @override
  String get settings => 'Paramètres';
  @override
  String get language => 'Langues';
  @override
  String get selectedLanguage => 'Français';
  @override
  String get theme => 'Thème';
  @override
  String get systemTheme => 'Thème du système';
  @override
  String get lightTheme => 'Thème lumineux';
  @override
  String get darkTheme => 'Thème sombre';
  @override
  String get reportProblem => 'Reporter un Probleme';
  @override
  String get seeAll => 'VOIR TOUT';

  /// [Order]
  // common
  @override
  String get order => 'Commande';
  @override
  String get orders => 'Commandes';
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
  String get checkout => 'Payer';
  String get orderSuccess =>
      'Votre commande a été passée avec succès, nous vous informerons une fois qu\'elle sera validée';
  String get done => 'Terminé';
  String get payment => 'Paiement';
  String get bills => 'Factures';
  String get items => 'Articles';
  String get back => 'Retour';
  String get reservationBill => 'Facture de Réservation';
  String get deliveryBill => 'Facture de Livraison';
  String get pickupBill => 'Facture de Retrait';
  String get paymentTotalBill => 'Facture Totale du Paiement';
  String get shippingAddress => 'Adresse de Livraison';
  String get pickupBy => 'Retrait Par';
  String get expirationDate => 'Date d\'expiration';
  String get billDetails => 'Détails de la Facture';
  String get reservation => 'Réservation';

  String get leftToPay => 'Reste à Payer';
  String get deliveryPriceFixedAt => 'Frais de Livraison Fixes à';
  String get distance => 'Distance';

  String get itemDeletedSuccessfully => 'Article supprimé avec succès';
  String get finishYourOrder => 'Finalisez votre commande';
  String get contactInformation => 'Informations de contact';
  String get name => 'Nom';

  // that of seller
  @override
  String get recentOrders => 'Commandes récentes';
  @override
  String get pendingOrders => 'Commandes en attente: ';
  @override
  String get deliveryToll => 'Livraison Péage: ';

  @override
  String get pending => 'En attente';
  @override
  String get selfPickup => 'Ramassage en boutique ';
  @override
  String get delivery => 'Livraison';
  @override
  String get returnOrder => 'Retour';
  @override
  String get refund => 'Remboursement';
  @override
  String get rejected => 'Rejeté';
  @override
  String get noPendingOrders => 'Il n\'y a aucune commande en attente.';
  @override
  String get noRefundOrders => 'Il n\'y a aucun remboursement de commande.';
  String get all => 'Tout';

  String get inPreparation => 'En préparation';
  String get awaitingRecovery => 'En attente de récupération';
  String get recovered => 'Récupérée';
  String get noInPreparationOrders =>
      'Il n\'y a pas de commandes en préparation.';
  String get noAwaitingRecoveryOrders =>
      'Il n\'y a pas de commandes en attente de récupération.';
  String get noRecoveredOrders => 'Il n\'y a pas de commandes récupérées.';
  String get noSelfPickupOrders =>
      'Il n\'y a pas de commandes en ramassage en magasin.';

  String get deliveryInfos => 'Informations de livraison.';
  String get setDeliveryArea => 'Définir la zone de livraison.';
  String get pickupInfos => 'Informations de retrait.';
  String get personNIN => 'Numéro d\'identification national (NIN)';

  String get noOnTheWayOrders =>
      'Il n\'y a pas de commandes en cours de livraison.';
  String get onTheWay => 'En cours de livraison';
  String get noDeliveredOrders => 'Il n\'y a pas de commandes livrées.';
  String get noDeliveryOrders => 'Il n\'y a pas de commandes de livraison.';

  String get noRejectedOrders => 'Il n\'y a pas de commandes rejetées.';

  String get noWaitingForReturnOrders =>
      'Il n\'y a pas de commandes en attente de retour.';
  String get waitingForReturn => 'En attente de retour';
  String get noReturnedOrders => 'Il n\'y a pas de commandes retournées.';
  String get noReturnOrders => 'Il n\'y a pas de commandes de retour.';
  String get returned => 'Retourné';

  /// [Shop]
  @override
  String get shop => 'Boutique';
  @override
  String get namePerson => 'Nom';
  @override
  String get description => 'Description';
  @override
  String get category => 'Catégorie';
  @override
  String get categories => 'Catégories';
  @override
  Map<int, String> get categoriesMap => {
        0: 'Mode',
        1: 'Téléphones portables',
        2: 'Jeux vidéo',
        3: 'Beauté',
        4: 'Automobile',
        5: 'Équipements sportifs',
        6: 'Ouvrages',
        7: 'Autre',
      };
  @override
  String get yourShops => 'Mes boutiques';
  @override
  String get addShop => 'Ajouter une boutique';
  @override
  String get newShop => 'Nouvelle Boutique';
  @override
  String get newShopMessage =>
      'La création d\'une boutique existante avec des adresses différentes reste possible tant que le propriétaire reste le même.';
  @override
  String get editShop => 'Modifier boutique';
  @override
  String get freezeShop => 'Geler boutique';
  @override
  String get freezeShopMessage =>
      'Si vous souhaitez fermer temporairement votre boutique, peut-être prendre des vacances pendant quelques jours, pensez à la congeler ❄.';
  @override
  String get deleteShop => 'Supprimer la boutique';

  @override
  String get deleteShopMessage =>
      "Avertissement : Il s'agit d'une action potentiellement destructrice.";
  @override
  String get reportShop => 'Report Shop';
  @override
  String get aboutShop => 'Sur la Boutique';

  /// [ShopAdderScreen] and [ShopEditScreen]
  @override
  String get storeDetails => 'Détails du boutique ';
  @override
  String get storeName => 'Nom du boutique ';
  @override
  String get storeDescription => 'Description du boutique ';
  @override
  String get storeCrn => 'Registre du Commerce du boutique ';
  @override
  String get storeWorkingTime => 'Horaires du boutique ';
  @override
  String get storeWorkingTimeFixed => 'Horaires Fixes';
  @override
  String get storeWorkingTimeCustom => 'Horaires Personnalisés';
  @override
  String get storeImage => 'Image du boutique ';
  @override
  String get storeTo => 'à';
  @override
  String get storeAddWorkingTime => 'Ajouter les Horaires';
  @override
  String get storeAdress => 'Adresse du boutique ';
  @override
  String get storeAdressLine1 => 'Adresse Ligne 1';
  @override
  String get storeAdressLine2 => 'Adresse Ligne 2';
  @override
  String get storeAdressCountry => 'Pays';
  @override
  String get storeAdressRegion => 'Région';
  @override
  String get storeAdressCity => 'Ville';
  @override
  String get storePostalCode => 'Code Postal';
  @override
  String get storePolicy => 'Politique du boutique ';
  @override
  String get storeKeepPolicy => 'Conserver la Politique';
  @override
  String get storeSelectStoreLocation =>
      'Sélectionnez l\'emplacement de votre boutique  à partir du sélecteur d\'adresse, puis modifiez les informations d\'adresse pour plus de précision.';
  @override
  String get storeSelectAddress => 'Sélectionnez une adresse.';
  @override
  String get storeSetCustomPolicy => 'Définir une Politique Personnalisée';
  @override
  String get storeSelectWorkingTimeOption =>
      'Sélectionnez une option d\'horaires de travail.';
  @override
  String get storeCommercialRegistrationNumber =>
      'Veuillez fournir votre numéro d\'immatriculation commerciale. Il s\'agit d\'un identifiant unique attribué à votre entreprise par l\'autorité gouvernementale compétente.';

  @override
  String get storeWorkingTimeDescription =>
      'En mettant à jour vos heures de travail dans l\'application, vos clients seront informés quand vous serez ouvert pour les retraits. Prenez un moment pour ajouter vos horaires de travail et tenir vos clients informés.';

  @override
  String get storeSetGlobalPolicy =>
      'Veuillez définir votre politique globale avant de créer un nouveau boutique .';
  @override
  String get storeGlobalPolicyDescription =>
      'Pour assurer la cohérence entre tous vos boutique s, il est important de définir une politique globale qui s\'appliquera à tous vos boutique s. Cette politique peut inclure des détails tels que les politiques d\'expédition et de retour, les conditions de service et d\'autres informations importantes pour vos clients.\n\nPour définir votre politique globale, veuillez cliquer sur le bouton "Définir la politique" ci-dessous. Si vous n\'êtes pas prêt à définir votre politique pour le moment, vous pouvez cliquer sur "Annuler".';

  @override
  String get createANewShop => 'Créer une nouvelle boutique';
  @override
  String get updateShop => 'Modifier la boutique';
  @override
  String get shopOwner => 'Propriétaire de la boutique';
  @override
  String get shopDetails => 'Détails de le boutique';
  @override
  String get hintShopName => 'Donner un nom à votre boutique';
  @override
  String get hintShopCategory => 'Selectionner une catégorie';
  @override
  String get hintShopDescription => 'Donner une description à votre boutique';
  @override
  String get shopAddress => 'Addresse de la boutique';
  @override
  String get hintShopAddress => 'Selectionner une addresse';
  @override
  String get shopCoverImage => 'Donner une image';
  @override
  String get newItem => 'Nouveau';

  ///[Store]
  @override
  String get storeProducts => 'Produits du boutique .';
  @override
  String get allProducts => 'Tous les produits.';
  @override
  String get storeOffers => 'Offres du boutique .';

  /// [Product]
  // common
  @override
  String get product => 'Produit';
  @override
  String get brand => 'Marque';
  @override
  String get price => 'Prix';
  @override
  String get quantity => 'Quantité';
  @override
  String get outOfStock => 'Out of Stock!';
  @override
  String get likes => 'J\'aime';
  @override
  String get sells => 'Ventes';
  @override
  String get rating => 'Note';
  @override
  String get aboutProduct => 'Sur le Produit';
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
  // that of seller
  @override
  String get products => 'Produits';
  @override
  String get addProduct => 'Ajouter produit';
  @override
  String get newProduct => 'Nouveau produit';
  @override
  String get productCreateNew => 'Créer un Nouveau Produit';
  @override
  String get productName => 'Nom du Produit';
  @override
  String get productDetails => 'Détails du Produit';
  @override
  String get productSelectCategory => 'Sélectionner une Catégorie';
  @override
  String get productDescription => 'Description du Produit';
  @override
  String get productImage => 'Image du Produit';
  @override
  String get productYourOffer => 'Votre Offre';
  @override
  String get productCategoryInfo =>
      'Chaque produit doit appartenir à une seule catégorie. Catégoriser les produits avec précision pour une meilleure promotion et visibilité.';
  @override
  String get productPriceQuantityInfo =>
      'Veuillez entrer le prix et la quantité de chaque produit avec précision. Si vous proposez des variantes de produits, spécifiez les détails de base et les variations. Gardez vos informations produit à jour pour une expérience de vente fluide.';
  @override
  String get productVariations => 'Variantes.';
  @override
  String get productGlobalPolicyInfo =>
      'La politique globale garantit des transactions équitables et transparentes. Lors de la création d\'un nouveau boutique , vous pouvez conserver cette politique pour tous vos boutique s ou créer une politique personnalisée pour chaque boutique . Examinez la politique et créez des politiques personnalisées pour instaurer la confiance avec vos clients.';
  @override
  String get productUpdateButton => 'Mettre à jour.';
  @override
  String get productConfirmButton => 'Confirmer.';

  @override
  String get productPriceIn => 'Prix en';
  @override
  String get productQuantity => 'Quantité';
  @override
  String get productAddVariants => 'Ajouter des Variantes';
  @override
  String get productOptions => 'Options';
  @override
  String get productAddOptions => 'Ajouter des Options';
  @override
  String get productPolicy => 'Politique du Produit';
  @override
  String get productKeepStorePolicy => 'Conserver la Politique du boutique ';
  @override
  String get productSetProductPolicy => 'Définir la Politique du Produit';

  @override
  String get editProduct => 'Modifier Produit';
  @override
  String get deleteProduct => 'Supprimer Produit';
  @override
  String get submit => 'Soumettre';
  @override
  String get stopPromoting => 'Arrêter la promotion';
  @override
  String get offerStock => 'Stock d\'offre';
  @override
  String get discount => 'Remise';
  @override
  String get deleteProductMessage =>
      "Avertissement : Il s'agit d'une action potentiellement destructrice.";
//[side Menu ]
// French Translations
  String get settingsText => 'Paramètres';
  String get editProfileText => 'Modifier le profil.';
  String get verifyIdentityText => 'Vérifier l\'identité.';
  String get editGlobalPolicyText => 'Modifier la politique globale.';
  String get statisticsText => 'Statistiques .';
  String get settingsButtonText => 'Paramètres.';
  String get appearanceText => 'Apparence.';
  String get languageText => 'Langue.';
  String get notificationsText => 'Notifications.';
  String get aboutText => 'À propos.';
  String get rateSmartCityText => 'Noter SmartCity.';
  String get contactSupportText => 'Contacter le support.';
  String get logoutText => 'Se déconnecter.';

  /// [ProductAdderScreen] and [ProductEditScreen]
  @override
  String get createNewProduct => 'Créer un nouveau produit';
  @override
  String get updateProduct => 'Mettre à jour un produit';
  @override
  String get hintProductShop => 'Veuilez choisir la boutique de votre produit';
  @override
  String get hintProductName => 'Donner un nom au produit';
  @override
  String get hintProductBrand => 'Il est de quel marque';
  @override
  String get hintProductDescription => 'Décrire votre produit';
  @override
  String get yourOffer => 'Votre offre';
  @override
  String get hintProductPrice => 'Prix d\'une unité ';
  @override
  String get hintProductQuantity => 'Quantité disponible';
  @override
  String get productImages => 'Images du produit';
  @override
  String get shopCrn => 'Numéro de Registre du Commerce du boutique ';
  @override
  String get shopWorkingTime => 'Horaires du boutique ';
  @override
  String get shopWorkingTimeFixed => 'Horaires fixes';
  @override
  String get shopWorkingTimeCustom => 'Horaires personnalisés';

  /// [ addOption]
  @override
  String get variantsCharacteristic => 'Caractéristiques des Variantes.';
  @override
  String get characteristicDescription =>
      'Ici, vous définissez les caractéristiques de votre produit.\nEx: Couleur, Taille, Langue... etc';
  @override
  String get addNewValue => 'Ajouter une nouvelle valeur.';
  @override
  String get addNewOption => 'Ajouter une nouvelle option.';
  @override
  String get productVariants => 'Variantes du produit.';

  @override
  String get moreVariants => 'plus de variantes';

  @override
  String get optionDialogTitle => 'Ajouter une nouvelle option.';
  @override
  String get optionDialogOptionName => 'Nom de l\'option';
  @override
  String get customOptionName => 'Nom de l\'option personnalisée';
  @override
  String get optionDialogSubmit => 'Soumettre';
  @override
  String get deleteOptionDialogTitle =>
      'Êtes-vous sûr de vouloir supprimer cette option?';
  @override
  String get deleteOptionDialogCancel => 'Annuler';
  @override
  String get deleteOptionDialogDelete => 'Supprimer';
  @override
  String get valueDialogTitle => 'Ajouter une nouvelle valeur.';
  @override
  String get valueDialogValueName => 'Nom de la valeur';
  @override
  String get valueDialogSubmit => 'Soumettre';
  //Stat
  String get globalStatistics => 'Statistiques';
  String get views => 'Vues';
  String get sales => 'Ventes';
  String get productViewed => 'Le produit a été consulté';
  String get productSold => 'Le produit a été vendu';
  String get productCategory => 'Catégorie de produit';
  String get week => 'semaine';
  String get day => 'jour';
  String get month => 'mois';
  String get geographicSales => 'Ventes géographiques';

  String get productSales => 'Ventes de produits';
  String get storeSales => 'Ventes de magasins';
  String get storeViews => 'Vues de magasins';
  String get totalViews => 'Vues totales';
  String get productViews => 'Vues de produits';
  String get noProductViewed => 'Aucun produit n\'a été consulté';
  String get totalSales => 'Ventes totales';
}
