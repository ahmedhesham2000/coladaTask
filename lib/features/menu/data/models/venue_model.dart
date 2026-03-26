import '../../domain/entities/venue.dart';
import 'working_hours_model.dart';

class VenueModel extends VenueEntity {
  const VenueModel({
    required super.id,
    required super.name,
    required super.nameAr,
    required super.logo,
    required super.coverPhoto,
    required super.rating,
    required super.reviewCount,
    required super.address,
    required super.addressEn,
    required super.distanceKm,
    required super.isOpen,
    required super.workingHours,
    required super.cuisine,
    required super.cuisineEn,
  });

  /// Parses the full API response:
  /// { "dataResponse": { "venue": { ... } } }
  factory VenueModel.fromResponse(Map<String, dynamic> response) {
    final venueJson =
        (response['dataResponse'] as Map<String, dynamic>)['venue']
            as Map<String, dynamic>;
    return VenueModel.fromJson(venueJson);
  }

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      logo: json['logo'] as String,
      coverPhoto: json['coverPhoto'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      address: json['address'] as String,
      addressEn: json['addressEn'] as String,
      distanceKm: (json['distanceKm'] as num).toDouble(),
      isOpen: json['isOpen'] as bool,
      workingHours: WorkingHoursModel.fromJson(
        json['workingHours'] as Map<String, dynamic>,
      ),
      cuisine: json['cuisine'] as String,
      cuisineEn: json['cuisineEn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'logo': logo,
      'coverPhoto': coverPhoto,
      'rating': rating,
      'reviewCount': reviewCount,
      'address': address,
      'addressEn': addressEn,
      'distanceKm': distanceKm,
      'isOpen': isOpen,
      'workingHours': (workingHours as WorkingHoursModel).toJson(),
      'cuisine': cuisine,
      'cuisineEn': cuisineEn,
    };
  }
}
