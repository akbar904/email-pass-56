
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_project_name/cubits/auth_cubit.dart';

// Mock dependencies if there are any
class MockUserModel extends Mock implements UserModel {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthAuthenticated] when login is called with correct credentials',
			build: () => authCubit,
			act: (cubit) => cubit.login('zharfan@walturn.com', 'abc123'),
			expect: () => [isA<AuthLoading>(), isA<AuthAuthenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthUnauthenticated] when login is called with incorrect credentials',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [isA<AuthLoading>(), isA<AuthUnauthenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthUnauthenticated] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [isA<AuthLoading>(), isA<AuthUnauthenticated>()],
		);
	});
}
