class RegionView {
  String regionName;
  int views;

  RegionView({
    required this.regionName,
    required this.views,
  });

  factory RegionView.fromJson(Map<String, dynamic> json) {
    final String regionName = json['region'] ?? "Unknown";
    final int views = json['numberOfViews'] ?? 0;

    // Handle the case where views is missing or negative
    final int validViews = views >= 0 ? views : 0;

    return RegionView(
      regionName: regionName,
      views: validViews,
    );
  }

  static List<RegionView> regionsViewsFromJsonList(List<dynamic> parsedJson) {
    List<RegionView> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(RegionView.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
