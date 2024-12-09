import 'package:get_storage/get_storage.dart';
import '../models/transaction_model.dart';

class StorageService {
  final _storage = GetStorage();

  // Save Transactions
  void saveTransactions(List<TransactionModel> transactions) {
    List<Map<String, dynamic>> jsonList =
    transactions.map((t) => t.toJson()).toList();
    _storage.write('transactions', jsonList);
  }

  // Load Transactions
  List<TransactionModel> loadTransactions() {
    List<dynamic>? jsonList = _storage.read('transactions');
    if (jsonList != null) {
      return jsonList.map((json) => TransactionModel.fromJson(json)).toList();
    }
    return [];
  }

  // Save Total Sales and Transactions
  void saveDashboardData(double totalSales, int totalTransactions) {
    _storage.write('totalSalesToday', totalSales);
    _storage.write('totalTransactions', totalTransactions);
  }

  // Load Total Sales
  double loadTotalSales() {
    return _storage.read('totalSalesToday') ?? 0.0;
  }

  // Load Total Transactions
  int loadTotalTransactions() {
    return _storage.read('totalTransactions') ?? 0;
  }
}
