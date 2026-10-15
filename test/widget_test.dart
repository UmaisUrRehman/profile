import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/main.dart';

void main() {
  testWidgets('Profile screen renders user name and handles follow interaction',
      (WidgetTester tester) async {
    // Set standard screen size for test environment
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build ProfileApp and trigger a frame.
    await tester.pumpWidget(const ProfileApp());

    // Verify student name and role render correctly.
    expect(find.text('Umais Ur Rehman'), findsWidgets);
    expect(find.text('Flutter Developer Intern'), findsOneWidget);

    // Verify statistics widgets are present.
    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Followers'), findsOneWidget);

    // Verify initial follow button state.
    final followBtn = find.widgetWithText(ElevatedButton, 'Follow');
    expect(followBtn, findsOneWidget);

    // Tap Follow button and verify state changes to Following.
    await tester.ensureVisible(followBtn);
    await tester.tap(followBtn);
    await tester.pump();

    // Verify button text changed to Following
    expect(find.widgetWithText(ElevatedButton, 'Following'), findsOneWidget);
  });
}
