import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:loadserv_app/features/cart/presentation/cubit/cart_state.dart';

import '../../../categories/domain/models/product.dart';

@injectable 
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cartItems: []));

  void addToCart(ProductData product) {
    List<ProductData> updatedCart = List.from(state.cartItems);
    int index = updatedCart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      updatedCart[index].quantity += 1;
    } else {
      updatedCart.add(product);
    }
    emit(state.copyWith(cartItems: updatedCart));
  }

  void removeFromCart(int productId) {
    List<ProductData> updatedCart =
        state.cartItems.where((item) => item.id != productId).toList();
    emit(state.copyWith(cartItems: updatedCart));
  }

  void updateQuantity(int productId, int newQuantity) {
    List<ProductData> updatedCart = state.cartItems.map((product) {
      if (product.id == productId) {
        // return state.cartItems.copyWith(quantity: newQuantity);
      }
      return product;
    }).toList();

    emit(state.copyWith(cartItems: updatedCart));
  }

  void clearCart() {
    emit(state.copyWith(cartItems: []));
  }
}
