class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
  });

  factory User.fromJson(json) {
    return User(
      id: int.parse(json['id']),
      name: json['name'] ?? json['email'],
      email: json['email'],
      phone: json['phone'] ?? '-',
      address: json['address'],
    );
  }
}
