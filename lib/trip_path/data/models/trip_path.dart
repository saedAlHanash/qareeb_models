
import '../../../points/data/model/trip_point.dart';

class TripPath {
  TripPath({
    required this.id,
    required this.name,
    required this.arName,
    required this.edges,
    required this.distance,
    required this.duration,
  });

  final int id;
  final String name;
  final String arName;
  final num distance;
  final num duration;

  final List<Edge> edges;

  factory TripPath.fromJson(Map<String, dynamic> json) {
    return TripPath(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
      distance: json["distance"] ?? 0,
      duration: json["duration"] ?? 0,
      edges: json["edges"] == null
          ? []
          : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arName": arName,
        "distance": distance,
        "duration": duration,
        "edges": edges.map((x) => x.toJson()).toList(),
      };
}

class Edge {
  Edge({
    required this.id,
    required this.startPoint,
    required this.startPointId,
    required this.endPoint,
    required this.endPointId,
    required this.distance,
    required this.price,
    required this.steps,
    required this.name,
    required this.arName,
  });

  final int id;
  final TripPoint startPoint;
  final int startPointId;
  final TripPoint endPoint;
  final int endPointId;
  final num distance;
  final num price;
  final String steps;
  final String name;
  final String arName;

  factory Edge.fromJson(Map<String, dynamic> json) {
    return Edge(
      id: json["id"] ?? 0,
      startPoint: TripPoint.fromJson(json["startPoint"] ?? {}),
      startPointId: json["startPointId"] ?? 0,
      endPoint: TripPoint.fromJson(json["endPoint"] ?? {}),
      endPointId: json["endPointId"] ?? 0,
      distance: json["distance"] ?? 0,
      price: json["price"] ?? 0,
      steps: json["steps"] ?? "",
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "startPoint": startPoint.toJson(),
        "startPointId": startPointId,
        "endPoint": endPoint.toJson(),
        "endPointId": endPointId,
        "distance": distance,
        "price": price,
        "steps": steps,
        "name": name,
        "arName": arName,
      };
}
