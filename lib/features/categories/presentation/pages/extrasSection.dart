import 'package:flutter/material.dart';
import 'package:loadserv_app/common/theme/color/app_colors.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';
import '../../../../common/constant/textStyles.dart';import 'package:flutter/material.dart';
import 'package:loadserv_app/common/theme/color/app_colors.dart';
import 'package:loadserv_app/features/categories/domain/models/product.dart';
import '../../../../common/constant/textStyles.dart';

class ExtrasSection extends StatefulWidget {
  final List<ExtraItem> extraItems;
  final Function(List<ExtraItem> selectedExtras, double totalPrice) onSelectionChanged;

  const ExtrasSection({
    Key? key,
    required this.extraItems,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<ExtrasSection> createState() => _ExtrasSectionState();
}

class _ExtrasSectionState extends State<ExtrasSection> {
  List<ExtraItem> selectedExtras = [];
  double totalPrice = 0.0;

  void _onOptionChanged(ExtraItem item, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedExtras.add(item);
        totalPrice += item.price;
      } else {
        selectedExtras.remove(item);
        totalPrice -= item.price;
      }
    });

    // إبلاغ التغييرات للوالد
    widget.onSelectionChanged(selectedExtras, totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Extras:',
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
            childAspectRatio: 7,
          ),
          itemCount: widget.extraItems.length,
          itemBuilder: (context, index) {
            return ExtraOption(
              extra: widget.extraItems[index],
              onSelectionChanged: _onOptionChanged,
            );
          },
        ),
      ],
    );
  }
}

class ExtraOption extends StatefulWidget {
  final ExtraItem extra;
  final Function(ExtraItem item, bool isSelected) onSelectionChanged;

  const ExtraOption({
    Key? key,
    required this.extra,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<ExtraOption> createState() => _ExtraOptionState();
}

class _ExtraOptionState extends State<ExtraOption> {
  bool _isSelected = false;

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
        children: [
          Expanded(
            flex: 3,
            child: Text(
              widget.extra.name,
              style: TextStyles.bold16(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 1,
            child: Text(
              '${widget.extra.price} EGP',
              style: TextStyles.bold16(),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(width: 10),
          Checkbox(
            checkColor: AppColors.white,
            activeColor: AppColors.primary,
            side: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
            value: _isSelected,
            onChanged: (value) {
              setState(() {
                _isSelected = value ?? false;
                widget.onSelectionChanged(widget.extra, _isSelected);
              });
            },
          ),
        ],
      ),
    );
  }
}
