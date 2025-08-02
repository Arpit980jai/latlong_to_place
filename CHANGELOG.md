
---

### ✅ `CHANGELOG.md` (Updated)

```markdown
# Changelog

All notable changes to this project will be documented in this file.
## [0.0.5] – 2025-08-02
### Added
- 📚 Added Dart documentation for public APIs including `DistanceService`, `distancesBetweenPoints`, and `totalDistance` to meet pub.dev score guidelines.
- 🧭 Documented `latlong_to_place` library declaration.
- ✅ Enabled compatibility with `public_member_api_docs` lint rule.

## [0.0.4] – 2025-08-02
### Added
- 🚀 Added `DistanceService` class for calculating distance between multiple LatLng points.
- ✅ Supports output in kilometers, meters, or miles.
- 🖼️ Included new banner image for showcasing this features.

## [0.0.3] – 2025-07-31
- Updated the license file

## [0.0.2] – 2025-07-31
- Fixed images of Readme file

## [0.0.1] – 2025-07-31
### Added
- Initial release of `latlong_to_place`.
- 🗺️ `getCurrentPlaceInfo()` – handles permission request, fetches GPS coordinates, and reverse-geocodes to `PlaceInfo`.
- 🔄 `getPlaceInfo(lat, lng)` – reverse-geocodes arbitrary coordinates.
- Defined `PlaceInfo` model with formatted address, street, locality, city, state, country, postal code, latitude, and longitude.
- Documentation updated with installation, permission setup, and usage examples.
