
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
	const LogoutButton({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ElevatedButton(
			onPressed: () {
				context.read<AuthCubit>().logout();
			},
			child: const Text('Logout'),
		);
	}
}
