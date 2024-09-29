
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

// AuthState classes
abstract class AuthState extends Equatable {
	const AuthState();

	@override
	List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
	final UserModel user;

	const AuthAuthenticated(this.user);

	@override
	List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

// AuthCubit class
class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) {
		emit(AuthLoading());

		// Simulating a network call
		Future.delayed(const Duration(seconds: 1), () {
			if (email == 'zharfan@walturn.com' && password == 'abc123') {
				final user = UserModel(email: email, password: password);
				emit(AuthAuthenticated(user));
			} else {
				emit(AuthUnauthenticated());
			}
		});
	}

	void logout() {
		emit(AuthLoading());

		// Simulating a network call
		Future.delayed(const Duration(seconds: 1), () {
			emit(AuthUnauthenticated());
		});
	}
}
