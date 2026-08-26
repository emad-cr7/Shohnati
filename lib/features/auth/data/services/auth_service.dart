import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../core/graphql/graph_config.dart';
import '../queries/auth_queries.dart';

class AuthService {
  final GraphQLClient client = GraphConfig.client();


  Future<Map<String, dynamic>?> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(AuthQueries.loginMutation),
        variables: {
          'username': username,
          'password': password,
          'rememberMe': rememberMe,
        },
      ),
    );

    if (result.hasException) {
      final errors = result.exception?.graphqlErrors;

      final message = errors != null && errors.isNotEmpty
          ? errors.first.message
          : 'حدث خطأ أثناء تسجيل الدخول';

      log('Login Error: $message');

      throw Exception(message);
    }

    return result.data?['login'];
  }


  Future<bool> register({
    required String businessName,
    required String name,
    required String email,
    required String mobile,
    required int zoneId,
    required int subzoneId,
    required String address,
    required String postalCode,
    required String paymentMethodCode,
    required String password,
  }) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(AuthQueries.registerMutation),
        variables: {
          'businessName': businessName,
          'name': name,
          'email': email,
          'mobile': mobile,
          'zoneId': zoneId,
          'subzoneId': subzoneId,
          'address': address,
          'postalCode': postalCode,
          'paymentMethodCode': paymentMethodCode,
          'customerTypeCode': 'INDIVIDUAL',
          'password': password,
        },
      ),
    );
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    return result.data?['register'] ?? false;
  }


  Future<Map<String, dynamic>?> verifyRegistrationEmail({
    required String email,
    required String code,
    String? fcmToken,
  }) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(AuthQueries.verifyEmailMutation),
        variables: {'email': email, 'code': code, 'fcmToken': fcmToken},
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    return result.data?['verifyRegistrationEmail'];
  }

  Future<bool> resendVerificationCode(String email) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(AuthQueries.resendCodeMutation),
        variables: {'email': email},
      ),
    );

    if (result.hasException) {
      log('Resend Code Error: ${result.exception.toString()}');
      throw Exception(result.exception.toString());
    }
    return result.data?['resendVerificationCode'] ?? false;
  }
}
