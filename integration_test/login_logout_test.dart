import 'package:counter_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login button is visible when user is not signed in',
      (WidgetTester tester) async {

    // Start the app
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Verify the Login button is shown
    expect(find.widgetWithText(FilledButton, 'Login'), findsOneWidget);

    // Tap on the Login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that the Email and Password fields are displayed on login_page
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Enter text in the Email field
    await tester.enterText(find.byType(TextField).at(0), 'test@test.fdt');
    await tester.pumpAndSettle();

    // Enter text in the Password field
    await tester.enterText(find.byType(TextField).at(1), 'qwerty');
    await tester.pumpAndSettle();

    // Confirm typed text
    expect(find.text('test@test.fdt'), findsOneWidget);
    expect(find.text('qwerty'), findsOneWidget);

    // Tap on the main App widget to unfocus
    await tester.tap(find.byType(App));
    await tester.pumpAndSettle();

    // Verify that the Login button is now enabled. Additional precaution to avoid false test failing.
    final Finder loginButtonIsActive =
        find.widgetWithText(FilledButton, 'Login');
    expect(loginButtonIsActive, findsOneWidget);
    expect(
      tester.widget<FilledButton>(loginButtonIsActive).onPressed,
      isNotNull, // Button should be enabled
    );

    // Tap the Login button
    await tester.tap(loginButtonIsActive);
    await tester.pumpAndSettle();

    // Verify the Logout button is shown
    expect(find.widgetWithText(FilledButton, 'Logout'), findsOneWidget);

    // Verify the correct user is logon
    expect(find.text('Email: test@test.fdt'), findsOneWidget);
    await tester.pumpAndSettle();

    // Verify that the Logout button is now enabled. Additional precaution to avoid false test failing.
    final Finder logoutButtonIsActive =
        find.widgetWithText(FilledButton, 'Logout');
    expect(logoutButtonIsActive, findsOneWidget);
    expect(
      tester.widget<FilledButton>(logoutButtonIsActive).onPressed,
      isNotNull, // Button should be enabled
    );

    // Tap the Logout button
    await tester.tap(logoutButtonIsActive);
    await tester.pumpAndSettle();

    // Verify the user is logout
    expect(find.widgetWithText(FilledButton, 'Login'), findsOneWidget);
  });
}
