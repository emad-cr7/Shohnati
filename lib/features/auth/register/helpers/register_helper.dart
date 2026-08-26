import 'package:country_picker/country_picker.dart';

class RegisterHelper {
  static String mapPaymentCode(String? payment) {
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

  final country = Country(
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

  final List<String> paymentTypes = [
    'Cash on Delivery',
    'Online Payment',
    'Bank Transfer',
  ];
}