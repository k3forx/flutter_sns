class CoffeeBean {
  int id;
  String name;
  String farmName;
  String country;
  String roastDegree;
  DateTime? roastedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  CoffeeBean({
    this.id = 0,
    this.name = "",
    this.farmName = "",
    this.country = "",
    this.roastDegree = "",
    this.roastedAt,
    this.createdAt,
    this.updatedAt,
  });
}
