import 'package:emerald_mining/model/machine_model.dart';


class UserMachine {
  final int id;
  final int userId;
  final Machine machine;
  final DateTime purchasedAt;
  final DateTime lastCollectedAt;

  UserMachine({
    required this.id,
    required this.userId,
    required this.machine,
    required this.purchasedAt,
    required this.lastCollectedAt,
  });

  // Factory method to create a UserMachine from JSON
  factory UserMachine.fromJson(Map<String, dynamic> json) {
    return UserMachine(
      id: json['id'],
      userId: json['user'],
      machine: Machine.fromJson(json['machine']),
      purchasedAt: DateTime.parse(json['purchased_at']),
      lastCollectedAt: DateTime.parse(json['last_collected_at']),
    );
  }

  // Method to convert UserMachine to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'machine': machine.toJson(),
      'purchased_at': purchasedAt.toIso8601String(),
      'last_collected_at': lastCollectedAt.toIso8601String(),
    };
  }
}
