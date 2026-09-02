import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh7naty/features/auth/login/widgets/forgot_controller.dart';
import '../../../../core/shared/custom_text_formField.dart';
import '../../../../core/shared/validators/validators.dart';

class ForgotPasswordSheet extends StatelessWidget {
 const ForgotPasswordSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotController>(
      create: (context) => ForgotController(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Consumer<ForgotController>(
            builder: (context, controller, Widget? child) {
              return Form(
                key: controller.Key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomTextFormField(
                      title: 'Email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.email,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.handleSubmit,
                        child: const Text('Send'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
