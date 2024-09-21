class User {
  final int id;
  final int coins; 
  final DateTime dateJoined;
  final String email;
  final String username;
  final String? inviteId;
  final int successfulInvites;
  final String pic;
  final String referralCode;
  final int energy;
  final DateTime lastEnergyRefill;

  // Empty constructor with default values
  User({
    this.id = 0,
    this.coins = 0,
    DateTime? dateJoined,
    this.email = '',
    this.username = '',
    this.inviteId,
    this.successfulInvites = 0,
    this.pic = '',
    this.referralCode = '',
    this.energy = 0,
    DateTime? lastEnergyRefill,
  })  : dateJoined = dateJoined ?? DateTime.now(),
        lastEnergyRefill = lastEnergyRefill ?? DateTime.now();

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      coins: json['coins'] ?? 0,
      dateJoined: json['date_joined'] != null
          ? DateTime.parse(json['date_joined'])
          : DateTime.now(),
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      inviteId: json['invite_id'],
      successfulInvites: json['successful_invites'] ?? 0,
      pic: json['pic'] ?? '',
      referralCode: json['referral_code'] ?? '',
      energy: json['energy'] ?? 0,
      lastEnergyRefill: json['last_energy_refill'] != null
          ? DateTime.parse(json['last_energy_refill'])
          : DateTime.now(),
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
      'successful_invites': successfulInvites,
      'pic': pic,
      'referral_code': referralCode,
      'energy': energy,
      'last_energy_refill': lastEnergyRefill.toIso8601String(),
    };
  }
}
