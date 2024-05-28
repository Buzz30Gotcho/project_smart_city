import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proximity_client/ui/pages/main_pages/widgets/single_select.dart';
import 'package:proximity_client/ui/pages/main_pages/widgets/single_select_dialog.dart';

void main() {
  group('Search Bar Tests', () {

  testWidgets('SingleSelectDialog Test', (WidgetTester tester) async {
    // Créez une liste d'éléments à sélectionner
    final List<SingleSelectItem<String>> items = [
      SingleSelectItem<String>('Item 1', 'Item 1'),
      SingleSelectItem<String>('Item 2', 'Item 2'),
      SingleSelectItem<String>('Item 3', 'Item 3'),
    ];

    // Créez un widget SingleSelectDialog avec des paramètres appropriés
    await tester.pumpWidget(
      MaterialApp(
        home: SingleSelectDialog<String>(
          items: items,
          initialValue: 'Item 2', // Sélectionnez un élément initialement
          title: const Text('Select Item'),
          confirmText: const Text('CONFIRM'),
          cancelText: const Text('CANCEL'),
          onConfirm: (selectedValue) {
            // Ici, vous pouvez vérifier si la valeur sélectionnée est correcte
            expect(selectedValue, 'Item 2');
          },
        ),
      ),
    );

    // Attendez que le widget soit rendu
    await tester.pumpAndSettle();

    // Vérifiez si le titre est correct
    expect(find.text('Select Item'), findsOneWidget);

    // Vérifiez si les éléments sont correctement affichés
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);


    // Appuyez sur le bouton de confirmation
    await tester.tap(find.text('CONFIRM'));
    await tester.pumpAndSettle();

      });

  testWidgets('Find SeachBar Text Test', (WidgetTester tester) async {

  await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleSelectDialog<String>(
            items: const [],
          ),
        ),
      ),
    );

    // Wait for the widget to render
    await tester.pumpAndSettle();

    // Find the TextField widget by type
    expect(find.text("Select Category"), findsOneWidget);

  });
  });
}
