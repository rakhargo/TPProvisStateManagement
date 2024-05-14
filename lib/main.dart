import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/daftar_produk.dart';
import 'provider/produk_detail.dart';
import 'page/home_page.dart';

//model berisi data/state

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProdukList()),
        ChangeNotifierProvider(create: (_) => ProdukDetail()),
      ],
      child: const HomePage(),
    ),
  );
}