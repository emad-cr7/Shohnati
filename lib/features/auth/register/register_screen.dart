import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh7naty/features/auth/register/register_controller.dart';
import 'package:sh7naty/features/auth/register/widgets/dropdown_field.dart';
import 'package:sh7naty/features/auth/register/widgets/phone_country_code.dart';
import '../../../core/shared/custom_text_formField.dart';
import '../../../core/shared/validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
      create: (BuildContext context) => RegisterController()..init(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Color(0xff303030)),
          ),
        ),

        backgroundColor: Colors.white,

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 5),

          child: Consumer<RegisterController>(
            builder:
                (
                  BuildContext context,
                  RegisterController controller,
                  Widget? child,
                ) {
                  return controller.isZonesLoading
                      ? Center(child: CircularProgressIndicator())
                      : Form(
                          key: controller.key,
                          child: SingleChildScrollView(
                            child: SafeArea(
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xff29209a),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person_add_alt_1,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Create a new account",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayLarge,
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Enter your details to create a new account",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),

                                  SizedBox(height: 13),
                                  // Store Name
                                  CustomTextFormField(
                                    title: 'Store Name',
                                    controller: controller.storeNameController,
                                    textInputAction: TextInputAction.next,
                                    prefixIcon: Icons.store,
                                    validator: Validators.storeName,
                                  ),
                                  SizedBox(height: 8),
                                  // Name
                                  CustomTextFormField(
                                    title: 'Name',
                                    controller: controller.nameController,
                                    textInputAction: TextInputAction.next,
                                    prefixIcon: Icons.person,
                                    validator: Validators.name,
                                  ),
                                  SizedBox(height: 8),
                                  // Email
                                  CustomTextFormField(
                                    title: 'Email',
                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    prefixIcon: Icons.email,
                                    validator: Validators.email,
                                  ),

                                  SizedBox(height: 8),

                                  /// Phone - Country Code
                                  PhoneCountryCode(controller: controller),

                                  SizedBox(height: 8),

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
                                  SizedBox(height: 8),
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
                                        color: Color(0xff29209a),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 18),
                                  // Create Account Button
                                  SizedBox(
                                    height: 55,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.register();
                                      },
                                      child: controller.isRegistering
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              "Create Account",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                            ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
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
