import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/share/custom_text_formField.dart';
import '../../../../core/share/validators/validators.dart';
import '../register_Controller.dart';

class PhoneCountryCode extends StatelessWidget {
  const PhoneCountryCode({super.key, required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  showSearch: true,
                  countryListTheme: CountryListThemeData(
                    backgroundColor: Colors.white,
                    bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
                    padding: EdgeInsets.zero,
                  ),
                  onSelect: (country) {
                    controller.selectedCountry = country;
                  },
                );
              },
              child: AbsorbPointer(
                child: SizedBox(
                  width: 100,
                  child: CustomTextFormField(
                    controller: TextEditingController(),
                    readOnly: true,
                    prefixIconWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          controller.selectedCountry.flagEmoji,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 4),
                        Text('+${controller.selectedCountry.phoneCode}'),
                      ],
                    ),
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Color(0xff757684),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: CustomTextFormField(
                title: 'Phone',
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.phone_android,
                validator: (value) =>
                    Validators.phone(value, controller.selectedCountry),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
