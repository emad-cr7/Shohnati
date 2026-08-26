import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../../core/shared/app_dialogs.dart';
import '../../../main.dart';
import '../data/models/zone_model.dart';
import '../data/services/auth_service.dart';
import '../data/services/register_service.dart';
import 'helpers/register_helper.dart';
import 'otp/otp_screen.dart';

class RegisterController extends ChangeNotifier {
  // ------------------------------variables--------------------------------

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegisterService registerService = RegisterService();
  final AuthService authService = AuthService();
  bool obscurePassword = true;
  ZoneModel? selectedZones;
  ZoneModel? selectedRegion;
  String? selectedPayment;
  bool isZonesLoading = false;
  bool isRegionsLoading = false;
  List<ZoneModel> zones = [];
  List<ZoneModel> regions = [];
  Country selectedCountry = RegisterHelper().country;
  final List<String> paymentTypes = RegisterHelper().paymentTypes;
  bool isRegistering = false;

  // ------------------------------init--------------------------------

  init() {
    fetchZones();
  }

  // ------------------------------togglePassword--------------------------------

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  // ------------------------------fetchZones--------------------------------

  Future<void> fetchZones() async {
    isZonesLoading = true;
    notifyListeners();
    try {
      zones = await registerService.getZones();
    } finally {
      isZonesLoading = false;
      notifyListeners();
    }
  }

  void selectZones(ZoneModel? value) {
    selectedZones = value;
    selectedRegion = null;
    regions = [];
    notifyListeners();
    if (value != null) {
      fetchRegions();
    }
  }

  // ------------------------------fetchRegions--------------------------------

  Future<void> fetchRegions() async {
    isRegionsLoading = true;
    notifyListeners();
    try {
      regions = await registerService.getRegions(int.parse(selectedZones!.id));
    } finally {
      isRegionsLoading = false;
      notifyListeners();
    }
  }

  void selectRegion(ZoneModel? value) {
    selectedRegion = value;
    notifyListeners();
  }

  // ------------------------------updateSelectedCountry--------------------------------

  void updateSelectedCountry(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  // ------------------------------selectPayment--------------------------------

  void selectPayment(String? value) {
    selectedPayment = value;
    notifyListeners();
  }

  // ------------------------------register--------------------------------

  Future<void> register() async {
    if (!key.currentState!.validate()) {
      return;
    }
    isRegistering = true;
    notifyListeners();

    try {
      final success = await authService.register(
        businessName: storeNameController.text.trim(),
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        mobile: phoneController.text.trim(),
        zoneId: int.parse(selectedZones!.id),
        subzoneId: int.parse(selectedRegion!.id),
        address: addressController.text.trim(),
        paymentMethodCode: RegisterHelper.mapPaymentCode(selectedPayment),
        password: passwordController.text,
        postalCode: '11511',
      );

      final context = navigatorKey.currentContext;

      if (success) {
        if (context != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(email: emailController.text.trim(),),
            ),
          );
        }
      } else {
        if (context != null) {
          AppDialogs.showError(
            context,
            message: 'Registration failed, please try again.',
          );
        }
      }
    } catch (e) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final errorStr = e.toString();
      final isEmailTaken = errorStr.contains('input.email');
      final isMobileTaken = errorStr.contains('input.mobile');

      if (isEmailTaken && isMobileTaken) {
        AppDialogs.showError(
          context,
          message: 'The email and phone number are already in use.',
        );
      } else if (isEmailTaken) {
        AppDialogs.showError(
          context,
          message: 'This email address is already in use.',
        );
      } else if (isMobileTaken) {
        AppDialogs.showError(
          context,
          message: 'This phone number is already in use.',
        );
      }
    } finally {
      isRegistering = false;
      notifyListeners();
    }
  }

  // ------------------------------dispose--------------------------------

  @override
  void dispose() {
    storeNameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
