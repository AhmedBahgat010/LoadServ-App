import 'package:flutter/material.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';

import '../../../../common/theme/color/app_colors.dart';
class WeightsSection extends StatefulWidget {
  final ProductData productData;
  final Function(double) onWeightSelected;

  const WeightsSection(
      {Key? key, required this.productData, required this.onWeightSelected})
      : super(key: key);

  @override
  State<WeightsSection> createState() => WeightsSectionState();
}

class WeightsSectionState extends State<WeightsSection> {
  int? selectedWeightId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weights',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (widget.productData.weights != null &&
            widget.productData.weights!.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 19,
              mainAxisSpacing: 8,
              childAspectRatio: 2.5,
            ),
            itemCount: widget.productData.weights!.length,
            itemBuilder: (context, index) {
              final weight = widget.productData.weights![index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWeightId = weight.id;
                    widget.onWeightSelected(
                        double.parse(weight.price.toString()));
                  });
                  print('Selected Weight: ${weight.name}');
                  print(
                      'Details: ${weight.price} EGP, Points: ${weight.points}, Price Before Discount: ${weight.priceBeforeDiscount}');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weight.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '${weight.price} EGP',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      CustomRadio(
                        isSelected: selectedWeightId == weight.id,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        else
          const Text('No weights available',
              style: TextStyle(fontSize: 14, color: Colors.red)),
      ],
    );
  }
}

class CustomRadio extends StatelessWidget {
  final bool isSelected;
  const CustomRadio({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey,
          width: 2,
        ),
        color: isSelected ? AppColors.primary : Colors.white,
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
          : null,
    );
  }
}
