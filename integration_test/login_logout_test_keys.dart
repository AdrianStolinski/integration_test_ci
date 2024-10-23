import 'package:counter_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login and Logout test with keys',
      (WidgetTester tester) async {

    // Start the app.
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Verify the Login button is shown
    expect(find.byKey(const ValueKey('LoginBtn')), findsOneWidget);

    // Tap on the Login button
    await tester.tap(find.byKey(const ValueKey('LoginBtn')));
    await tester.pumpAndSettle();

    // Verify that the Email and Password fields are displayed on the login page
    expect(find.byKey(const ValueKey('EmailsTF')), findsOneWidget);
    expect(find.byKey(const ValueKey('PasswordTF')), findsOneWidget);

    // Enter text in the Email field
    await tester.enterText(find.byKey(const ValueKey('EmailsTF')), 'test@test.fdt');
    await tester.pumpAndSettle();

    // Enter text in the Password field
    await tester.enterText(find.byKey(const ValueKey('PasswordTF')), 'qwerty');
    await tester.pumpAndSettle();

    // Confirm typed text
    expect(find.text('test@test.fdt'), findsOneWidget);
    expect(find.text('qwerty'), findsOneWidget);

    // Tap on the main App widget to unfocus
    await tester.tap(find.byType(App));
    await tester.pumpAndSettle();

    // Verify that the Login button is now enabled. Additional precaution to avoid false test failing.
    final Finder loginButtonIsActive =
        find.byKey(const ValueKey('LoginBtn'));
    expect(loginButtonIsActive, findsOneWidget);
    expect(
      tester.widget<FilledButton>(loginButtonIsActive).onPressed,
      isNotNull, // Button should be enabled
    );

    // Tap the Login button
    await tester.tap(loginButtonIsActive);
    await tester.pumpAndSettle();

    // Verify the Logout button is shown
    expect(find.byKey(const ValueKey('LogoutBtn')), findsOneWidget);

    // Verify the correct user is logged in
    expect(find.text('Email: test@test.fdt'), findsOneWidget);
    await tester.pumpAndSettle();

    // Verify that the Logout button is now enabled. Additional precaution to avoid false test failing.
    final Finder logoutButtonIsActive =
        find.byKey(const ValueKey('LogoutBtn'));
    expect(logoutButtonIsActive, findsOneWidget);
    expect(
      tester.widget<FilledButton>(logoutButtonIsActive).onPressed,
      isNotNull, // Button should be enabled
    );

    // Tap the Logout button
    await tester.tap(logoutButtonIsActive);
    await tester.pumpAndSettle();

    // Verify the user is logged out
    expect(find.byKey(const ValueKey('LoginBtn')), findsOneWidget);
  });
}
