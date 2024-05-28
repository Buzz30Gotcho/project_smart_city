import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proximity_client/ui/pages/product_pages/widgets/product_details_section.dart'; 

void main() {
  testWidgets('ProductDetailsSection displays correctly', (WidgetTester tester) async {
    // Define test data
    const String productName = 'Example Product';
    const double productPrice = 100.0;
    const double discount = 0.2;
    final DateTime discountEndDate = DateTime.now().add(Duration(days: 7));

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductDetailsSection(
            name: productName,
            price: productPrice,
            discount: discount,
            discountEndDate: discountEndDate,
          ),
        ),
      ),
    );

    // Verify if the product name is displayed
    expect(find.text(productName), findsOneWidget);

    // Verify if the original price and discounted price are displayed correctly
    // expect(find.text('€ $productPrice'), findsOneWidget);
    // final discountedPrice = (productPrice * (1 - discount)).toStringAsFixed(2);
    // expect(find.text('€ $discountedPrice'), findsOneWidget);

    // Verify if the discount percentage is displayed correctly
    expect(find.text('-${(discount * 100).toInt()}%'), findsOneWidget);
  });
}
