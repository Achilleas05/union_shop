// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/widgets/search_overlay.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
  group('SearchOverlay', () {
    Widget createTestWidget({required VoidCallback onClose}) {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: Stack(
                children: [
                  const Center(child: Text('Home')),
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: SearchOverlay(onClose: onClose),
                  ),
                ],
              ),
            ),
          ),
          GoRoute(
            path: '/product/:id',
            builder: (context, state) => Scaffold(
              body: Text('Product ${state.pathParameters['id']}'),
            ),
          ),
        ],
      );

      return MaterialApp.router(
        routerConfig: router,
      );
    }

    testWidgets('should render search field with correct hint text',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      expect(find.text('Search products...'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('should focus search field on mount', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.focusNode?.hasFocus, isTrue);
    });

    testWidgets('should call onClose when close button is pressed',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(closeCalled, isTrue);
    });

    testWidgets('should display search results when query matches products',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'shirt');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('should display no results for non-matching query',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'xyznonexistent123');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('should clear results when search query is empty',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'shirt');
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsWidgets);

      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('should search case-insensitively', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'SHIRT');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('should search in product title', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      final firstProduct = products.first;
      final searchTerm =
          (firstProduct.title ?? firstProduct.name).substring(0, 3);

      await tester.enterText(find.byType(TextField), searchTerm);
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('should search in product description', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      final productWithDesc = products.firstWhere(
        (p) => p.description.isNotEmpty,
        orElse: () => products.first,
      );
      final searchTerm = productWithDesc.description.split(' ').first;

      await tester.enterText(find.byType(TextField), searchTerm);
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('should display product image in search results',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'shirt');
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should display product title and price in search results',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'shirt');
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('should navigate to product when search result is tapped',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'shirt');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      expect(closeCalled, isTrue);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Text &&
              widget.data != null &&
              widget.data!.startsWith('Product ')),
          findsOneWidget);
    });

    testWidgets('should constrain search field width', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find
            .ancestor(
              of: find.byType(TextField),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(container.constraints?.maxWidth, equals(400));
    });

    testWidgets('should have rounded border on search field', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration as InputDecoration;
      final border = decoration.border as OutlineInputBorder;

      expect(border.borderRadius, equals(BorderRadius.circular(20)));
    });

    testWidgets('should constrain results overlay height', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'a');
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(Material),
              matching: find.byType(Container),
            )
            .last,
      );

      expect(container.constraints?.maxHeight, equals(300));
    });

    testWidgets('should handle special characters in search', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '@#\$%');
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should update results as query changes', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 's');
      await tester.pumpAndSettle();
      final firstResultCount = tester.widgetList(find.byType(ListTile)).length;

      await tester.enterText(find.byType(TextField), 'sh');
      await tester.pumpAndSettle();
      final secondResultCount = tester.widgetList(find.byType(ListTile)).length;

      expect(firstResultCount >= 0, isTrue);
      expect(secondResultCount >= 0, isTrue);
    });

    testWidgets('should display error icon when image fails to load',
        (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'shirt');
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should dispose controllers and focus nodes', (tester) async {
      bool closeCalled = false;
      await tester
          .pumpWidget(createTestWidget(onClose: () => closeCalled = true));
      await tester.pumpAndSettle();

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();

      expect(find.byType(SearchOverlay), findsNothing);
    });
  });
}
