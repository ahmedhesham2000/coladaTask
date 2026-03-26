// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Cart)
final cartProvider = CartProvider._();

final class CartProvider extends $NotifierProvider<Cart, List<CartModel>> {
  CartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartHash();

  @$internal
  @override
  Cart create() => Cart();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CartModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CartModel>>(value),
    );
  }
}

String _$cartHash() => r'a9a06beed44b9f010eb1200401699e92c5449b43';

abstract class _$Cart extends $Notifier<List<CartModel>> {
  List<CartModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<CartModel>, List<CartModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CartModel>, List<CartModel>>,
              List<CartModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(cartTotal)
final cartTotalProvider = CartTotalProvider._();

final class CartTotalProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  CartTotalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartTotalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartTotalHash();

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    return cartTotal(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$cartTotalHash() => r'601ddd109ecdf2b49cf8d1b045b5ac6f76d003f7';
