import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/zone_model.dart';
import '../queries/region_queries.dart';
import '../queries/zone_queries.dart';
import 'graph_config.dart';

class ZoneService {
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

    if (result.isLoading) {
      print("loading");
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
