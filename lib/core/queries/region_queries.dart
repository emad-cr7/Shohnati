class  RegionQueries {
  static const String listSubZonesQuery = r'''
  query ListSubZones($parentId: Int!) {
    listZonesDropdown(input: { parentId: $parentId }) {
      id
      name
    }
  }
''';
}