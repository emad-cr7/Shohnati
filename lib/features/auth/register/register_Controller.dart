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
  ZoneModel? selectedRegion;

  String? selectedPayment;
  bool isZonesLoading = false;
  bool isRegionsLoading = false;


  init() {
    fetchZones();
  }

  final ZoneService zoneService = ZoneService();
  List<ZoneModel> zones = [];
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
      regions = await zoneService.getRegions(int.parse(selectedCity!.id));
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
