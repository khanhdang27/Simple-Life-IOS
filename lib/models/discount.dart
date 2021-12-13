class Discount {
  final int id;
  final String name;

  Discount({required this.id, required this.name});

  factory Discount.fromJson(Map json) {
    return Discount(
      id: int.parse(json['id']),
      name: json['name'],
    );
  }
}
