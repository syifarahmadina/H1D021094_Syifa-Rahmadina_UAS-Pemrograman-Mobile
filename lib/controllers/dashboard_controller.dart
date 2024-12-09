import 'package:flutter/material.dart'; // Import this to use Colors and BorderRadius
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/storage_service.dart';

class DashboardController extends GetxController {
  final storageService = StorageService();

  // Observable variables for total sales and transactions
  var totalSalesToday = 0.0.obs;
  var totalTransactions = 0.obs;

  // On init, load data from storage
  @override
  void onInit() {
    super.onInit();
    totalSalesToday.value = storageService.loadTotalSales();
    totalTransactions.value = storageService.loadTotalTransactions();
  }

  // Calculate average transaction amount
  double get averageTransactionAmount {
    if (totalTransactions.value > 0) {
      return totalSalesToday.value / totalTransactions.value;
    }
    return 0.0;
  }

  // Data for the simple chart
  List<BarChartGroupData> get barChartData {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: totalSalesToday.value,
            color: Colors.pinkAccent,
            width: 20,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: averageTransactionAmount,
            color: Colors.blueAccent,
            width: 20,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: totalTransactions.value.toDouble(),
            color: Colors.greenAccent,
            width: 20,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
    ];
  }
}
