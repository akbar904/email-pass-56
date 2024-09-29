
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class LoginForm extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final emailController = TextEditingController();
		final passwordController = TextEditingController();

		return Column(
			children: [
				TextField(
					key: Key('emailTextField'),
					controller: emailController,
					decoration: InputDecoration(
						labelText: 'Email',
					),
				),
				TextField(
					key: Key('passwordTextField'),
					controller: passwordController,
					obscureText: true,
					decoration: InputDecoration(
						labelText: 'Password',
					),
				),
				ElevatedButton(
					key: Key('loginButton'),
					onPressed: () {
						final email = emailController.text;
						final password = passwordController.text;
						BlocProvider.of<AuthCubit>(context).login(email, password);
					},
					child: Text('Login'),
				),
			],
		);
	}
}
