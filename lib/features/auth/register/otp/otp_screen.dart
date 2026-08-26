import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../main.dart';
import '../../data/services/auth_service.dart';
import '../../login/login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController codeController = TextEditingController();
  final AuthService authService = AuthService();

  bool isVerifying = false;
  bool isResending = false;
  String? errorMessage;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  Future<void> _verify(String code) async {
    setState(() {
      isVerifying = true;
      errorMessage = null;
    });

    try {
      final data = await authService.verifyRegistrationEmail(
        email: widget.email,
        code: code,
      );

      if (data != null && data['token'] != null) {
        if (mounted) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
          );
        }
      } else {
        setState(() => errorMessage = 'Invalid code, please try again');
      }
    } catch (e) {
      final errorCode = e.toString().replaceFirst('Exception: ', '');

      if (errorCode == 'EMAIL_ALREADY_VERIFIED') {
        if (mounted) {
          _showAlreadyVerifiedDialog();
        }
      } else {
        setState(() => errorMessage = 'Invalid or expired code');
      }
    } finally {
      if (mounted) setState(() => isVerifying = false);
    }
  }

  void _showAlreadyVerifiedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Account Already Verified'),
        content: const Text('This account is already verified. You can log in now.'),
        actions: [
          TextButton(
            onPressed: () {
              navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
              );
            },
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }

  Future<void> _resend() async {
    setState(() => isResending = true);
    try {
      await authService.resendVerificationCode(widget.email);
      codeController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A new code has been sent to your email'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong, please try again'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.red),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Verify Your Account')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Enter Verification Code',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'We sent a code to ${widget.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Center(
              child: Pinput(
                length: 4,
                controller: codeController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                errorPinTheme: errorPinTheme,
                forceErrorState: errorMessage != null,
                onCompleted: (code) => _verify(code),
                enabled: !isVerifying,
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
            const SizedBox(height: 24),
            if (isVerifying)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: () => _verify(codeController.text.trim()),
                child: const Text('Verify'),
              ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: isResending ? null : _resend,
              child: Text(isResending ? 'Sending...' : 'Resend Code'),
            ),
          ],
        ),
      ),
    );
  }
}
