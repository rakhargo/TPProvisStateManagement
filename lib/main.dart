import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_state_management/provider/daftar_produk.dart';
import 'package:tp_state_management/provider/produk_detail.dart';
import 'package:tp_state_management/page/home_page.dart';

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