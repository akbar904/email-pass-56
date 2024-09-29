
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/main.dart';

// Mock for AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MainApp', () {
		testWidgets('displays LoginScreen when not authenticated', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(AuthUnauthenticated());

			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: mockAuthCubit,
					child: MainApp(),
				),
			);

			expect(find.text('Login'), findsOneWidget);
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('displays HomeScreen when authenticated', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(AuthAuthenticated());

			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: mockAuthCubit,
					child: MainApp(),
				),
			);

			expect(find.text('Home'), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});
	});
}
