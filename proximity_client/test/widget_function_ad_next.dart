// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:proximity_client/proximity_app.dart';
import 'package:proximity_client/ui/pages/main_pages/widgets/ad_section.dart';
import 'package:proximity_client/ui/pages/pages.dart';

void main() {
  testWidgets('Test de la fonction _nextAd', (WidgetTester tester) async {
    // Créer une liste d'annonces
    final List<String> ads = ['./assets/apple-pay.png', './assets/google-pay.png'];

    // Créer le widget avec la liste d'annonces
  await tester.pumpWidget(AdSection(ads: ads));

    // Attendre que les animations se terminent
    await tester.pumpAndSettle();

    // Vérifier que l'index est initialement égal à 0
    expect(find.text('_index: 0'), findsOneWidget);

    // Appeler la méthode _nextAd
    await tester.pump(); // Avancer dans le temps d'un frame
    await tester.pump(const Duration(seconds: 2)); // Attendre 2 secondes pour que _nextAd soit appelée

    // Attendre que les animations se terminent
    await tester.pumpAndSettle();

    // Vérifier que l'index a été mis à jour après l'appel de _nextAd
    expect(find.text('_index: 1'), findsOneWidget);

    // Attendre que la transition de l'annonce soit effectuée
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Vérifier que la nouvelle annonce est affichée correctement
    expect(find.byWidgetPredicate((widget) {
      if (widget is Image) {
        return ads.contains(widget.image.toString());
      }
      return false;
    }), findsOneWidget);
  });
}
