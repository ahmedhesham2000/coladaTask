import 'package:coladatask/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/catalog.dart';
import '../../domain/entities/venue.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_remote_data_source.dart';

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl(this._remoteDataSource);

  final MenuRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, VenueEntity>> getVenue(String venueId) {
    return _remoteDataSource.getVenue(venueId);
  }

  @override
  Future<Either<Failure, CatalogEntity>> getCatalog(String venueId) {
    return _remoteDataSource.getCatalog(venueId);
  }
}
