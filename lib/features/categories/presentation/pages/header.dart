import 'package:flutter/material.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';

class Header extends StatefulWidget {
  final ProductData? productData;
  final double weightPrice;
  final Function(double) HeaderPriceAndWeightPrice;

  const Header({
    Key? key,
    this.productData,
    required this.weightPrice,
    required this.HeaderPriceAndWeightPrice,
  }) : super(key: key);

  @override
  State<Header> createState() => HeaderState();
}

class HeaderState extends State<Header> {
  int quantity = 1;
  double AllPrice = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    double priceToDisplay = widget.weightPrice > 0
        ? widget.weightPrice
        : double.parse(widget.productData!.price.toString());

    AllPrice = (quantity * priceToDisplay);
    widget.HeaderPriceAndWeightPrice(AllPrice);

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.productData?.image ?? "",
              width: 132,
              height: 132,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productData?.name ?? "",
                  maxLines: 2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.productData?.priceBeforeDiscount.toString() ??
                                  "0") +
                              " EGP",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '$AllPrice EGP',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 29,
                          width: 29,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFFB832), Color(0xFFFC4722)],
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
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child:
                              Text('$quantity', style: TextStyle(fontSize: 16)),
                        ),
                        Container(
                          height: 29,
                          width: 29,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFFB832), Color(0xFFFC4722)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: incrementQuantity,
                            child: Center(
                              child: Icon(Icons.add, color: Colors.white),
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
        ],
      ),
    );
  }
}
