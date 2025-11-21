// lib/pages/order_summary_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/order_cubit.dart';
import 'checkout_success_page.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Keranjang'),
      ),
      body: BlocBuilder<OrderCubit, List<OrderItem>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(
              child: Text('Keranjang masih kosong'),
            );
          }

          final totalItems =
              state.fold<int>(0, (sum, item) => sum + item.quantity);
          final totalPrice = context.read<OrderCubit>().getTotalPrice();

          return Column(
            children: [
              // Daftar produk di keranjang
              Expanded(
                child: ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    final item = state[index];
                    final itemPrice =
                        item.menu.getDiscountedPrice() * item.quantity;

                    return ListTile(
                      leading: Image.network(
                        item.menu.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported);
                        },
                      ),
                      title: Text(item.menu.name),
                      subtitle: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              final newQty = item.quantity - 1;
                              context
                                  .read<OrderCubit>()
                                  .updateQuantity(item.menu, newQty);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            onPressed: () {
                              final newQty = item.quantity + 1;
                              context
                                  .read<OrderCubit>()
                                  .updateQuantity(item.menu, newQty);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      trailing: Text('Rp $itemPrice'),
                    );
                  },
                ),
              ),

              // Total item & total harga + tombol Checkout
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Total item   : $totalItems'),
                    Text('Total harga : Rp $totalPrice'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<OrderCubit>().clearOrder();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutSuccessPage(),
                          ),
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}