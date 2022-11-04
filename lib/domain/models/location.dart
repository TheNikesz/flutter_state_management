class Location {
  String name;
  double latitude;
  double longitude;
  
  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  factory Location.fromJson(Map<String, dynamic> source) => Location.fromMap(source);
}
