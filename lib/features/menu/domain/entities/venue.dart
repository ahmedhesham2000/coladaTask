import 'working_hours.dart';

class VenueEntity {
  final String id;
  final String name;
  final String nameAr;
  final String logo;
  final String coverPhoto;
  final double rating;
  final int reviewCount;
  final String address;
  final String addressEn;
  final double distanceKm;
  final bool isOpen;
  final WorkingHours workingHours;
  final String cuisine;
  final String cuisineEn;

  const VenueEntity({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.logo,
    required this.coverPhoto,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.addressEn,
    required this.distanceKm,
    required this.isOpen,
    required this.workingHours,
    required this.cuisine,
    required this.cuisineEn,
  });
}
