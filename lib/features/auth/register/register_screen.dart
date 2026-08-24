import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh7naty/features/auth/register/register_Controller.dart';

import '../../../core/share/custom_dropdown_form_field.dart';
import '../../../core/share/custom_text_formField.dart';
import '../../../core/share/validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
      create: (BuildContext context) => RegisterController(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Color(0xff303030)),
          ),
        ),

        backgroundColor: Colors.white,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 5),

          child: Consumer<RegisterController>(
            builder:
                (
                  BuildContext context,
                  RegisterController controller,
                  Widget? child,
                ) {
                  return Form(
                    key: controller.key,

                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color(0xff29209a),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_add_alt_1,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              "Create a new account",
                              style: TextStyle(
                                color: Color(0xff303030),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 3),

                            const Text(
                              "Enter your details to create a new account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 13),

                            // Store Name
                            CustomTextFormField(
                              title: 'Store Name',
                              controller: controller.storeNameController,
                              textInputAction: TextInputAction.next,
                              prefixIcon: Icons.store,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter store name';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 8),

                            // Name
                            CustomTextFormField(
                              title: 'Name',
                              controller: controller.nameController,
                              textInputAction: TextInputAction.next,
                              prefixIcon: Icons.person,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 8),

                            // Email
                            CustomTextFormField(
                              title: 'Email',
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              prefixIcon: Icons.email,
                              validator: Validators.email,
                            ),

                            const SizedBox(height: 8),

                            // Phone + Country Code
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
                                        bottomSheetHeight:
                                            MediaQuery.of(context).size.height *
                                            0.5,
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
                                      border: Border.all(
                                        color: const Color(0xffb8b8b8),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.selectedCountry.flagEmoji,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '+${controller.selectedCountry.phoneCode}',
                                        ),
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
                                  child: TextFormField(
                                    controller: controller.phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      hintText: 'Phone *',
                                      prefixIcon: Icon(Icons.phone_android),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

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
                            // Address
                            CustomTextFormField(
                              title: 'Address',
                              controller: controller.addressController,
                              textInputAction: TextInputAction.next,
                              prefixIcon: Icons.location_on,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter address';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 8),

                            // Password
                            CustomTextFormField(
                              title: 'Password',
                              controller: controller.passwordController,
                              textInputAction: TextInputAction.done,
                              prefixIcon: Icons.key,
                              obscureText: controller.obscurePassword,
                              validator: Validators.password,

                              suffixIcon: IconButton(
                                onPressed: controller.togglePassword,
                                icon: Icon(
                                  controller.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 18,
                                  color: const Color(0xff29209a),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Create Account Button
                            SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.register();
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                },
          ),
        ),
      ),
    );
  }
}
