import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_app/common/constant/app_images.dart';
import 'package:loadserv_app/common/constant/textStyles.dart';
import 'package:loadserv_app/common/theme/color/app_colors.dart';
import 'package:loadserv_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:loadserv_app/features/cart/presentation/cubit/cart_state.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
    String? note;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Cart Screen"),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(child: Text("The basket is empty."));
          }

          final cartItems = state.cartItems;
          final totalPrice = cartItems.fold<double>(
            0,
            (sum, item) => sum + item.price * item.quantity,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          product.image,
                                          width: 138,
                                          height: 138,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 28,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<CartCubit>()
                                              .removeFromCart(product.id);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(product.name,
                                      maxLines: 1,
                                          style: TextStyles.bold20()),
                                      const SizedBox(height: 4),
                                      product.weights == null
                                          ? SizedBox()
                                          : RichText(
                                              text: TextSpan(
                                                text: "Weight: ",
                                                style: TextStyles.bold16(),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${product.weights?.first.name}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                          text: "Salads: ",
                                          style: TextStyles.bold16(),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${product.salads.first.name}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      RichText(
                                        text: TextSpan(
                                          text: "Extras: ",
                                          style: TextStyles.bold16(),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${product.extraItems.first.name}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${product.price * product.quantity} EGP",
                                              style: TextStyles.bold20()),
                                          Image.asset(
                                            AppImages.note,
                                            width: 32,
                                            height: 32,
                                          ),
                                          InkWell(
                                            onTap: _showAddNoteDialog,
                                            child: Image.asset(
                                              AppImages.chat,
                                              width: 32,
                                              height: 32,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  children: [
                                    Container(
                                      height: 29,
                                      width: 29,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFB832),
                                            Color(0xFFFC4722)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: InkWell(
                                        onTap: decrementQuantity,
                                        child: Center(
                                          child: Icon(Icons.remove_outlined,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Text('$quantity',
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Container(
                                      height: 29,
                                      width: 29,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFB832),
                                            Color(0xFFFC4722)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: InkWell(
                                        onTap: incrementQuantity,
                                        child: Center(
                                          child: Icon(Icons.add,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                 
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Checkout',
                              style: TextStyles.bold22()
                                  .copyWith(color: AppColors.white)),
                          SizedBox(width: 16),
                          Text('${totalPrice.toString()} EGP',
                              style: TextStyles.bold22()
                                  .copyWith(color: AppColors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().clearCart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text("Delete All",
                              style: TextStyles.bold22()
                                  .copyWith(color: AppColors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  } void _showAddNoteDialog() {
    TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Note',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your note here...',
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.grey_2,
                      ),
                      child: Text('Cancel',style:  TextStyles.bold16().copyWith(color: AppColors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          note = noteController.text;
                        });
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text('Confirm',style:  TextStyles.bold16().copyWith(color: AppColors.white),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }}
