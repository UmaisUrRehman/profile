import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/main.dart';

void main() {
  testWidgets('Form validation test: empty fields trigger error messages',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FoundationsApp());

    // Verify form header and fields render
    expect(find.text('UI Foundations: Forms & Input'), findsOneWidget);
    expect(find.text('Full Name *'), findsOneWidget);
    expect(find.text('Email Address *'), findsOneWidget);
    expect(find.text('Phone Number *'), findsOneWidget);

    // Tap Submit Form with empty inputs
    final submitBtn = find.text('Submit Form');
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    // Verify validation errors appear
    expect(find.text('Full name is required.'), findsOneWidget);
    expect(find.text('Email address is required.'), findsOneWidget);
    expect(find.text('Phone number is required.'), findsOneWidget);
  });

  testWidgets('Form validation test: valid inputs allow successful submission',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FoundationsApp());

    // Fill valid data
    await tester.enterText(
        find.byType(TextFormField).at(0), 'Umais Ur Rehman');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'umais@example.com');
    await tester.enterText(find.byType(TextFormField).at(2), '03001234567');

    // Agree to terms checkbox
    final checkbox = find.byType(CheckboxListTile);
    await tester.ensureVisible(checkbox);
    await tester.tap(checkbox);
    await tester.pump();

    // Submit form
    final submitBtn = find.text('Submit Form');
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    // Verify summary dialog or SnackBar appears
    expect(find.text('Registration Summary'), findsOneWidget);
    expect(find.text('Name: Umais Ur Rehman'), findsOneWidget);
  });
}
