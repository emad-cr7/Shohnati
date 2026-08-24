import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh7naty/features/auth/login/login_controller.dart';
import 'package:sh7naty/features/auth/register/register_screen.dart';

import '../../../core/share/custom_text_formField.dart';
import '../../../core/share/validators/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ChangeNotifierProvider<LoginController>(
          create: (BuildContext context) => LoginController(),
          child: Consumer<LoginController>(
            builder:
                (BuildContext context, LoginController controller, Widget? child,) {
                  return Center(
                    child: Form(
                      key: controller.Key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sh7naty",
                            style: TextStyle(
                              color: Color(0xff00288E),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Easier shipping... faster delivery.",
                            style: TextStyle(
                              color: Color(0xff3e3e42),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome back.",
                                  style: TextStyle(
                                    color: Color(0xff3e3e42),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Log in to easily track your shipments.",
                                  style: TextStyle(
                                    color: Color(0xff3e3e42),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 30),
                                CustomTextFormField(
                                  title: 'Email',
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  prefixIcon: Icons.email,
                                  validator: Validators.email,
                                ),
                                SizedBox(height: 20),
                                CustomTextFormField(
                                  title: 'Password',
                                  controller: controller.passwordController,
                                  textInputAction: TextInputAction.done,
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: controller.obscurePassword,
                                  validator: Validators.password,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 20,
                                    ),
                                    onPressed: controller.togglePassword,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Align(
                                  alignment: .topEnd,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Text('Forgot your password?'),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  height: 55,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.login();
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
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        color: Color(0xff3e3e42),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return RegisterScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Create an account",
                                        style: TextStyle(
                                          color: Color(0xff00288E),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
