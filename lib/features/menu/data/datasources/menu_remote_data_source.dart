import 'package:coladatask/core/errors/failures.dart';
import 'package:coladatask/features/menu/domain/entities/catalog.dart';
import 'package:coladatask/features/menu/domain/entities/venue.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/endpoints.dart';
import '../models/catalog_model.dart';
import '../models/venue_model.dart';

abstract class MenuRemoteDataSource {
  Future<Either<Failure, VenueEntity>> getVenue(String venueId);
  Future<Either<Failure, CatalogEntity>> getCatalog(String venueId);
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  MenuRemoteDataSourceImpl(this._dioHelper);

  final NetworkService _dioHelper;

  @override
  Future<Either<Failure, VenueEntity>> getVenue(String venueId) async {
    try {
      final response = await _dioHelper.unAuthedDio.get(
        '${EndPoints.venue}/$venueId',
      );
      return Right(VenueModel.fromResponse(response.data!));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, CatalogEntity>> getCatalog(String venueId) async {
    try {
      final response = await _dioHelper.unAuthedDio.get(
        EndPoints.catalog(venueId),
      );
      return Right(CatalogModel.fromResponse(response.data!));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  ServerFailure _handleError(Object e) {
    if (e is DioException && e.response?.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;
      final statusCode = data['status'] as int?;
      final errors = data['errors'] as List?;
      final message = data['message'] as String? ?? 'Unknown error';

      if (errors != null && errors.isNotEmpty) {
        final errorNames = errors
            .map((err) => err is Map ? err['name'] ?? '' : err.toString())
            .where((name) => name.toString().isNotEmpty)
            .join(', ');
        if (errorNames.isNotEmpty) {
          return ServerFailure(errorNames, statusCode: statusCode);
        }
      }
      return ServerFailure(message, statusCode: statusCode);
    }
    return ServerFailure(e.toString());
  }
}
