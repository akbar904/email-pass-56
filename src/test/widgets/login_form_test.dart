
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/widgets/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('renders email and password TextFields, and login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LoginForm(),
						),
					),
				),
			);

			// Verify the presence of email TextField
			expect(find.byKey(Key('emailTextField')), findsOneWidget);

			// Verify the presence of password TextField
			expect(find.byKey(Key('passwordTextField')), findsOneWidget);

			// Verify the presence of login button
			expect(find.byKey(Key('loginButton')), findsOneWidget);
		});

		testWidgets('tapping login button triggers login event in AuthCubit', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LoginForm(),
						),
					),
				),
			);

			// Enter email and password
			await tester.enterText(find.byKey(Key('emailTextField')), 'zharfan@walturn.com');
			await tester.enterText(find.byKey(Key('passwordTextField')), 'abc123');

			// Tap login button
			await tester.tap(find.byKey(Key('loginButton')));
			await tester.pump();

			// Verify login method in AuthCubit is called
			verify(() => mockAuthCubit.login('zharfan@walturn.com', 'abc123')).called(1);
		});
	});
}
