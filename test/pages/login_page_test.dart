import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/pages/login_page.dart';

void main() {
  group('LoginPage', () {
    late GoRouter router;

    setUp(() {
      router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(body: Text('Home')),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
        ],
        initialLocation: '/login',
      );
    });

    testWidgets('renders all UI elements correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Verify logo image is present
      expect(find.byType(Image), findsOneWidget);

      // Verify text elements
      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text("Choose how you'd like to sign in"), findsOneWidget);
      expect(find.text('Sign in with shop'), findsOneWidget);
      expect(find.text('or'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);

      // Verify text field
      expect(find.byType(TextFormField), findsOneWidget);

      // Verify buttons
      expect(find.widgetWithText(ElevatedButton, 'Sign in with shop'),
          findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Continue'), findsOneWidget);

      // Verify divider
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('email text field accepts input', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      final textField = find.byType(TextFormField);
      expect(textField, findsOneWidget);

      // Enter text
      await tester.enterText(textField, 'test@example.com');
      await tester.pump();

      // Verify text was entered
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('Continue button is disabled', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      final continueButton = find.widgetWithText(ElevatedButton, 'Continue');
      expect(continueButton, findsOneWidget);

      final button = tester.widget<ElevatedButton>(continueButton);
      expect(button.onPressed, isNull);
    });

    testWidgets('Sign in with shop button is enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      final shopButton =
          find.widgetWithText(ElevatedButton, 'Sign in with shop');
      expect(shopButton, findsOneWidget);

      final button = tester.widget<ElevatedButton>(shopButton);
      expect(button.onPressed, isNotNull);
    });

    testWidgets('tapping logo navigates to home', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Find the GestureDetector that wraps the logo
      final gestureFinder = find.ancestor(
        of: find.byType(Image),
        matching: find.byType(GestureDetector),
      );
      expect(gestureFinder, findsOneWidget);

      // Ensure the widget is visible and tap it
      await tester.ensureVisible(gestureFinder);
      await tester.pumpAndSettle();

      await tester.tap(gestureFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify navigation to home
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('image error builder displays fallback UI',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Trigger error by waiting for network image to fail
      await tester.pump();

      // The error builder should show a Container with an Icon
      final imageWidget = tester.widget<Image>(find.byType(Image));
      expect(imageWidget.errorBuilder, isNotNull);

      // Manually invoke error builder to test it
      final errorWidget = imageWidget.errorBuilder!(
        tester.element(find.byType(Image)),
        Exception('Network error'),
        null,
      );

      expect(errorWidget, isA<Container>());
    });

    testWidgets('has correct layout structure', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Verify scaffold
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify center widget
      expect(find.byType(Center), findsWidgets);

      // Verify scrollable
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Verify card
      expect(find.byType(Card), findsOneWidget);

      // Verify column
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('has correct button styling', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Test Sign in with shop button styling
      final shopButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Sign in with shop'),
      );
      final shopButtonStyle = shopButton.style!;
      expect(
        shopButtonStyle.backgroundColor?.resolve({}),
        const Color(0xFF6842F6),
      );
      expect(shopButtonStyle.foregroundColor?.resolve({}), Colors.white);

      // Test Continue button styling
      final continueButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Continue'),
      );
      final continueButtonStyle = continueButton.style!;
      expect(
          continueButtonStyle.backgroundColor?.resolve({}), Colors.grey[200]);
      expect(continueButtonStyle.elevation?.resolve({}), 0);
    });

    testWidgets('text field has correct decoration',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Find the TextField (which is inside TextFormField)
      final textFieldFinder = find.descendant(
        of: find.byType(TextFormField),
        matching: find.byType(TextField),
      );
      expect(textFieldFinder, findsOneWidget);

      final textField = tester.widget<TextField>(textFieldFinder);
      final decoration = textField.decoration;

      expect(decoration?.hintText, 'Email');
      expect(decoration?.labelText, isNull);
      expect(decoration?.border, isA<OutlineInputBorder>());
    });

    testWidgets('card has correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, 0);
      expect(card.shape, isA<RoundedRectangleBorder>());
    });
  });
}
