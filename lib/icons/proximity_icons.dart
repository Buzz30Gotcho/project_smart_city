import 'package:flutter/material.dart';
import 'package:proximity/config/themes/dark_theme.dart';
import 'package:proximity/config/themes/light_theme.dart';


class DuotoneIcon extends StatelessWidget {
  const DuotoneIcon(
      {Key? key,
      required this.primaryLayer, 
      this.secondaryLayer,
      this.size,
      this.color})
      : super(key: key);

  final IconData? primaryLayer, secondaryLayer;
  final double? size;
  final Color? color;
// on oblige la classe a accepte un atribut de icon 'primaryLayer', les autres sont facultatifs
// c'est a dire quand on appelle la classe DuotoneIcon on devra forcement mettre un attribut
  @override
  Widget build(BuildContext context) { // le widget DuotoneIcon affiche 2 icones superposees
    return SizedBox(
        width: size ?? Theme.of(context).iconTheme.size,
        height: size ?? Theme.of(context).iconTheme.size,
        child: Stack(alignment: Alignment.center, children: [
          Icon(primaryLayer,
              color: (Theme.of(context).brightness == Brightness.light)
                  ? color ?? Theme.of(context).primaryColor
                  : null,
              size: size ?? Theme.of(context).iconTheme.size),
          Icon(secondaryLayer,
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? color ?? Theme.of(context).primaryColor
                  : null,
              size: size ?? Theme.of(context).iconTheme.size)
        ]));
  }
}

class ProximityIcons {
  ProximityIcons._();

  static const _fontFamily = 'Proximity';// NOM DE LA FAMILLE DE POLICE
  static const _packageName = 'proximity';// NOM DU PACKAGE OU SE TROUVENT LES ICONES PERSONNALISES
  static const IconData applePay = IconData(0xe9a1, fontFamily: _fontFamily, fontPackage: "mbi");
  static const IconData googlePay = IconData(0xeaab, fontFamily: _fontFamily, fontPackage: "mbi") ;

// ICON QR CODE
 // static const IconData qr_code_scanner = IconData(0xe4f7,fontFamily: _fontFamily, fontPackage: "mbi");
static const IconData qr_code_scanner = IconData(0xe4f7, fontFamily: 'MaterialIcons');
// ---------------------------------------------
  static const IconData order =
      IconData(0xe800, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData dark_theme =
      IconData(0xe801, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData language = 
      IconData(0xe802, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData light_theme =
      IconData(0xe803, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData support =
      IconData(0xe804, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData appearance =
      IconData(0xe805, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData edit =
      IconData(0xe806, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData history_duotone_1 =
      IconData(0xe807, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData preferences =
      IconData(0xe808, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData settings =
      IconData(0xe809, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData cart_duotone_1 =
      IconData(0xe80a, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData delivery_duotone_1 =
      IconData(0xe80b, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData delivery_duotone_2 =
      IconData(0xe80c, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData history_duotone_2 =
      IconData(0xe80d, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData home_duotone_2 =
      IconData(0xe80e, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData rejected_duotone_1 =
      IconData(0xe80f, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData rejected_duotone_2 =
      IconData(0xe810, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData self_pickup_duotone_1 =
      IconData(0xe811, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData self_pickup_duotone_2 =
      IconData(0xe812, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData user_duotone_1 =
      IconData(0xe813, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData user_duotone_2 =
      IconData(0xe814, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData address =
      IconData(0xe815, fontFamily: _fontFamily, fontPackage: _packageName);

  static const IconData calendar =
      IconData(0xe816, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData credit_card =
      IconData(0xe817, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData description =
      IconData(0xe818, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData email =
      IconData(0xe819, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData cart_duotone_2 =
      IconData(0xe81a, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData flashdeal =
      IconData(0xe81b, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData history =
      IconData(0xe81c, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData map_duotone_2 =
      IconData(0xe81d, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData phone =
      IconData(0xe81e, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData policy =
      IconData(0xe81f, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData quantity =
      IconData(0xe820, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData shipping =
      IconData(0xe821, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData visa =
      IconData(0xe822, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData cart =
      IconData(0xe823, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData check =
      IconData(0xe824, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData check_filled =
      IconData(0xe825, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData delivery =
      IconData(0xe826, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData home =
      IconData(0xe827, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData product =
      IconData(0xe828, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData rejected =
      IconData(0xe829, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData self_pickup =
      IconData(0xe82a, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData store =
      IconData(0xe82b, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData user =
      IconData(0xe82c, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData star =
      IconData(0xe82d, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData star_filled =
      IconData(0xe82e, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData add =
      IconData(0xe82f, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData arrow_more =
      IconData(0xe830, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData heart =
      IconData(0xe831, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData heart_filled =
      IconData(0xe832, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData info =
      IconData(0xe833, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData more =
      IconData(0xe834, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData notifications =
      IconData(0xe835, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData remove =
      IconData(0xe836, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData share =
      IconData(0xe837, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData subtract =
      IconData(0xe838, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData warning =
      IconData(0xe839, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData chevron_bottom =
      IconData(0xe83a, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData chevron_left =
      IconData(0xe83b, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData chevron_right =
      IconData(0xe83c, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData chevron_top =
      IconData(0xe83d, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData eye_off =
      IconData(0xe83e, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData eye_on =
      IconData(0xe83f, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData map =
      IconData(0xe840, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData password =
      IconData(0xe841, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData search =
      IconData(0xe842, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData home_duotone_1 =
      IconData(0xe843, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData map_duotone_1 =
      IconData(0xe844, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData unpaid_duotone_1 =
      IconData(0xe847, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData unpaid_duotone_2 =
      IconData(0xe848, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData reviews_duotone_1 =
      IconData(0xe849, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData reviews_duotone_2 =
      IconData(0xe84a, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData not_shipped_duotone_2 =
      IconData(0xe84b, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData not_shipped_duotone_1 =
      IconData(0xe84c, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData freeze =
      IconData(0xe84d, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData promotion =
      IconData(0xe84e, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData picture =
      IconData(0xe84f, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData gavel =
      IconData(0xf0e3, fontFamily: _fontFamily, fontPackage: _packageName);
  //static const IconData camera = IconData(Icons.camera, fontFamily: _fontFamily, fontPackage: _packageName);

  /// Illustrations
  static const IconData no_results_illustration =
      IconData(0xe845, fontFamily: _fontFamily, fontPackage: _packageName);
  static const IconData empty_illustration =
      IconData(0xe846, fontFamily: _fontFamily, fontPackage: _packageName);
}
