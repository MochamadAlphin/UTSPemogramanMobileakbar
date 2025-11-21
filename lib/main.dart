// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/order_cubit.dart';
import 'models/menu_model.dart';
import 'pages/order_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // kategori awal pakai kategori item pertama
    final initialCategory = dummyMenus.first.category;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OrderCubit(),
        ),
        BlocProvider(
          create: (_) => CategoryCubit(initialCategory),
        ),
      ],
      child: MaterialApp(
        title: 'UTS Kasir Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.deepOrange,
          useMaterial3: true,
        ),
        home: const OrderHomePage(),
      ),
    );
  }
}
