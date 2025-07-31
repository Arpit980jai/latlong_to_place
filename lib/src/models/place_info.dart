class PlaceInfo {
  final String formattedAddress;
  final String street;
  final String locality;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final double latitude;
  final double longitude;

  PlaceInfo({
    required this.formattedAddress,
    required this.street,
    required this.locality,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
  });
}
