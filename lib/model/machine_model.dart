class Machine {
  final int id;
  final String name;
  final int price;
  final int coinsPerHour;
  final int requiredInvites;

  Machine({
    required this.id,
    required this.name,
    required this.price,
    required this.coinsPerHour,
    required this.requiredInvites,
  });

  // Factory constructor to create a Machine instance from JSON
  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      coinsPerHour: json['coins_per_hour'],
      requiredInvites: json['required_invites'],
    );
  }

  // Method to convert a Machine instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'coins_per_hour': coinsPerHour,
    };
  }
}
