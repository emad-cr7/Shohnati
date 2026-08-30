import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../features/auth/data/models/zone_model.dart';

class CustomTextFormFieldZone extends StatelessWidget {
  final ZoneModel? value;
  final String hintText;
  final IconData prefixIcon;
  final List<ZoneModel> items;
  final ValueChanged<ZoneModel?> onChanged;
  final bool enabled;

  const CustomTextFormFieldZone({
    super.key,
    required this.value,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = enabled ? const Color(0xff29209a) : Colors.grey;
    return DropdownSearch<ZoneModel>(
      enabled: enabled,
      selectedItem: value,
      items: (filter, infiniteScrollProps) => items,
      itemAsString: (item) => item.name,
      compareFn: (item1, item2) => item1.id == item2.id,
      onSelected: onChanged,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: color, size: 22),
          suffixIcon: Icon(Icons.keyboard_arrow_down, color: color, size: 22),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color, width: 2),
          ),
        ),
      ),
      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,
        itemBuilder: (context, item, isDisabled, isSelected) {
          final selected = value?.id == item.id;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFEAEAEA), width: 1),
              ),
            ),
            child: Row(
              children: [
                if (selected)
                  Icon(Icons.check, color: Color(0xff29209a), size: 20),
                Spacer(),

                Text(
                  item.name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 17,
                    color: isDisabled ? Colors.grey : Colors.black87,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
        containerBuilder: (context, popupWidget) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: popupWidget,
          );
        },
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xff29209a)),
            ),
          ),
        ),
      ),
    );
  }
}
