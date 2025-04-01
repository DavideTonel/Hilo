class User {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  //final DateTime birthday;

  User(
    {
      required this.username,
      required this.password,
      required this.firstName,
      required this.lastName,
      //required this.birthday
    }
  );

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      password: map['password'] as String,
      firstName: map['firstName'] as String,
      lastName:  map['lastName'] as String,
    );
  }
}