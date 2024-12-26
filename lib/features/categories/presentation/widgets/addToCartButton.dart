import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';
class AddToCartButton extends StatelessWidget {
  final double saladPrice;
  final double productPrice;
  final double extraPrince;
  final ProductData productData;
  const AddToCartButton(
      {Key? key,
      required this.saladPrice,
      required this.productPrice,
      required this.extraPrince,required this.productData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double AllPrice = 0;

    AllPrice = productPrice + saladPrice + extraPrince;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        
               final cartCubit = context.read<CartCubit>();
        final product = ProductData(
          id: productData.id, 
          name: productData.name,
          description:productData.description,
          image: productData.image,
          isSingle: productData.isSingle,
          points: productData.points,
          price: productPrice.toInt(),
          priceBeforeDiscount: productData.price,
          extraItems:productData.extraItems,
          salads: productData.salads,
          weights: productData.weights,
        );
         cartCubit.addToCart(product);
        
         Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product added to cart!")),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add To Cart',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(width: 16),
          Text('${AllPrice.toString()} EGP',
              style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }
}
