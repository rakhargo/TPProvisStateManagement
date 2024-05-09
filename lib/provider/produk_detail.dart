import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tp_state_management/provider/produk_state.dart';

class ProdukDetail with ChangeNotifier {
  String url = "http://127.0.0.1:8000/detail_produk/";
  dynamic _produk;
  dynamic get produk => _produk;

  dynamic setFromJson(Map<String, dynamic> json) {
    _produk = [
      Produk(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        location: json['location'],
        price: json['price'],
        condition: json['condition'],
        publish_date: json['publish_date'],
        image: json['image'],
      )
    ];
    notifyListeners();

    return produk;
  }

  Future fetchData(String id) async {
    final response = await http.get(Uri.parse(url + id));
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
