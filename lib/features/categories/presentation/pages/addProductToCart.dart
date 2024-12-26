import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:loadserv_app/common/di/injection_container.dart';
import 'package:loadserv_app/common/widget/app_error_widget.dart';
import 'package:loadserv_app/common/widget/app_loading.dart';
import 'package:loadserv_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';
import 'package:loadserv_app/features/categories/presentation/cubit/ProductDetails_cubit.dart';
import 'package:loadserv_app/features/categories/presentation/cubit/ProductDetails_state.dart';
import 'package:loadserv_app/features/categories/presentation/pages/additionSection.dart';
import 'package:loadserv_app/features/categories/presentation/pages/extrasSection.dart';
import 'package:loadserv_app/features/categories/presentation/pages/header.dart';
import 'package:loadserv_app/features/categories/presentation/pages/weightsSection.dart';
import 'package:loadserv_app/features/categories/presentation/widgets/addToCartButton.dart';


class FoodBottomSheet extends StatefulWidget {
  final int id;

  const FoodBottomSheet({Key? key, required this.id}) : super(key: key);

  @override
  State<FoodBottomSheet> createState() => _FoodBottomSheetState();
}

class _FoodBottomSheetState extends State<FoodBottomSheet> {
  double weightPrice = 0.0;
  double saladPrice = 0.0;
  double extraPrice = 0.0;
  double HeaderPriceAndWeightPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = sl<ProductDetailsCubit>();

    return
        BlocProvider(create: (context) => productDetailsCubit..fetchProductDetails(widget.id),
              

      
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state.productDetailsState.isError) {
            return Positioned(
              top: 0,
              bottom: 0,
              left: 60,
              right: 60,
              child: Center(
                child: AppErrorWidget(
                  errorMessage: "${state.productDetailsState.errorMessage}".tr,
                ),
              ),
            );
          }
          if (state.productDetailsState.isLoading) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: AppLoading(),
              ),
            );
          }

          final ProductData? productData = state.productDetailsState.data;

          return Container(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),

                    Header(
  productData: productData,
  weightPrice: weightPrice,
  HeaderPriceAndWeightPrice: (p0) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          HeaderPriceAndWeightPrice = p0;
        });
      }
    });
  },
),

                    const SizedBox(height: 16),
                    productData?.weights ==null
                        ? SizedBox()
                        : WeightsSection(
                            productData: productData!,
                            onWeightSelected: (price) {
                              setState(() {
                                weightPrice = price;
                              });
                            }),
                    const SizedBox(height: 16),
                    AdditionSection(
                        productData: productData,
                        onSelected: (ListSalad, isAdd, totalPrice) {
                          setState(() {
                            saladPrice = totalPrice;
                          });
                        }),
                    const SizedBox(height: 16),
             ExtrasSection(
  extraItems: productData!.extraItems,
  onSelectionChanged: (selectedExtras, totalPrice) {
    setState(() {
      extraPrice = totalPrice;
    });
  },
),

                    const SizedBox(height: 16),
                    AddToCartButton(
                      
                      productData: productData,
                      productPrice: HeaderPriceAndWeightPrice,
                      saladPrice: saladPrice,
                      extraPrince: extraPrice,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
