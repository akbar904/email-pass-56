
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/screens/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display the login form with email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		testWidgets('should display error message when login fails', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthState.error('Login failed')]),
				initialState: AuthState.initial(),
			);

			await tester.pumpWidget(MaterialApp(
				home: BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: LoginScreen(),
				),
			));

			await tester.pump(); // Rebuilds the widget

			expect(find.text('Login failed'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		blocTest<AuthCubit, AuthState>(
			'should emit [AuthLoading, AuthAuthenticated] when login is successful',
			build: () => AuthCubit(),
			act: (cubit) => cubit.login('zharfan@walturn.com', 'abc123'),
			expect: () => [
				AuthState.loading(),
				AuthState.authenticated(),
			],
		);

		blocTest<AuthCubit, AuthState>(
			'should emit [AuthLoading, AuthError] when login is unsuccessful',
			build: () => AuthCubit(),
			act: (cubit) => cubit.login('wrongemail@walturn.com', 'wrongpassword'),
			expect: () => [
				AuthState.loading(),
				AuthState.error('Invalid email or password'),
			],
		);
	});
}
