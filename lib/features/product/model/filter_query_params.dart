class FilterQueryParams {
  int? pageSize;
  String? searchQuery;
  int? currentPage;
  int? categoryId;
  bool? topRated;
  bool? bestSeller;
  bool? topDeals;

  FilterQueryParams({
    this.pageSize = 20,
    this.searchQuery,
    this.currentPage = 1,
    this.categoryId,
    this.topRated,
    this.bestSeller,
    this.topDeals,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["searchCriteria[pageSize]"] = pageSize.toString();
    map["searchCriteria[currentPage]"] = currentPage.toString();

    if (categoryId != null) map['categoryId'] = categoryId.toString();
    if (topRated != null) map['topRated'] = true;
    if (bestSeller != null) map['bestSeller'] = true;
    if (topDeals != null) map['topDeals'] = true;
    if (searchQuery != null) map['searchQuery'] = searchQuery;

    return map;
  }
}
