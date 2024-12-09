import 'package:get/get.dart';
import '../views/login_page.dart';
import '../views/dashboard_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/dashboard', page: () => DashboardPage()),
  ];
}
