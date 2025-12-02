import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/pages/about_page.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('AboutPage', () {
    testWidgets('renders all expected elements', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      expect(find.byType(AboutPage), findsOneWidget);
      expect(find.byType(CustomHeader), findsOneWidget);
      expect(find.byType(Footer), findsOneWidget);
      expect(find.text('About us'), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.textContaining('Welcome to the Union Shop!'), findsOneWidget);
    });

    testWidgets('has correct scaffold background', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);
      final scaffold = tester.widget<Scaffold>(scaffoldFinder);
      expect(scaffold.backgroundColor, Colors.white);
    });

    testWidgets('title uses correct style properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final titleFinder = find.text('About us');
      expect(titleFinder, findsOneWidget);
      final titleText = tester.widget<Text>(titleFinder);
      expect(titleText.style?.fontSize, 28);
      expect(titleText.style?.fontWeight, FontWeight.bold);
      expect(titleText.style?.color, Colors.black);
    });

    testWidgets('content container exists', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final containers = find.byType(Container).evaluate();
      bool foundContentContainer = false;

      for (final element in containers) {
        final container = element.widget as Container;
        if (container.child is Column) {
          final column = container.child as Column;
          if (column.children.any((child) =>
              child is Text &&
              (child).data?.contains('Welcome to the Union Shop!') == true)) {
            foundContentContainer = true;
            break;
          }
        }
      }

      expect(foundContentContainer, isTrue);
    });

    testWidgets('content has correct text styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final textFinder = find.textContaining('Welcome to the Union Shop!');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.color, Colors.black87);
      expect(textWidget.style?.height, 1.6);
      expect(textWidget.textAlign, TextAlign.left);
    });

    testWidgets('displays all content text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      expect(find.textContaining('Welcome to the Union Shop!'), findsOneWidget);
      expect(
          find.textContaining('University branded products'), findsOneWidget);
      expect(find.textContaining('personalisation service'), findsOneWidget);
      expect(find.textContaining('Happy shopping!'), findsOneWidget);
      expect(find.textContaining('The Union Shop & Reception Team'),
          findsOneWidget);
      expect(find.textContaining('hello@upsu.net'), findsOneWidget);
    });

    testWidgets('title container has correct padding',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final titleFinder = find.text('About us');
      final containerFinder = find
          .ancestor(
            of: titleFinder,
            matching: find.byType(Container),
          )
          .first;

      final container = tester.widget<Container>(containerFinder);
      expect(container.padding, const EdgeInsets.only(top: 40, bottom: 20));
    });

    testWidgets('content container has correct padding',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final textFinder = find.textContaining('Welcome to the Union Shop!');
      final containerAncestor = find.ancestor(
        of: textFinder,
        matching: find.byType(Container),
      );

      // Get the first (and only) container that wraps the content
      final containerFinder = containerAncestor.first;
      final container = tester.widget<Container>(containerFinder);
      expect(container.padding, const EdgeInsets.symmetric(horizontal: 24));
    });

    testWidgets('has SizedBox widgets for spacing',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      expect(find.byType(SizedBox), findsAtLeast(2));

      final sizedBoxes = find.byType(SizedBox).evaluate();
      bool foundSpacingBox = false;
      for (final element in sizedBoxes) {
        final sizedBox = element.widget as SizedBox;
        if (sizedBox.height == 16 || sizedBox.height == 40) {
          foundSpacingBox = true;
          break;
        }
      }
      expect(foundSpacingBox, isTrue);
    });

    testWidgets('column has correct cross axis alignment',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final scrollViewFinder = find.byType(SingleChildScrollView);
      final columnFinder = find
          .descendant(
            of: scrollViewFinder,
            matching: find.byType(Column),
          )
          .first;

      final column = tester.widget<Column>(columnFinder);
      expect(column.crossAxisAlignment, CrossAxisAlignment.center);
    });

    testWidgets('content column has correct cross axis alignment',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final textFinder = find.textContaining('Welcome to the Union Shop!');
      final columnAncestor = find
          .ancestor(
            of: textFinder,
            matching: find.byType(Column),
          )
          .first;

      final column = tester.widget<Column>(columnAncestor);
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('footer is present', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      expect(find.byType(Footer), findsOneWidget);
    });

    testWidgets('can be created with a key', (WidgetTester tester) async {
      const key = Key('about_page_key');

      await tester.pumpWidget(createTestWidget(const AboutPage(key: key)));

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('title has correct text alignment',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final titleFinder = find.text('About us');
      final titleText = tester.widget<Text>(titleFinder);
      expect(titleText.textAlign, TextAlign.center);
    });

    testWidgets('main container has width constraint',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      await tester.pumpAndSettle();

      final textFinder = find.textContaining('Welcome to the Union Shop!');
      final containerFinder = find
          .ancestor(
            of: textFinder,
            matching: find.byType(Container),
          )
          .first;

      // Verify the container has width constraint of 900
      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints, isNotNull);
      expect(container.constraints!.maxWidth, 900);
      expect(container.constraints!.minWidth, 900);

      // The rendered size might be smaller due to test viewport constraints
      final containerSize = tester.getSize(containerFinder);
      expect(containerSize.width, lessThanOrEqualTo(900));
      expect(containerSize.width, greaterThan(0));
    });

    testWidgets('scaffold body is SingleChildScrollView',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final scaffoldFinder = find.byType(Scaffold);
      final scaffold = tester.widget<Scaffold>(scaffoldFinder);
      expect(scaffold.body, isA<SingleChildScrollView>());
    });

    testWidgets('main column has correct children structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const AboutPage()));

      final scrollViewFinder = find.byType(SingleChildScrollView);
      final columnFinder = find
          .descendant(
            of: scrollViewFinder,
            matching: find.byType(Column),
          )
          .first;

      final column = tester.widget<Column>(columnFinder);
      expect(column.children.length, 4);
      expect(column.children[0], isA<CustomHeader>());
      expect(column.children[1], isA<Container>());
      expect(column.children[2], isA<Container>());
      expect(column.children[3], isA<Footer>());
    });
  });
}
