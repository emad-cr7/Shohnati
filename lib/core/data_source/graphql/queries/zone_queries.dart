class ZoneQueries {
  static const String listMainZonesQuery = r'''
  query ListMainZones {
    listZonesDropdown(input: {}) {
      id
      name
    }
  }
''';
}
