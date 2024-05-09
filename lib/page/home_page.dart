import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_state_management/provider/daftar_produk.dart';
import 'package:tp_state_management/provider/produk_detail.dart';
import 'package:tp_state_management/page/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ProdukList>(
                builder: (context, produkt, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            produkt.fetchData();
                          },
                          child: const Text("Reload Page"),
                        ),
                      ),
                      produkt.produkList.isEmpty
                          ? const Text("No data")
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: produkt.produkList.length,
                              itemBuilder: (context, index) {
                                final produk = produkt.produkList[index];
                                return ListTile(
                                    title: Text(produk.name),
                                    subtitle: Text("Jenis: ${produk.category}"),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => DetailProdukPage(

                                    id: produk.id)));
                                    });
                              },
                            ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
