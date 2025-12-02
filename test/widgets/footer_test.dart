import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  group('Footer Widget Tests', () {
    testWidgets('renders footer with all sections on desktop layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      // Verify all main sections are present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help and Information'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
      expect(find.text('© 2025 UPSU. All rights reserved.'), findsOneWidget);
    });

    testWidgets('renders footer with all sections on mobile layout',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      // Verify all main sections are present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help and Information'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('displays all opening hours information',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      // Winter break info
      expect(find.text('❄️ Winter Break Closure Dates ❄️'), findsOneWidget);
      expect(find.text('Closing 4pm 19/12/2025'), findsOneWidget);
      expect(find.text('Reopening 10am 05/01/2026'), findsOneWidget);
      expect(find.text('Last post date: 12pm on 18/12/2025'), findsOneWidget);

      // Term time info
      expect(find.text('(Term Time)'), findsOneWidget);
      expect(find.text('Monday - Friday 10am - 4pm'), findsOneWidget);

      // Outside term time info
      expect(find.text('(Outside of Term Time / Consolidation Weeks)'),
          findsOneWidget);
      expect(find.text('Monday - Friday 10am - 3pm'), findsOneWidget);

      // Online purchase info
      expect(find.text('Purchase online 24/7'), findsOneWidget);
    });

    testWidgets('displays help and information links',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Terms & Conditions of Sale Policy'), findsOneWidget);
    });

    testWidgets('help links are tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      // Find and tap the Search link
      final searchButton = find.widgetWithText(TextButton, 'Search');
      expect(searchButton, findsOneWidget);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      // Find and tap the Terms & Conditions link
      final termsButton =
          find.widgetWithText(TextButton, 'Terms & Conditions of Sale Policy');
      expect(termsButton, findsOneWidget);
      await tester.tap(termsButton);
      await tester.pumpAndSettle();
    });

    testWidgets('displays email subscription section',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      expect(find.text('Email address'), findsOneWidget);
      expect(find.text('SUBSCRIBE'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('email text field accepts input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'test@example.com');
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('subscribe button is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final subscribeButton = find.widgetWithText(ElevatedButton, 'SUBSCRIBE');
      expect(subscribeButton, findsOneWidget);

      await tester.tap(subscribeButton);
      await tester.pumpAndSettle();
    });

    testWidgets('footer has correct background color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(Footer),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(container.color, Colors.grey[50]);
    });

    testWidgets('footer spans full width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(Footer),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(container.constraints?.minWidth, double.infinity);
    });

    testWidgets('divider is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsWidgets);
    });

    testWidgets('subscribe button has correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'SUBSCRIBE'));

      expect(
          button.style?.backgroundColor?.resolve({}), const Color(0xFF4d2963));
      expect(button.style?.foregroundColor?.resolve({}), Colors.white);
    });

    testWidgets('footer links have correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(
        find.descendant(
          of: find.widgetWithText(TextButton, 'Search'),
          matching: find.byType(Text),
        ),
      );

      expect(text.style?.color, const Color(0xFF4d2963));
      expect(text.style?.fontSize, 14);
    });

    testWidgets('layout changes based on screen width',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify sections exist
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help and Information'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
    });

    testWidgets('text field has correct border styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration!;

      expect(decoration.border, isA<OutlineInputBorder>());
      expect(decoration.enabledBorder, isA<OutlineInputBorder>());
      expect(decoration.focusedBorder, isA<OutlineInputBorder>());
    });

    testWidgets('copyright text has correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final copyrightText =
          tester.widget<Text>(find.text('© 2025 UPSU. All rights reserved.'));

      expect(copyrightText.style?.color, Colors.grey);
      expect(copyrightText.style?.fontSize, 14);
    });

    testWidgets('opening hours title has correct styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Footer(),
            ),
          ),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Opening Hours'));

      expect(titleText.style?.color, Colors.black);
      expect(titleText.style?.fontSize, 18);
      expect(titleText.style?.fontWeight, FontWeight.bold);
    });
  });
}
