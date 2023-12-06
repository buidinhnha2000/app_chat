class Money {
  final int price;
  final String unit;

  Money({required this.price, required this.unit});
}

class DiceImage {
  int? price;
  final String image;

  DiceImage({required this.image, this.price});
}
