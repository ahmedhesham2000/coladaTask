import 'package:coladatask/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/catalog.dart';
import '../entities/venue.dart';

abstract class MenuRepository {
  Future<Either<Failure, VenueEntity>> getVenue(String venueId);
  Future<Either<Failure, CatalogEntity>> getCatalog(String venueId);
}
