import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/zone_model.dart';
import '../queries/zone_queries.dart';
import 'graph_config.dart';

class ZoneService {
  static Future<List<ZoneModel>> getMainZones() async {
    final client = GraphConfig.client();

    final result = await client.query(
      QueryOptions(
        document: gql(ZoneQueries.listMainZonesQuery),
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data?['listZonesDropdown'];

    if (data == null) {
      return [];
    }

    return (data as List)
        .map((item) => ZoneModel.fromJson(item))
        .toList();
  }
}