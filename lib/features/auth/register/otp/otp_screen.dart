import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sh7naty/features/auth/register/otp/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OtpController>(
      create: (BuildContext context) => OtpController(email: email),
      child: Scaffold(
        appBar: AppBar(title: const Text('Verify OTP')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Consumer<OtpController>(
            builder: (context, controller, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enter OTP Code',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Enter the 4-digit code sent to ${controller.email}',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      hintText: '0000',
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          (controller.canResend && !controller.isResending)
                          ? () => controller.resend()
                          : null,
                      child: controller.isResending
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              controller.canResend
                                  ? 'Resend OTP'
                                  : 'Resend OTP (${controller.resendSecondsLeft}s)',
                            ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isVerifying
                          ? null
                          : () => controller.verify(),
                      child: controller.isVerifying
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Verify'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
