import 'dart:convert';

import 'package:coladatask/features/menu/data/models/cart_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_provider.g.dart';

const _cartKey = 'cart_items';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  List<CartModel> build() {
    _loadFromStorage();
    return [];
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cartKey);
    if (jsonString == null || jsonString.isEmpty) return;

    final List<dynamic> decoded = jsonDecode(jsonString);
    final items = decoded
        .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
        .toList();
    if (items.isNotEmpty) {
      state = items;
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString(_cartKey, jsonString);
  }

  void addItem(CartModel item) {
    state = [...state, item];
    _saveToStorage();
  }

  void incrementItem(String itemId) {
    final index = state.indexWhere((e) => e.id == itemId);
    if (index < 0) return;

    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          CartModel(
            id: state[i].id,
            name: state[i].name,
            image: state[i].image,
            quantity: state[i].quantity + 1,
            price: state[i].price,
          )
        else
          state[i],
    ];
    _saveToStorage();
  }

  void decrementItem(String itemId) {
    final index = state.indexWhere((e) => e.id == itemId);
    if (index < 0) return;
    if (state[index].quantity <= 1) {
      removeItem(itemId);
    } else {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            CartModel(
              id: state[i].id,
              name: state[i].name,
              image: state[i].image,
              quantity: state[i].quantity - 1,
              price: state[i].price,
            )
          else
            state[i],
      ];
      _saveToStorage();
    }
  }

  void removeItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
    _saveToStorage();
  }

  bool isInCart(String itemId) {
    return state.any((item) => item.id == itemId);
  }

  int getQuantity(String itemId) {
    final index = state.indexWhere((e) => e.id == itemId);
    if (index < 0) return 0;
    return state[index].quantity;
  }
}

@riverpod
double cartTotal(Ref ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (total, item) => total + (item.price * item.quantity));
}
