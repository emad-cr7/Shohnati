import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../core/graphL/zone_service.dart';
import '../../../core/model/zone_model.dart';

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
  String? selectedRegion;
  String? selectedPayment;
  bool isZonesLoading = false;

  init() {
    fetchZones();
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
  final ZoneService zoneService = ZoneService();
  List<ZoneModel> zones = [];

  List<String> get zoneNames => zones.map((zone) => zone.name).toList();

  Future<void> fetchZones() async {
    isZonesLoading = true;
    notifyListeners();
    try {
      zones = await zoneService.getZones();
    } catch (e) {
      log('Error fetching zones: $e');
    } finally {
      isZonesLoading = false;
      notifyListeners();
    }
  }

  void selectCity(ZoneModel? value) {
    selectedCity = value;
    notifyListeners();
  }

  final List<String> regions = ['Nasr City', 'Maadi', 'New Cairo', 'Dokki'];
  final List<String> paymentTypes = [
    'Cash on Delivery',
    'Online Payment',
    'Bank Transfer',
  ];

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
    if (key.currentState!.validate()) {}
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
