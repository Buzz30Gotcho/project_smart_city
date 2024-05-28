import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proximity_client/ui/pages/user_pages/view/qr_code_screen.dart'; 

void main() {
  testWidgets('QrCodeScreen displays correctly', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: QrCodeScreen(),
    ));

    // Verify if the app bar title is displayed correctly
    expect(find.text('QR Code'), findsOneWidget);

    // Verify if the informative message is displayed correctly
    expect(find.text('Qr Code à montrer au coursier'), findsOneWidget);
  });
}
