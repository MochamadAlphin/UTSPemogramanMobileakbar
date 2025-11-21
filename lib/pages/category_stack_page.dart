import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import '../models/menu_model.dart';

class CategoryStackPage extends StatelessWidget {
  final List<MenuModel> menus;

  const CategoryStackPage({
    Key? key,
    required this.menus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = menus.map((e) => e.category).toSet().toList();

    return Stack(
      children: [
        // Background biru soft agar teks gelap terlihat jelas
        Container(
          height: 120,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff90CAF9), // soft light blue
                Color(0xff64B5F6), // medium soft blue
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          left: 16,
          right: 16,
          top: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kategori Menu",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0D47A1), // navy blue
                ),
              ),
              const SizedBox(height: 12),

              BlocBuilder<CategoryCubit, String>(
                builder: (context, selectedCategory) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final bool selected = (selectedCategory == cat);

                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            // Label kategori (TIDAK PUTIH)
                            label: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                    selected ? FontWeight.bold : FontWeight.w500,
                                color: selected
                                    ? const Color(0xff0D47A1) // navy (aktif)
                                    : Colors.black87, // abu gelap (tidak aktif)
                              ),
                            ),

                            selected: selected,

                            selectedColor: Colors.white,
                            backgroundColor: Colors.white.withOpacity(0.6),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: selected
                                    ? const Color(0xff0D47A1)
                                    : Colors.black26,
                                width: selected ? 1.5 : 1,
                              ),
                            ),

                            onSelected: (_) {
                              context
                                  .read<CategoryCubit>()
                                  .changeCategory(cat);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
