import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_style.dart';

class CommonDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CommonDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value != null && items.contains(value) ? value : null,
          hint: Text(hint, style: AppTextStyles.bodySmallGrey),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          dropdownColor: AppColors.extraPrimaryLight,

          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: AppTextStyles.bodySmall),
                ),
              )
              .toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}
