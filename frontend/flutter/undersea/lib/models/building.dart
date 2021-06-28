class Building {
  String name;
  String effect1;
  String? effect2;
  String imageName;
  int currentAmount;
  int price;
  int? availableIn;

  bool isInProgress;

  bool isAvailable;

  Building(
      {required this.imageName,
      required this.name,
      required this.effect1,
      this.effect2,
      required this.currentAmount,
      required this.price,
      this.availableIn,
      required this.isInProgress,
      required this.isAvailable});
}
