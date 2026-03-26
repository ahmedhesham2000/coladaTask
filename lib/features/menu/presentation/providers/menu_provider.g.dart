// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Venue)
final venueProvider = VenueProvider._();

final class VenueProvider
    extends $NotifierProvider<Venue, BaseState<VenueEntity>> {
  VenueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'venueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$venueHash();

  @$internal
  @override
  Venue create() => Venue();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseState<VenueEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseState<VenueEntity>>(value),
    );
  }
}

String _$venueHash() => r'bb10869ffbaeae1486c8abbc78cf889c2114c2b7';

abstract class _$Venue extends $Notifier<BaseState<VenueEntity>> {
  BaseState<VenueEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<BaseState<VenueEntity>, BaseState<VenueEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BaseState<VenueEntity>, BaseState<VenueEntity>>,
              BaseState<VenueEntity>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Catalog)
final catalogProvider = CatalogProvider._();

final class CatalogProvider
    extends $NotifierProvider<Catalog, BaseState<CatalogEntity>> {
  CatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogHash();

  @$internal
  @override
  Catalog create() => Catalog();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseState<CatalogEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseState<CatalogEntity>>(value),
    );
  }
}

String _$catalogHash() => r'bd996d6202929681dac760261220e600ad13e155';

abstract class _$Catalog extends $Notifier<BaseState<CatalogEntity>> {
  BaseState<CatalogEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<BaseState<CatalogEntity>, BaseState<CatalogEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BaseState<CatalogEntity>, BaseState<CatalogEntity>>,
              BaseState<CatalogEntity>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedCategory)
final selectedCategoryProvider = SelectedCategoryProvider._();

final class SelectedCategoryProvider
    extends $NotifierProvider<SelectedCategory, int> {
  SelectedCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCategoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCategoryHash();

  @$internal
  @override
  SelectedCategory create() => SelectedCategory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedCategoryHash() => r'8ca4d077043e7d6f265b67e7aace73f33cc01ee8';

abstract class _$SelectedCategory extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
