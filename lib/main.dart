import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tp_state_management/cubit/daftar_produk_cubit.dart';
import 'package:tp_state_management/cubit/produk_cubit.dart';
import 'package:tp_state_management/page/home_page.dart';

//model berisi data/state

//cubit untuk acvtivity model

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<produkListCubit>(
            create: (_) => produkListCubit(),
          ),
          BlocProvider<produkCubit>(
            create: (_) => produkCubit(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}