import 'dart:math';
import '../models/latlng.dart';
import '../models/distance_unit.dart';

/// Provides utilities to calculate distances between geographic coordinates
/// (latitude/longitude points) using the Haversine formula.
class DistanceService {
  /// Returns a list of distances between each pair of consecutive points in the provided list.
  ///
  /// The `unit` parameter defines whether the result is returned in kilometers, meters, or miles.
  static List<double> distancesBetweenPoints(
      List<LatLng> points, {
        DistanceUnit unit = DistanceUnit.kilometers,
      }) {
    List<double> distances = [];
    for (int i = 0; i < points.length - 1; i++) {
      distances.add(_haversineDistance(points[i], points[i + 1], unit));
    }
    return distances;
  }

  /// Returns the total distance across all points in the list.
  ///
  /// If the list contains fewer than 2 points, the total distance is 0.
  /// The result is returned in the specified unit.
  static double totalDistance(
      List<LatLng> points, {
        DistanceUnit unit = DistanceUnit.kilometers,
      }) {
    return distancesBetweenPoints(points, unit: unit).fold(0.0, (a, b) => a + b);
  }

  static double _toRadians(double degree) => degree * pi / 180;

  static double _haversineDistance(LatLng p1, LatLng p2, DistanceUnit unit) {
    const double R = 6371.0; // Radius of Earth in kilometers
    double dLat = _toRadians(p2.latitude - p1.latitude);
    double dLon = _toRadians(p2.longitude - p1.longitude);

    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(p1.latitude)) *
            cos(_toRadians(p2.latitude)) *
            pow(sin(dLon / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distanceKm = R * c;

    switch (unit) {
      case DistanceUnit.kilometers:
        return distanceKm;
      case DistanceUnit.meters:
        return distanceKm * 1000;
      case DistanceUnit.miles:
        return distanceKm * 0.621371;
    }
  }
}
