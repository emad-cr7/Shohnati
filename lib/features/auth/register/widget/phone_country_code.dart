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
                    bottomSheetHeight: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.zero,
                  ),
                  onSelect: (country) {
                    controller.selectedCountry = country;
                  },
                );
              },
              child: Container(
                height: 51,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffb8b8b8)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.selectedCountry.flagEmoji),
                    const SizedBox(width: 5),
                    Text('+${controller.selectedCountry.phoneCode}'),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Color(0xff29209a),
                    ),
                  ],
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
                validator: Validators.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
