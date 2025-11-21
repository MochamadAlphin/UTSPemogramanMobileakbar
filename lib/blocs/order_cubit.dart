// lib/blocs/order_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';

/// Item dalam pesanan (menu + quantity)
class OrderItem {
  final MenuModel menu;
  final int quantity;

  OrderItem({required this.menu, required this.quantity});

  OrderItem copyWith({MenuModel? menu, int? quantity}) {
    return OrderItem(
      menu: menu ?? this.menu,
      quantity: quantity ?? this.quantity,
    );
  }
}

/// Cubit untuk mengelola pesanan
class OrderCubit extends Cubit<List<OrderItem>> {
  OrderCubit() : super([]);

  /// Tambah 1 ke pesanan
  void addToOrder(MenuModel menu) {
    final current = List<OrderItem>.from(state);
    final index = current.indexWhere((item) => item.menu.id == menu.id);

    if (index >= 0) {
      final existing = current[index];
      current[index] =
          existing.copyWith(quantity: existing.quantity + 1);
    } else {
      current.add(OrderItem(menu: menu, quantity: 1));
    }

    emit(current);
  }

  /// Hapus item dari pesanan
  void removeFromOrder(MenuModel menu) {
    final current = List<OrderItem>.from(state)
      ..removeWhere((item) => item.menu.id == menu.id);
    emit(current);
  }

  /// Update jumlah item (qty<=0 berarti dihapus)
  void updateQuantity(MenuModel menu, int qty) {
    final current = List<OrderItem>.from(state);
    final index = current.indexWhere((item) => item.menu.id == menu.id);

    if (index == -1) return;

    if (qty <= 0) {
      current.removeAt(index);
    } else {
      current[index] = current[index].copyWith(quantity: qty);
    }

    emit(current);
  }

  /// Total harga setelah diskon *per item*
  int getTotalPrice() {
    int total = 0;
    for (final item in state) {
      total += item.menu.getDiscountedPrice() * item.quantity;
    }
    return total;
  }

  /// Hapus semua pesanan
  void clearOrder() {
    emit([]);
  }
}

/// Cubit untuk kategori aktif di tampilan Stack
class CategoryCubit extends Cubit<String> {
  CategoryCubit(String initialCategory) : super(initialCategory);

  void changeCategory(String category) => emit(category);
}
