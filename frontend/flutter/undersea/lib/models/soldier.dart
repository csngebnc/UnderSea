class Soldier {
  int amount;
  int attack;
  int defence;
  int payment;
  int supplyNeeds;
  int price;

  String name;
  String iconName;

  String attackDefence() {
    return '$attack/$defence';
  }

  Soldier(
      {required this.amount,
      required this.attack,
      required this.defence,
      required this.payment,
      required this.supplyNeeds,
      required this.name,
      required this.price,
      required this.iconName});
}
