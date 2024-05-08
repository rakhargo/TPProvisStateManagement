import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_state_management/cubit/daftar_produk_cubit.dart';
import 'package:tp_state_management/cubit/produk_cubit.dart';
import 'package:tp_state_management/cubit/produk_state.dart';
import 'dart:developer' as developer;

import 'package:tp_state_management/page/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
          foregroundColor: Colors.blue,
          title: Text
          (
            'My App',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea
        (
          child: Padding
          (
            padding: const EdgeInsets.all(8.0),
            child: ListView
            (
              children: 
              [
                Column
                (
                  children: 
                  [
                    // Text
                    // (
                    //     'NIM 1, NAMA 1; NIM 2, NAMA 2; Saya berjanji tidak akan berbuat curang data atau membantu orang lain berbuat curang'),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    ElevatedButton
                    (
                      onPressed: () 
                      {
                        context.read<produkListCubit>().fetchData();
                      },
                      child: Text('Reload Daftar Produk'),
                    ),
                    SizedBox
                    (
                      height: 20.0,
                    ),
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
                        return Container
                        (
                          height: 750,
                          child: ListView.builder
                          (
                            itemCount: produkList.length,
                            itemBuilder: (context, index) 
                            {
                              if (produkList[0].name != "") 
                              {
                                return ListTile
                                (
                                    leading: Image.asset
                                    (
                                      'images/${produkList[index].image}'
                                    ),
                                    title: Text(produkList[index].name),
                                    subtitle: Text(produkList[index].category),
                                    trailing: Icon(Icons.more_vert_rounded),
                                    onTap: () 
                                    {
                                      Navigator.of(context).push
                                      (
                                        MaterialPageRoute(builder: (context) 
                                        {
                                          context
                                          .read<produkCubit>()
                                          .fetchData(produkList[index].id);
                                        return DetailProdukPage();
                                      }));
                                    });
                              }
                            },
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}