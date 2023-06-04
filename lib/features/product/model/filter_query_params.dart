class FilterQueryParams {
  int? pageSize;
  int? searchQuery;
  int? currentPage;
  int? categoryId;
  bool? topRated;
  bool? bestSeller;
  bool? topDeals;
  String? sku;

  FilterQueryParams(
      {this.pageSize = 20,
      this.searchQuery,
      this.currentPage = 1,
      this.categoryId,
      this.topRated,
      this.bestSeller,
      this.topDeals,
      this.sku});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["searchCriteria[pageSize]"] = pageSize.toString();
    map["searchCriteria[currentPage]"] = currentPage.toString();

    if (categoryId != null) map['categoryId'] = categoryId.toString();
    if (topRated != null) map['topRated'] = true;
    if (bestSeller != null) map['bestSeller'] = true;
    if (topDeals != null) map['topDeals'] = true;
    if (sku != null) map['sku'] = sku.toString();

    return map;
  }
}
