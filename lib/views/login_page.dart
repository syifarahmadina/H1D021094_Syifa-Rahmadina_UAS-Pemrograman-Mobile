import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows the gradient background to extend behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity, // Ensures the container takes full width
        height: double.infinity, // Ensures the container takes full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Selamat datang di Aplikasi Point of Sale",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Username Field
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) => controller.username.value = value,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.pinkAccent),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person, color: Colors.pinkAccent),
                        ),
                      ),
                      Obx(() {
                        // Show error message for username if it exists
                        return controller.usernameError.value.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            controller.usernameError.value,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )
                            : SizedBox.shrink(); // Return an empty box if no error
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        obscureText: true,
                        onChanged: (value) => controller.password.value = value,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.pinkAccent),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock, color: Colors.pinkAccent),
                        ),
                      ),
                      Obx(() {
                        // Show error message for password if it exists
                        return controller.passwordError.value.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            controller.passwordError.value,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )
                            : SizedBox.shrink(); // Return an empty box if no error
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button with animation
                ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
