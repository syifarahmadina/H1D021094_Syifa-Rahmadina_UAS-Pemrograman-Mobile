import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final VoidCallback onNavigateToKasir;
  final VoidCallback onLogout;

  const SidebarWidget({
    Key? key,
    required this.onNavigateToKasir,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 800;

    return isWideScreen
        ? Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: buildSidebarContent(),
    )
        : Drawer(
      child: buildSidebarContent(),
    );
  }

  Widget buildSidebarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo or Title
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Point of Sale",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        Divider(color: Colors.blueAccent, thickness: 1),

        // Menu Items
        ListTile(
          leading: Icon(Icons.dashboard, color: Colors.pinkAccent),
          title: Text("Dashboard", style: TextStyle(color: Colors.blueAccent)),
          onTap: () {}, // Stay on Dashboard
        ),
        ListTile(
          leading: Icon(Icons.store, color: Colors.pinkAccent),
          title: Text("Kasir", style: TextStyle(color: Colors.blueAccent)),
          onTap: onNavigateToKasir,
        ),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.pinkAccent),
          title: Text("Logout", style: TextStyle(color: Colors.blueAccent)),
          onTap: onLogout,
        ),
      ],
    );
  }
}
