class produkModel {
  String id;
  String name;
  String category;
  String location;
  int price;
  String condition;
  String publish_date;
  String image;

  produkModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.location,
      required this.price,
      required this.condition,
      required this.publish_date,
      required this.image
      }); //constructor
}