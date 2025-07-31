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

  @override
  void initState() {
    super.initState();
    _lookup();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('LatLng → PlaceInfo Example')),
        body: Center(
          child: error != null
              ? Text('Error: $error')
              : place == null
                  ? const CircularProgressIndicator()
                  : Text(
                      '📍 ${place!.formattedAddress}\n\n'
                      'City: ${place!.city}\n'
                      'State: ${place!.state}\n'
                      'Country: ${place!.country}',
                      textAlign: TextAlign.center,
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _lookup,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
