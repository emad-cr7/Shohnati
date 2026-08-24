import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../core/graphL/graph_config.dart';
import '../../../core/queries/zone_queries.dart';

class RegisterController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
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

  // بيتملى من الـ API بدل ما يكون هاردكودد
  List<Map<String, dynamic>> zones = [];

  bool isLoadingZones = false;

  final List<String> regions = ['Nasr City', 'Maadi', 'New Cairo', 'Dokki'];
  final List<String> paymentTypes = ['Cash on Delivery', 'Online Payment', 'Bank Transfer',];

  RegisterController() {
    fetchZones();
  }

  List<String> get zoneNames => zones.map((z) => z['name'] as String).toList();

  Future<void> fetchZones() async {
    isLoadingZones = true;
    notifyListeners();

    final client = GraphConfig.client();
    final result = await client.query(
      QueryOptions(document: gql(ZoneQueries.listMainZonesQuery)),
    );

    if (!result.hasException) {
      final data = result.data?['listZonesDropdown'] as List<dynamic>? ?? [];
      zones = data
          .map((e) => {'id': e['id'], 'name': e['name']})
          .toList();
    } else {
      print(result.exception.toString());
    }

    isLoadingZones = false;
    notifyListeners();
  }

  int? get selectedZoneId {
    final match = zones.where((z) => z['name'] == selectedCity);
    return match.isEmpty ? null : match.first['id'] as int?;
  }

  void togglePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> register() async {
    if (key.currentState!.validate()) {
      print("don");
    }
  }

  @override
  void dispose() {
    storeNameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    postalCodeController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}