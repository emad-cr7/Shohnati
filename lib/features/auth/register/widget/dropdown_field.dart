import 'package:flutter/material.dart';
import 'package:sh7naty/features/auth/register/register_Controller.dart';

import '../../../../core/share/custom_dropdown_form_field.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({super.key, required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Zone
        CustomDropdownFormField(
          value: controller.selectedCity,
          hintText: 'zone',
          prefixIcon: Icons.location_city,
          items: controller.cities,
          onChanged: controller.selectCity,
        ),

        const SizedBox(height: 8),

        // Region
        CustomDropdownFormField(
          value: controller.selectedRegion,
          hintText: 'Region',
          prefixIcon: Icons.location_on_outlined,
          items: controller.regions,
          onChanged: controller.selectRegion,
        ),

        const SizedBox(height: 8),

        // Payment Type
        CustomDropdownFormField(
          value: controller.selectedPayment,
          hintText: 'Payment Type',
          prefixIcon: Icons.payment,
          items: controller.paymentTypes,
          onChanged: controller.selectPayment,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
