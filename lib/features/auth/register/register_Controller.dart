import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sh7naty/features/auth/login/login_screen.dart';
import '../../../main.dart';
import '../data/models/zone_model.dart';
import '../data/services/auth_service.dart';
import '../data/services/register_service.dart';

class RegisterController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  ZoneModel? selectedCity;
  ZoneModel? selectedRegion;

  String? selectedPayment;
  bool isZonesLoading = false;
  bool isRegionsLoading = false;

  final AuthService authService = AuthService();
  bool isRegistering = false;

  init() {
    fetchZones();
  }

  final RegisterService registerService = RegisterService();
  List<ZoneModel> zones = [];

  Future<void> fetchZones() async {
    isZonesLoading = true;
    notifyListeners();
    try {
      zones = await registerService.getZones();
    } catch (e) {
      log('Error fetching zones: $e');
    } finally {
      isZonesLoading = false;
      notifyListeners();
    }
  }

  void selectCity(ZoneModel? value) {
    selectedCity = value;
    selectedRegion = null;
    regions = [];
    notifyListeners();

    if (value != null) {
      fetchRegions();
    }
  }

  List<ZoneModel> regions = [];

  Future<void> fetchRegions() async {
    isRegionsLoading = true;
    notifyListeners();
    try {
      regions = await registerService.getRegions(int.parse(selectedCity!.id));
    } catch (e) {
      log('Error fetching regions: $e');
    } finally {
      isRegionsLoading = false;
      notifyListeners();
    }
  }

  void selectRegion(ZoneModel? value) {
    selectedRegion = value;
    notifyListeners();
  }

  Country selectedCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: '1001234567',
    displayName: 'Egypt',
    displayNameNoCountryCode: 'Egypt',
    e164Key: '',
  );

  void updateSelectedCountry(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  final List<String> paymentTypes = [
    'Cash on Delivery',
    'Online Payment',
    'Bank Transfer',
  ];

  void selectPayment(String? value) {
    selectedPayment = value;
    notifyListeners();
  }

  String _mapPaymentCode(String? payment) {
    switch (payment) {
      case 'Cash on Delivery':
        return 'CSH';

      case 'Online Payment':
        return 'ONLINE_PAYMENT';

      case 'Bank Transfer':
        return 'BANK_TRANSFER';

      default:
        return 'CSH';
    }
  }

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

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
        zoneId: int.parse(selectedCity!.id),
        subzoneId: int.parse(selectedRegion!.id),
        address: addressController.text.trim(),
        paymentMethodCode: _mapPaymentCode(selectedPayment),
        password: passwordController.text,
        postalCode: '11511',
      );
      if (success) {
        log('REGISTER SUCCESS = true');
        log('NAVIGATOR = ${navigatorKey.currentState}');

        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        log('REGISTER SUCCESS = false');
      }
    } catch (e) {
      log('Register Error: $e');
    } finally {
      isRegistering = false;
      notifyListeners();
    }
  }

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
