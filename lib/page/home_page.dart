import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tp_state_management/cubit/daftar_produk_cubit.dart';
import 'package:tp_state_management/cubit/produk_cubit.dart';
import 'package:tp_state_management/cubit/produk_state.dart';
import 'dart:developer' as developer;

import 'package:tp_state_management/page/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> 
{
  late TextEditingController _searchController; // Controller untuk input pencarian
  late String _searchQuery = ''; // Variabel untuk menyimpan nilai pencari

  @override
  void initState() 
  {
    super.initState();
    _searchController = TextEditingController(); // Inisialisasi controller
    context.read<produkListCubit>().fetchData();
  }

   @override
  void dispose() 
  {
    _searchController.dispose(); // Hapus controller saat widget di dispose
    super.dispose();
  }

  // Metode untuk memfilter daftar produk berdasarkan nilai pencarian
  List<produkModel> _filterProdukList(List<produkModel> produkList) 
  {
    if (_searchQuery.isEmpty) 
    {
      return produkList; // Jika pencarian kosong, tampilkan semua produk
    } else 
    {
      return produkList
          .where((produk) =>
              produk.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList(); // Filter produk berdasarkan nama
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: Scaffold
      (
        appBar: AppBar
        (
          backgroundColor: Colors.black,
          elevation: 0,
          flexibleSpace: Padding
          (
            padding: const EdgeInsets.all(10.0), 
            child: TextField
            (
              controller: _searchController, // Tambahkan controller ke input pencarian
              onChanged: (value) 
              {
                setState(() 
                {
                  _searchQuery = value; // Set nilai pencarian saat input berubah
                });
              },

              cursorColor: Colors.white,
              style: const TextStyle
              (
                color: Colors.white,
              ),
              decoration: const InputDecoration
              (
                prefixIcon: Icon(Icons.search, color: Colors.white,),
                hintText: "Cari di Jason Consign",
                hintStyle: TextStyle
                (
                  color: Colors.white,
                ),
                border: OutlineInputBorder
                (
                  borderSide: BorderSide
                  (
                    color: Colors.white
                  ),
                ),
                focusedBorder: OutlineInputBorder
                ( // Mengubah warna border ketika dalam fokus
                  borderSide: BorderSide
                  (
                    color: Colors.white, // Ubah warna sesuai yang diinginkan
                  ),
                ),

                filled: true,
                fillColor: Color.fromARGB(255, 36, 36, 36),
                contentPadding: EdgeInsets.symmetric(vertical:10.0),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView
        (
          child: Padding
          (
            padding: const EdgeInsets.all(8.0),
            child: Column
            (
              children: 
              [
                BlocBuilder<produkListCubit, List<produkModel>>
                (
                  buildWhen: (previousState, state) 
                  {
                    developer.log
                    (
                        '${previousState[0].name}->${state[0].name}',
                        name: 'log'
                    );
                    return true;
                  }, 
                  builder: (context, produkList) 
                  {
                    final filteredProdukList = _filterProdukList(produkList); // Filter daftar produk
                    return Container
                    (

                      height: 0.9 * MediaQuery.of(context).size.height,
                      child: GridView.count
                      (
                        crossAxisCount: 2,
                        childAspectRatio: 0.55,
                        children: filteredProdukList.map((produk) 
                        {
                          // Format harga ke format mata uang Rupiah
                          final hargaFormatted = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(produk.price);
                          return Padding
                          (
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector
                            (
                              onTap: () 
                              {
                                Navigator.of(context).push
                                (
                                  MaterialPageRoute(builder: (context) 
                                  {
                                    context
                                        .read<produkCubit>()
                                        .fetchData(produk.id);
                                    return DetailProdukPage();
                                  }),
                                );
                              },
                              child: Container
                              ( 
                                // height: 100,
                                decoration: BoxDecoration
                                (
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: 
                                  [
                                    BoxShadow
                                    (
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column
                                (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: 
                                  [
                                    ClipRRect
                                    (
                                      borderRadius: const BorderRadius.only
                                      (
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                      ),
                                      child: Image.asset
                                      (
                                        'images/${produk.image}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding
                                    (
                                      padding: const EdgeInsets.all(7.0),
                                      child: Column
                                      (
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: 
                                        [
                                          Text
                                          (
                                            produk.name,
                                            style: const TextStyle
                                            (
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text
                                          (
                                            hargaFormatted,
                                          ),
                                          const SizedBox(height: 4),
                                          Text
                                          (
                                            produk.location,
                                            style: const TextStyle
                                            (
                                              color: Colors.grey
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Builder
                                          (
                                            builder: (context) 
                                            {
                                              var colorCondition;
                                              if (produk.condition == "Brand New In Box" || produk.condition == "Brand New Open Box" ) 
                                              {
                                                colorCondition = Colors.indigoAccent;
                                              } 
                                              else if(produk.condition == "Very Good Condition" || produk.condition == "Good Condition")
                                              {
                                                colorCondition = Colors.green[300];
                                              }
                                              else
                                              {
                                                colorCondition = Colors.orange[400];
                                              }
                                              return Container
                                              (
                                                decoration: BoxDecoration
                                                (
                                                  color: Colors.transparent,
                                                  border: Border.all(color: colorCondition, width: 1.5)
                                                ),
                                                child: Padding
                                                (
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Row
                                                  (
                                                    children: 
                                                    [
                                                      Icon(Icons.check_circle, color: colorCondition,),
                                                      const SizedBox(width: 3,),
                                                      Text
                                                      (
                                                        produk.condition,
                                                        style: TextStyle
                                                        (
                                                          color: colorCondition,
                                                          fontSize: 12
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                          
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}