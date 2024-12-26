import '../../../categories/domain/models/product.dart';

class CartState {
  final List<ProductData> cartItems;

  CartState({required this.cartItems});

  CartState copyWith({List<ProductData>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }
}
