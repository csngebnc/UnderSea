class Soldier {
  int totalAmount;
  int attack;
  int defence;
  int payment;
  int supplyNeeds;
  int price;
  int available;

  String name;
  String iconName;

  String attackDefence() {
    return '$attack/$defence';
  }

  Soldier(
      {required this.totalAmount,
      required this.attack,
      required this.defence,
      required this.payment,
      required this.supplyNeeds,
      required this.name,
      required this.price,
      required this.iconName,
      required this.available});
}
