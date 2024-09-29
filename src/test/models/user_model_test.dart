
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_cubit_app/models/user_model.dart';

void main() {
	group('UserModel', () {
		test('should correctly instantiate with given email and password', () {
			final user = UserModel(email: 'test@example.com', password: 'test123');

			expect(user.email, 'test@example.com');
			expect(user.password, 'test123');
		});

		test('should correctly serialize to JSON', () {
			final user = UserModel(email: 'test@example.com', password: 'test123');
			final json = user.toJson();

			expect(json, {'email': 'test@example.com', 'password': 'test123'});
		});

		test('should correctly deserialize from JSON', () {
			final json = {'email': 'test@example.com', 'password': 'test123'};
			final user = UserModel.fromJson(json);

			expect(user.email, 'test@example.com');
			expect(user.password, 'test123');
		});
	});
}
