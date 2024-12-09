import 'package:get/get.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var usernameError = ''.obs;
  var passwordError = ''.obs;


  void validateInput() {

    usernameError.value = '';
    passwordError.value = '';

    if (username.value.isEmpty) {
      usernameError.value = "Username Harus diisi";
    }
    if (password.value.isEmpty) {
      passwordError.value = "Password Harus diisi";
    }
  }

  void login() {
    validateInput();

    if (usernameError.value.isEmpty && passwordError.value.isEmpty) {
      if (username.value == "saythename" && password.value == "seventeen") {
        Get.offNamed('/dashboard');
      } else {
        Get.snackbar("Login Gagal", "Username atau Password salah", snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
