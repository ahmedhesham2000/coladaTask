import 'dart:developer';

import 'package:coladatask/config/dependency_injection/dependency_injection.dart';
import 'package:coladatask/core/state/base_state.dart';
import 'package:coladatask/features/menu/domain/entities/catalog.dart';
import 'package:coladatask/features/menu/domain/entities/venue.dart';
import 'package:coladatask/features/menu/domain/usecases/get_catalog_usecase.dart';
import 'package:coladatask/features/menu/domain/usecases/get_venue_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_provider.g.dart';

// ── Venue ──────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class Venue extends _$Venue {
  @override
  BaseState<VenueEntity> build() {
    return const BaseState<VenueEntity>();
  }

  Future<void> fetchVenue(String venueId) async {
    state = state.copyWith(requestState: RequestState.loading);
    final result = await sl<GetVenueUseCase>().call(venueId);

    result.fold(
      (failure) {
        log('Venue error: ${failure.message}');
        state = state.copyWith(
          requestState: RequestState.error,
          errorMessage: failure.message,
        );
      },
      (venue) {
        state = state.copyWith(requestState: RequestState.success, data: venue);
      },
    );
  }
}

// ── Catalog ────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class Catalog extends _$Catalog {
  @override
  BaseState<CatalogEntity> build() {
    return const BaseState<CatalogEntity>();
  }

  Future<void> fetchCatalog(String venueId) async {
    state = state.copyWith(requestState: RequestState.loading);
    final result = await sl<GetCatalogUseCase>().call(venueId);

    result.fold(
      (failure) {
        log('Catalog error: ${failure.message}');
        state = state.copyWith(
          requestState: RequestState.error,
          errorMessage: failure.message,
        );
      },
      (catalog) {
        state = catalog.sections.isEmpty
            ? state.copyWith(requestState: RequestState.empty)
            : state.copyWith(requestState: RequestState.success, data: catalog);
      },
    );
  }
}

// ── Selected Category ──────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class SelectedCategory extends _$SelectedCategory {
  @override
  int build() => 0;

  void select(int index) => state = index;
}
