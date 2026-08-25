import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  String? selectedCity;
  String? selectedRegion;
  String? selectedPayment;

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

  final List<String> cities = ['Cairo', 'Giza', 'Alexandria', 'Qalyubia'];
  final List<String> regions = ['Nasr City', 'Maadi', 'New Cairo', 'Dokki'];
  final List<String> paymentTypes = ['Cash on Delivery', 'Online Payment',
    'Bank Transfer',
  ];

  void selectCity(String? value) {
    selectedCity = value;
    notifyListeners();
  }

  void selectRegion(String? value) {
    selectedRegion = value;
    notifyListeners();
  }

  void selectPayment(String? value) {
    selectedPayment = value;
    notifyListeners();
  }

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> register() async {
    if (key.currentState!.validate()) {

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
