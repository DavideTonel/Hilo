class User {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String? profileImagePath;
  final String birthday;

  User({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.profileImagePath,
    required this.birthday
  });

  User copyWith({
    final String? newUsername,
    final String? newPassword,
    final String? newFirstName,
    final String? newLastName,
    final String? newProfileImagePath,
  }) {
    return User(
      username: newUsername ?? username,
      password: newPassword ?? password,
      firstName: newFirstName ?? firstName,
      lastName: newLastName ?? lastName,
      profileImagePath: newProfileImagePath ?? profileImagePath,
      birthday: birthday
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "referenceProfileImage": profileImagePath,
      "birthday": birthday
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map["username"] as String,
      password: map["password"] as String,
      firstName: map["firstName"] as String,
      lastName: map["lastName"] as String,
      profileImagePath: map["referenceProfileImage"] as String?,
      birthday: map["birthday"] as String
    );
  }
}
