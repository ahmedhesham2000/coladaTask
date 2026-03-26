import 'package:coladatask/config/usecases/usecases.dart';
import 'package:coladatask/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/catalog.dart';
import '../repositories/menu_repository.dart';

class GetCatalogUseCase extends UseCase<CatalogEntity, String> {
  GetCatalogUseCase(this._repository);

  final MenuRepository _repository;

  @override
  Future<Either<Failure, CatalogEntity>> call(String venueId) async {
    return await _repository.getCatalog(venueId);
  }
}
