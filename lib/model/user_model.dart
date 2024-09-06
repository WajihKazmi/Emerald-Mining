class User {
  final int id;
  final int coins; 
  final DateTime dateJoined;
  final String email;
  final String username;
  final String? inviteId;

  User({
    required this.id,
    required this.coins,
    required this.dateJoined,
    required this.email,
    required this.username,
    this.inviteId,
  });

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      coins: json['coins'],
      dateJoined: DateTime.parse(json['date_joined']),
      email: json['email'],
      username: json['username'],
      inviteId: json['invite_id'], 
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coins': coins,
      'date_joined': dateJoined.toIso8601String(),
      'email': email,
      'username': username,
      'invite_id': inviteId,
    };
  }
}
