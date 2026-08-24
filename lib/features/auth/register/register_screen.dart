import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh7naty/features/auth/register/register_Controller.dart';
import 'package:sh7naty/features/auth/register/widget/dropdown_field.dart';
import 'package:sh7naty/features/auth/register/widget/phone_country_code.dart';

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
                (BuildContext context,
                RegisterController controller,
                Widget? child,) {
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
                            validator: Validators.storeName,
                        ),
                        const SizedBox(height: 8),
                        // Name
                        CustomTextFormField(
                          title: 'Name',
                          controller: controller.nameController,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icons.person,
                          validator: Validators.name,
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

                        /// Phone - Country Code
                        PhoneCountryCode(controller: controller),

                        const SizedBox(height: 8),

                        /// Zone - Region  - Payment
                        DropdownField(controller: controller),

                        // Address
                        CustomTextFormField(
                          title: 'Address',
                          controller: controller.addressController,
                          textInputAction: TextInputAction.next,
                          prefixIcon: Icons.location_on,
                          validator: Validators.address,
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
                              size: 20,
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
