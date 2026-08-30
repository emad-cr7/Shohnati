import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sh7naty/features/auth/data/queries/region_queries.dart';
import 'package:sh7naty/features/auth/data/queries/zone_queries.dart';

import '../../../../core/data_source/graphql/graph_config.dart';
import '../models/zone_model.dart';



class RegisterService {
  final GraphQLClient client = GraphConfig.client();

  Future<List<ZoneModel>> getZones() async {
    final result = await client.query(
      QueryOptions(
        document: gql(ZoneQueries.listMainZonesQuery),
      ),
    );

    if (result.hasException) {
      log('GraphQL Error: ${result.exception.toString()}');
      throw Exception(result.exception.toString());
    }

    final data = result.data?['listZonesDropdown'];
    if (data == null) {
      return [];
    }
    return (data as List).map((item) => ZoneModel.fromJson(item)).toList();
  }

  Future<List<ZoneModel>> getRegions(int parentId) async {
    final result = await client.query(
      QueryOptions(
        document: gql(RegionQueries.listSubZonesQuery),
        variables: {'parentId': parentId},
      ),
    );

    if (result.hasException) {
      log('GraphQL Error: ${result.exception.toString()}');
      throw Exception(result.exception.toString());
    }

    final data = result.data?['listZonesDropdown'];
    if (data == null) {
      return [];
    }
    return (data as List).map((item) => ZoneModel.fromJson(item)).toList();
  }
}
