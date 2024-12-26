
import 'package:flutter/material.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';

class AdditionSection extends StatefulWidget {
  final ProductData? productData;
  final Function(List<Salad>, bool isAdd, double totalPrice) onSelected;

  const AdditionSection({Key? key, this.productData, required this.onSelected})
      : super(key: key);

  @override
  State<AdditionSection> createState() => AdditionSectionState();
}

class AdditionSectionState extends State<AdditionSection> {
  List<Salad> salad = [];
  int totalCount = 0;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Addition (select ${totalCount}):',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 3.7,
            ),
            itemCount: widget.productData?.salads.length,
            itemBuilder: (context, index) {
              return _AdditionItem(
                onSelected: (_salad, count, isAdd) {
                  setState(() {
                    if (isAdd) {
                      int index = salad
                          .indexWhere((element) => element.id == _salad.id);
                      if (index == -1) {
                        salad.add(_salad);
                      } else {
                        salad[index] = _salad;
                      }
                    } else {
                      salad.removeWhere((element) => element.id == _salad.id);
                      salad.add(_salad);
                    }

                    Map<String, int> saladCountMap = {};
                    totalPrice = 0;
                    totalCount = 0;
                    for (var item in salad) {
                      totalPrice += item.price;
                      totalCount += item.count!;
                    }

                    widget.onSelected(salad, isAdd, totalPrice);
                  });
                },
                salad: widget.productData!.salads[index],
              );
            })
      ],
    );
  }
}

class _AdditionItem extends StatefulWidget {
  final Salad salad;

  final Function(Salad, int count, bool isAdd) onSelected;

  const _AdditionItem({
    Key? key,
    required this.salad,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<_AdditionItem> createState() => _AdditionItemState();
}

class _AdditionItemState extends State<_AdditionItem> {
  @override
  int _count = 1;

  void initState() {
    super.initState();
    _count = widget.salad.count ?? 0;
  }

  void incrementQuantity() {
    setState(() {
      _count++;
      widget.onSelected(
          Salad(
              id: widget.salad.id,
              name: widget.salad.name,
              price: widget.salad.price * _count,
              image: widget.salad.image,
              count: _count),
          _count,
          true);
    });
  }

  void decrementQuantity() {
    if (_count > 0) {
      setState(() {
        _count--;
        widget.onSelected(
            Salad(
                id: widget.salad.id,
                name: widget.salad.name,
                price: widget.salad.price * _count,
                image: widget.salad.image,
                count: _count),
            _count,
            false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              widget.salad.image,
              width: 100,
              height: 132,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.salad.name}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.salad.price}' + " EGP",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
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
                    child: Icon(Icons.remove_outlined, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('${_count}', style: TextStyle(fontSize: 16)),
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
    );
  }
}
