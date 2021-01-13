class User {
  String email;
  String name;
  String password;

  User({this.email, this.name, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'], name: json['name'], password: json['password']);
  }

  Map<String, dynamic> toJson() =>
      {'email': email, 'name': name, 'password': password};
}
