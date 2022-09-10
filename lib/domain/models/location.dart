import 'dart:convert';

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

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source));
}

class AllLocations {
  List<Location> locations;
  AllLocations({
    required this.locations,
  });

  factory AllLocations.fromMap(Map<String, dynamic> map) {
    return AllLocations(
      locations: List<Location>.from(map['results']?.map((x) => Location.fromMap(x))),
    );
  }

  factory AllLocations.fromJson(Map<String, dynamic> source) => AllLocations.fromMap(source);
}
