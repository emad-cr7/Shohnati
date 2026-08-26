import 'package:graphql_flutter/graphql_flutter.dart';

class GraphConfig {
  static const String _endpoint =
      'https://logistics.accuratess.dev:8443/graphql';

  static GraphQLClient client() {
    final HttpLink httpLink = HttpLink(_endpoint);
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
        dataIdFromObject: (object) => null,
      ),
    );
  }
}