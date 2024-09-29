
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';
import 'package:simple_cubit_app/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocConsumer<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is AuthError) {
						final snackBar = SnackBar(content: Text(state.message));
						ScaffoldMessenger.of(context).showSnackBar(snackBar);
					} else if (state is AuthAuthenticated) {
						Navigator.pushReplacementNamed(context, '/home');
					}
				},
				builder: (context, state) {
					if (state is AuthLoading) {
						return Center(child: CircularProgressIndicator());
					}
					return Padding(
						padding: const EdgeInsets.all(16.0),
						child: LoginForm(),
					);
				},
			),
		);
	}
}
