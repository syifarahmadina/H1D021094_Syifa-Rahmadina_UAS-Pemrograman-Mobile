import 'package:get/get.dart';
import '../models/transaction_model.dart';
import '../services/storage_service.dart';

class KasirController extends GetxController {
  final storageService = StorageService();

  // Observable list to store products
  var products = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved transactions from storage
    products.addAll(storageService.loadTransactions());
  }

  // Add a product to the list
  void addProduct(String name, double price) {
    if (name.isNotEmpty && price > 0) {
      products.add(TransactionModel(name: name, price: price));
      _saveProducts(); // Save changes to storage
    } else {
      Get.snackbar("Error", "Nama produk atau harga tidak valid.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Edit an existing product
  void editProduct(int index, String newName, double newPrice) {
    if (newName.isNotEmpty && newPrice > 0 && index < products.length) {
      products[index] = TransactionModel(name: newName, price: newPrice);
      _saveProducts(); // Save changes to storage
    } else {
      Get.snackbar("Error", "Nama atau harga tidak valid.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Delete a product from the list
  void deleteProduct(int index) {
    if (index < products.length) {
      products.removeAt(index);
      _saveProducts(); // Save changes to storage
    }
  }

  // Calculate the total price of all products
  double get totalPrice => products.fold(0, (sum, product) => sum + product.price);

  // Complete the transaction
  void completeTransaction() {
    if (products.isNotEmpty) {
      // Save summary data to dashboard
      storageService.saveDashboardData(totalPrice, products.length);

      // Capture the total price before clearing the list
      double finalTotalPrice = totalPrice;

      // Clear products list and save the cleared state to storage
      products.clear();
      _saveProducts(); // Save cleared list to storage

      // Show confirmation dialog with the updated total price
      Get.defaultDialog(
        title: "Transaksi Selesai",
        middleText: "Total Pembayaran: Rp ${finalTotalPrice.toStringAsFixed(2)}",
        textCancel: "Batal",
        textConfirm: "OK",
        onConfirm: () {
          Get.back(); // Close the dialog
        },
      );
    } else {
      Get.snackbar("Peringatan", "Tidak ada produk dalam transaksi.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Private method to save the current products list to storage
  void _saveProducts() {
    storageService.saveTransactions(products);
  }
}
