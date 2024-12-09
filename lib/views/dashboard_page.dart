import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/sidebar_widget.dart';
import '../widgets/summary_card.dart';


class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: !isWideScreen
          ? SidebarWidget(
        onNavigateToKasir: () => Get.toNamed('/kasir'),
        onLogout: () => Get.offAllNamed('/login'),
      )
          : null,
      appBar: !isWideScreen
          ? AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Dashboard"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      )
          : null,
      body: Row(
        children: [
          // Sidebar for wide screens
          if (isWideScreen)
            SidebarWidget(
              onNavigateToKasir: () => Get.toNamed('/kasir'),
              onLogout: () => Get.offAllNamed('/login'),
            ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sales Summary Section
                    Row(
                      mainAxisAlignment: isWideScreen
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Obx(() {
                            return SummaryCard(
                              title: "Total Penjualan Hari Ini",
                              value:
                              "Rp ${controller.totalSalesToday.value.toStringAsFixed(2)}",
                              icon: Icons.attach_money,
                              color: Colors.pinkAccent,
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() {
                            return SummaryCard(
                              title: "Jumlah Transaksi",
                              value:
                              "${controller.totalTransactions.value}",
                              icon: Icons.receipt,
                              color: Colors.blueAccent,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Transaction Details Chart
                    Text(
                      "Detail Transaksi",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Simplified and Readable Bar Chart
                    AspectRatio(
                      aspectRatio: isWideScreen ? 1.6 : 1,
                      child: Obx(() {
                        return BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceEvenly,
                            gridData: FlGridData(
                              drawHorizontalLine: true,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: Colors.grey.shade300,
                                strokeWidth: 0.8,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(color: Colors.blueAccent),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 32,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text(
                                          "Total Penjualan",
                                          style: TextStyle(
                                              color: Colors.pinkAccent),
                                        );
                                      case 1:
                                        return Text(
                                          "Rata-Rata Transaksi",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        );
                                      case 2:
                                        return Text(
                                          "Transaksi",
                                          style: TextStyle(
                                              color: Colors.greenAccent),
                                        );
                                      default:
                                        return Text("");
                                    }
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: [
                              BarChartGroupData(
                                x: 0,
                                barRods: [
                                  BarChartRodData(
                                    toY: controller.totalSalesToday.value,
                                    width: 24,
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.pinkAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(
                                    toY: controller.averageTransactionAmount,
                                    width: 24,
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(
                                    toY: controller.totalTransactions.value
                                        .toDouble(),
                                    width: 24,
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
