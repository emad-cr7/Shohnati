import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../core/graphql/graph_config.dart';
import '../queries/auth_queries.dart';

class AuthService {
  final GraphQLClient client = GraphConfig.client();

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
    log('POSTAL CODE: $postalCode');
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
      log('Register Error: ${result.exception.toString()}');
      throw Exception(result.exception.toString());
    }

    return result.data?['register'] ?? false;
  }
}