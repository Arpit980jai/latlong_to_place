import 'package:flutter/material.dart';
import 'package:latlong_to_place/latlong_to_place.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final service = GeocodingService();
  PlaceInfo? place;
  String? error;

  final points = [
    LatLng(28.6139, 77.2090), // Delhi
    LatLng(27.1767, 78.0081), // Agra
    LatLng(26.9124, 75.7873), // Jaipur
  ];

  List<double>? distances;
  double? total;

  @override
  void initState() {
    super.initState();
    _lookup();
    _calculateDistances();
  }

  Future<void> _lookup() async {
    try {
      final info = await service.getCurrentPlaceInfo();
      setState(() {
        place = info;
        error = null;
      });
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  void _calculateDistances() {
    final result = DistanceService.distancesBetweenPoints(points, unit: DistanceUnit.kilometers);
    final sum = DistanceService.totalDistance(points, unit: DistanceUnit.kilometers);

    setState(() {
      distances = result;
      total = sum;
    });

    print("Distances: $result");
    print("Total Distance: $sum km");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('LatLng → PlaceInfo & Distance')),
        body: Center(
          child: error != null
              ? Text('Error: $error')
              : place == null
              ? const CircularProgressIndicator()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '📍 ${place!.formattedAddress}\n\n'
                    'City: ${place!.city}\n'
                    'State: ${place!.state}\n'
                    'Country: ${place!.country}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              if (distances != null && total != null) ...[
                Text(
                  '📏 Distances Between Points:\n${distances!.map((d) => "${d.toStringAsFixed(2)} km").join('\n')}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text('🧮 Total Distance: ${total!.toStringAsFixed(2)} km'),
              ]
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _lookup();
            _calculateDistances();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
