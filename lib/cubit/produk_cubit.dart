
import 'package:tp_state_management/cubit/produk_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class produkCubit extends Cubit<produkModel> {
  String url = "http://127.0.0.1:8000/detail_produk/";
  produkCubit()
      : super(produkModel(
            id: "",
            name: "",
            category: "",
            location: "",
            price: 0,
            condition: "",
            publish_date: ""
            ));

  //map dari json ke atribut
  void setFromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String name = json['name'];
    String category = json['category'];
    String location = json['location'];
    int price = json['price'];
    String condition = json['condition'];
    String publish_date = json['publish_date'];
//emit state baru, ini berbeda dgn provider!
    emit(produkModel(
        id: id,
        name: name,
        category: category,
        location: location,
        price: price,
        condition: condition,
        publish_date: publish_date
        ));
  }

  void fetchData(String id) async {
    final response = await http.get(Uri.parse(url + id));
    if (response.statusCode == 200) {
      //sukses
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
