import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadserv_app/common/constant/app_images.dart';
import 'package:loadserv_app/common/constant/textStyles.dart';
import 'package:loadserv_app/common/theme/color/app_colors.dart';
import 'package:loadserv_app/features/cart/presentation/pages/Cart.dart';
import 'package:loadserv_app/features/categories/presentation/pages/addProductToCart.dart';
import 'package:loadserv_app/common/di/injection_container.dart';
import 'package:loadserv_app/common/widget/app_loading.dart';
import 'package:loadserv_app/features/categories/domain/models/category.dart';
import 'package:loadserv_app/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:loadserv_app/features/categories/presentation/cubit/categories_state.dart';
import 'package:loadserv_app/features/categories/presentation/widgets/search.dart';
import '../../../../common/widget/app_error_widget.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Product> allProducts = []; // Holds all products
  List<Product>? filteredProducts ; // Holds filtered products
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch categories and products
    final categoriesCubit = sl<CategoriesCubit>();
    categoriesCubit.fetchCategories(11);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = sl<CategoriesCubit>();

    return Scaffold(
      body: 
        BlocProvider(          create: (context) => categoriesCubit..fetchCategories(11),

        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state.categoriesState.isError) {
              return Positioned(
                top: 0,
                bottom: 0,
                left: 60,
                right: 60,
                child: Center(
                  child: AppErrorWidget(
                    errorMessage: state.categoriesState.errorMessage!,
                    onRefresh: () => _onRefresh(context),
                  ),
                ),
              );
            }
            if (state.categoriesState.isLoading) {
              return Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: AppLoading(),
                ),
              );
            }
                
            final Category? category = state.categoriesState.data;
            allProducts = category?.products ?? [];
                
            return SingleChildScrollView(
              child: Column(
                children: [
                  HeaderSection(category: category),
                  SearchSection(
                    searchController: _searchController,
                    onSearch: _filterProducts,
                  ),
                  ProductGrid(products: filteredProducts ?? allProducts),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  CartScreen()),
  );         },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppImages.cart),
        ),
      ),
    );
  }

  void _onRefresh(context) async {
    _loadData(context);
  }

  void _loadData(context) {
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = allProducts
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
          log(filteredProducts!.length.toString());
    });
  }
}

class HeaderSection extends StatelessWidget {
final Category? category;
HeaderSection({this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.7,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),

              image: DecorationImage(
                image: NetworkImage(
                  category?.backgroundImage??""
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.3), // Adjust the opacity as needed
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: Text(
           category?.name??"",
              style: TextStyles.bold28().copyWith(
                color: AppColors.white
              )
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4 - 60,
            left:0,
            right: 0,

            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 132,
                  height: 132,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.white,
                  child: ClipOval(
                    child: Image.network(
category?.image??"",                      fit: BoxFit.cover,
                      height: 107,
                      width: 107,
                    ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  ProductGrid({required this.products});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false; // Track the favorite status

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 243,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  height: 120,
                  widget.product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite; // Toggle favorite status
                    });
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  widget.product.description,
                  maxLines: 2,
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                widget.product.price != 0
                    ? Text(
                  '\$${widget.product.price}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,

                    fontSize: 22,
                  ),
                )
                    : Text(
                  'Price upon selection',
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Container(
                    height: 29,
                    width: 29,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFB832), Color(0xFFFC4722)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      // color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: AppColors.white,
                          shape: const RoundedRectangleBorder(
                
                            borderRadius: BorderRadius.vertical(
                
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) =>  FoodBottomSheet(id:widget.product.id ,),
                        );
                      },
                      child: Center(
                        child: Icon(Icons.add, color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


