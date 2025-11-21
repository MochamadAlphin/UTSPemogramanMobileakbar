// lib/models/menu_model.dart
class MenuModel {
  final String id;
  final String name;
  final int price;
  final String category;
  final double discount; // 0 - 1
  final String imageUrl; // untuk menampilkan gambar produk

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.discount = 0.0,
    required this.imageUrl,
  });

  /// Harga setelah diskon per item
  int getDiscountedPrice() {
    return (price - (price * discount)).toInt();
  }
}
final List<MenuModel> dummyMenus = [
  MenuModel(
    id: 'm1',
    name: 'Nasi Goreng Spesial',
    price: 25000,
    category: 'Makanan',
    discount: 0.1,
    imageUrl:
        'https://images.pexels.com/photos/11654257/pexels-photo-11654257.jpeg',
  ),
  MenuModel(
    id: 'm2',
    name: 'Mie Ayam Bakso',
    price: 22000,
    category: 'Makanan',
    discount: 0.0,
    imageUrl:
        'https://images.pexels.com/photos/884600/pexels-photo-884600.jpeg',
  ),
    MenuModel(
    id: 'm3',
    name: 'Sate Ayam',
    price: 20000,
    category: 'Makanan',
    discount: 0.0,
    imageUrl: 'https://images.pexels.com/photos/1070053/pexels-photo-1070053.jpeg',
  ),
  MenuModel(
    id: 'd1',
    name: 'Es Teh Manis',
    price: 8000,
    category: 'Minuman',
    discount: 0.2,
    imageUrl:
        'https://images.pexels.com/photos/3987366/pexels-photo-3987366.jpeg',
  ),
  MenuModel(
    id: 'd2',
    name: 'Jus Alpukat',
    price: 15000,
    category: 'Minuman',
    discount: 0.1,
    imageUrl:
        'https://images.pexels.com/photos/5946088/pexels-photo-5946088.jpeg',
  ),
    MenuModel(
    id: 'd3',
    name: 'Kopi Hitam',
    price: 10000,
    category: 'Minuman',
    discount: 0.0,
    imageUrl: 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg',
  ),
  MenuModel(
    id: 's1',
    name: 'Pisang Goreng',
    price: 12000,
    category: 'Snack',
    discount: 0.0,
    imageUrl:
        'https://images.pexels.com/photos/4109998/pexels-photo-4109998.jpeg',
  ),
    MenuModel(
    id: 's2',
    name: 'Tahu Isi',
    price: 10000,
    category: 'Snack',
    discount: 0.0,
    imageUrl: 'https://images.pexels.com/photos/208803/pexels-photo-208803.jpeg',
  ),
  MenuModel(
    id: 's3',
    name: 'Roti Bakar',
    price: 15000,
    category: 'Snack',
    discount: 0.1,
    imageUrl: 'https://images.pexels.com/photos/372851/pexels-photo-372851.jpeg',
  ),
];

