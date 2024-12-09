import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'views/kasir_page.dart';
import 'views/dashboard_page.dart';
import 'views/login_page.dart';

void main() async {
  await GetStorage.init();  // Initialize GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Point of Sale',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/kasir', page: () => KasirPage()),
      ],
    );
  }
}
