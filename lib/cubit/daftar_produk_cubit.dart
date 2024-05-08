import 'package:tp_state_management/cubit/produk_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class produkListCubit extends Cubit<List<produkModel>> {
  String url = "http://127.0.0.1:8000/daftar_produk";
  produkListCubit()
      : super([
          produkModel(
              id: "",
              name: "",
              category: "",
              location: "",
              price: 0,
              condition: "",
              publish_date: "",
              image: "",
              )
        ]);

  //map dari json ke atribut
  void setFromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];
    List<produkModel> umkmList = data
        .map((e) => produkModel(
            id: e['id'],
            name: e['name'],
            category: e['category'],
            location: e['location'],
            price: e['price'],
            condition: e['condition'],
            publish_date: e['publish_date'],
            image: e['image']
            ))
        .toList();
    emit(umkmList);
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //sukses
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}