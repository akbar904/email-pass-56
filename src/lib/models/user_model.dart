
class UserModel {
	final String email;
	final String password;

	UserModel({required this.email, required this.password});

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'password': password,
		};
	}

	factory UserModel.fromJson(Map<String, dynamic> json) {
		return UserModel(
			email: json['email'] as String,
			password: json['password'] as String,
		);
	}
}
