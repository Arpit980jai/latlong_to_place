import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/place_info.dart';

class GeocodingService {
  /// 1️⃣ Get current device position (asks permission if needed)
  Future<Position> getCurrentPosition() async {
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    if (perm == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  /// 2️⃣ Reverse-geocode any lat/lng into our PlaceInfo
  Future<PlaceInfo> getPlaceInfo(double lat, double lng) async {
    final placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isEmpty) {
      throw Exception('No address found for ($lat, $lng)');
    }
    final p = placemarks.first;
    final formatted = [
      p.name,
      p.street,
      p.subLocality,
      p.locality,
      p.administrativeArea,
      p.postalCode,
      p.country
    ].where((s) => s != null && s.isNotEmpty).join(', ');

    return PlaceInfo(
      formattedAddress: formatted,
      street: p.street ?? '',
      locality: p.subLocality ?? '',
      city: p.locality ?? '',
      state: p.administrativeArea ?? '',
      country: p.country ?? '',
      postalCode: p.postalCode ?? '',
      latitude: lat,
      longitude: lng,
    );
  }

  /// 3️⃣ Convenience: get current position + reverse-geocode in one go
  Future<PlaceInfo> getCurrentPlaceInfo() async {
    final pos = await getCurrentPosition();
    return getPlaceInfo(pos.latitude, pos.longitude);
  }
}