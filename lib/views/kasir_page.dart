import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kasir_controller.dart';

class KasirPage extends StatelessWidget {
  final KasirController controller = Get.put(KasirController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kasir Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Input Section
            Text(
              "Masukkan Produk",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 20),

            // Product Name Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[50],
              ),
            ),
            SizedBox(height: 10),

            // Product Price Field
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Harga Produk",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[50],
              ),
            ),
            SizedBox(height: 20),

            // Add Product Button
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                double price = double.tryParse(priceController.text) ?? 0;
                if (name.isNotEmpty && price > 0) {
                  controller.addProduct(name, price);
                  nameController.clear();
                  priceController.clear();
                } else {
                  Get.snackbar("Error", "Nama produk atau harga tidak valid.",
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: Text(
                "Tambah",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),

            // Product List
            Expanded(
              child: Obx(() {
                if (controller.products.isEmpty) {
                  return Center(child: Text("Belum ada produk"));
                }
                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    var product = controller.products[index];
                    return Card(
                      color: Colors.blue[50],
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text("Rp ${product.price}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit Button
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.pinkAccent),
                              onPressed: () {
                                nameController.text = product.name;
                                priceController.text = product.price.toString();
                                Get.defaultDialog(
                                  title: "Edit Produk",
                                  content: Column(
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          labelText: "Nama Produk",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextField(
                                        controller: priceController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: "Harga Produk",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  textCancel: "Batal",
                                  textConfirm: "Simpan",
                                  onConfirm: () {
                                    double newPrice = double.tryParse(priceController.text) ?? 0;
                                    if (nameController.text.isNotEmpty && newPrice > 0) {
                                      controller.editProduct(index, nameController.text, newPrice);
                                      Get.back();
                                    }
                                  },
                                );
                              },
                            ),
                            // Delete Button
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                controller.deleteProduct(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // Total Price Display
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Total: Rp ${controller.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              );
            }),

            // Complete Transaction Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.totalPrice > 0) {
                    controller.completeTransaction();
                  } else {
                    Get.snackbar(
                      "Peringatan",
                      "Total pembayaran tidak boleh 0.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: Text(
                  "Selesaikan Transaksi",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
