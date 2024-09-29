
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'cubits/auth_cubit.dart';

void main() {
	runApp(MainApp());
}

class MainApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (_) => AuthCubit(),
			child: MaterialApp(
				title: 'Simple Cubit App',
				home: BlocBuilder<AuthCubit, AuthState>(
					builder: (context, state) {
						if (state is AuthAuthenticated) {
							return HomeScreen();
						} else {
							return LoginScreen();
						}
					},
				),
			),
		);
	}
}
