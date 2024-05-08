import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_state_management/cubit/produk_cubit.dart';
import 'package:tp_state_management/cubit/produk_state.dart';
import 'dart:developer' as developer;

class DetailProdukPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            BlocBuilder<produkCubit, produkModel>(
                buildWhen: (previousState, state) {
              developer.log('${previousState.name}->${state.name}',
                  name: 'log');
              return true;
            }, builder: (context, produkDetail) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'Nama: ${produkDetail.name}',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Kategori: ${produkDetail.category}',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text("Lokasi: ${produkDetail.location}",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Harga: ${produkDetail.price} ',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Kondisi: ${produkDetail.condition}',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Tanggal Publish: ${produkDetail.publish_date}',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ));
  }
}