import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_state_management/provider/produk_state.dart';
import 'package:tp_state_management/provider/produk_detail.dart';

class DetailProdukPage extends StatelessWidget {
  const DetailProdukPage({super.key, required this.id});
  final String id; // Add a constructor parameter for the ID
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProdukDetail(),
        child: Consumer<ProdukDetail>(
          builder: (context, produkDetail, child) {
            produkDetail.fetchData(id); // Call fetchData here
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            'Nama: ${produkDetail.produk?.first.name?? ''}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Kategori: ${produkDetail.produk?.first.category?? ''}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Lokasi: ${produkDetail.produk?.first.location?? ''}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Harga: ${produkDetail.produk?.first.price?? ''} ',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Kondisi: ${produkDetail.produk?.first.condition?? ''}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Tanggal Publish: ${produkDetail.produk?.first.publish_date?? ''}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}