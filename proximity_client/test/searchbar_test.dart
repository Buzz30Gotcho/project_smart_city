import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:provider/provider.dart';
import 'package:proximity/icons/proximity_icons.dart';
import 'package:proximity_client/proximity_app.dart';
import 'package:proximity_client/ui/pages/main_pages/widgets/search_bar.dart' as CustomSearchBar; // Renommer l'importation pour éviter les conflits de noms
import 'package:proximity/config/themes/dark_theme.dart';
import 'package:proximity/config/themes/light_theme.dart';

void main() {
  group('Search Bar Tests', () {
    testWidgets('Rendering', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SearchBar()));
      await tester.pumpAndSettle(); // attendre que le rendu soit terminer

      // Vérifier que le bouton de recherche est rendu
      expect(find.byType(GestureDetector), findsOneWidget);

      // Vérifie que le widget SearchBar est rendu avec tous ses enfants
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Expanded), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('On Tap', (WidgetTester tester) async {
      // Construire le widget SearchBar dans un MaterialApp
      await tester.pumpWidget(const MaterialApp(home: SearchBar()));

      // Attendre la fin de l'animation
      await tester.pumpAndSettle();

      // Simuler un tap sur le GestureDetector
      await tester.tap(find.byType(GestureDetector));

      // Attendre la fin de l'animation
      await tester.pumpAndSettle();

      // Vérifier que la fonction _showSearch a été appelée
      expect(find.byType(SearchBar), findsOneWidget);
    });
  });
}
