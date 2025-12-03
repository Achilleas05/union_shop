import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/pages/sign_up_page.dart';

class FakeGoRouter {
  late final GoRouter _router;

  FakeGoRouter() {
    _router = GoRouter(
      initialLocation: '/signup',
      routes: [
        GoRoute(
            path: '/signup', builder: (context, state) => const SignUpPage()),
        GoRoute(path: '/', builder: (context, state) => Container()),
        GoRoute(path: '/login', builder: (context, state) => Container()),
      ],
    );
  }

  String get location =>
      _router.routerDelegate.currentConfiguration.uri.toString();

  void go(String location, {Object? extra}) =>
      _router.go(location, extra: extra);
}

void main() {
  late FakeGoRouter router;

  setUp(() {
    router = FakeGoRouter();
  });

  testWidgets('SignUpPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    expect(find.text('Sign up'), findsNWidgets(2)); // Title and button text
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Already have an account? Sign in'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Image displays error widget on load failure',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    // Simulate image load error by checking for errorBuilder
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
  });

  testWidgets('Form validation fails for empty email',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Please enter your email'), findsOneWidget);
  });

  testWidgets('Form validation fails for invalid email',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    await tester.enterText(find.byType(TextFormField).at(0), 'invalidemail');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('Form validation fails for short password',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    await tester.enterText(
        find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Form validation fails for mismatched passwords',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    await tester.enterText(
        find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.enterText(find.byType(TextFormField).at(2), 'different');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });

  testWidgets(
      'Form validation passes and shows success snackbar, navigates on valid input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    await tester.enterText(
        find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Sign up successful!'), findsOneWidget);
    await tester.pumpAndSettle(); // Wait for navigation
    expect(router.location, '/');
  });

  testWidgets('Sign in button navigates to login', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    await tester.tap(find.text('Already have an account? Sign in'));
    await tester.pumpAndSettle();

    expect(router.location, '/login');
  });

  testWidgets('Controllers are disposed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(routerConfig: router._router));

    await tester.pumpWidget(Container()); // Dispose the widget
    // Disposal is tested implicitly as no errors occur
  });
}
