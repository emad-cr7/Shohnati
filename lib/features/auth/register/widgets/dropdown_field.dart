import 'package:flutter/material.dart';
import 'package:sh7naty/features/auth/register/register_controller.dart';
import '../../../../core/shared/custom_dropdown_form_field.dart';
import '../../../../core/shared/custom_text_form_field_zone.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({super.key, required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Zone


        CustomTextFormFieldZone(
          value: controller.selectedZones,
          hintText: 'zone',
          prefixIcon: Icons.location_city,
          items: controller.zones,
          onChanged: controller.selectZones,

        ),

        const SizedBox(height: 8),

        // Region
        CustomTextFormFieldZone(
          value: controller.selectedRegion,
          hintText: 'Region',
          prefixIcon: Icons.location_on_outlined,
          items: controller.regions,
          onChanged: controller.selectRegion,
          enabled: controller.selectedZones != null,
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
