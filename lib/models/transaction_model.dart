class TransactionModel {
  String name;
  double price;

  TransactionModel({required this.name, required this.price});

  // Convert TransactionModel to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
  };

  // Convert JSON to TransactionModel
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      name: json['name'],
      price: json['price'],
    );
  }
}
