class Plan {
  const Plan({
    required this.id,
    required this.name,
    required this.price,
    required this.durationDays,
    this.features = const [],
  });

  final String id;
  final String name;
  final double price;
  final int durationDays;
  final List<String> features;

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      durationDays: map['durationDays'] as int? ?? 0,
      features: map['features'] != null
          ? List<String>.from(map['features'] as List)
          : [],
    );
  }
}
