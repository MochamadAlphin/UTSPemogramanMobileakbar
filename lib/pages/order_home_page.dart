// lib/pages/order_home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/order_cubit.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';
import 'category_stack_page.dart';
import 'order_summary_page.dart';

class OrderHomePage extends StatelessWidget {
  const OrderHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffaf7f4), // Warna soft cream modern

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black12,
        title: const Text(
          "Kasir Warung Makan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        actions: [
          BlocBuilder<OrderCubit, List<OrderItem>>(
            builder: (context, state) {
              final totalItems =
                  state.fold<int>(0, (sum, item) => sum + item.quantity);

              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OrderSummaryPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    if (totalItems > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                          ),
                          child: Text(
                            '$totalItems',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      // ========================= BODY =========================
      body: Column(
        children: [
          // Banner kategori
          SizedBox(
            height: 140, // Tinggi ideal supaya category stack rapi
            child: CategoryStackPage(menus: dummyMenus),
          ),

          const SizedBox(height: 8),

          // List menu berdasarkan kategori
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                color: Color(0xfffaf7f4),
              ),
              child: BlocBuilder<CategoryCubit, String>(
                builder: (context, selectedCategory) {
                  final filteredMenus = dummyMenus
                      .where((menu) => menu.category == selectedCategory)
                      .toList();

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: filteredMenus.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      return MenuCard(menu: filteredMenus[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
