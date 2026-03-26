import 'package:coladatask/config/usecases/usecases.dart';
import 'package:coladatask/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/venue.dart';
import '../repositories/menu_repository.dart';

class GetVenueUseCase extends UseCase<VenueEntity, String> {
  GetVenueUseCase(this._repository);

  final MenuRepository _repository;

  @override
  Future<Either<Failure, VenueEntity>> call(String venueId) async {
    return await _repository.getVenue(venueId);
  }
}
