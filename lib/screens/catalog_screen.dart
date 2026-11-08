import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  CatalogScreen({super.key}); // <-- Kode baru yang disarankan

  final List<Book> dummyBooks = [
    Book(
      id: '1',
      title: 'Pemrograman Flutter Dasar',
      author: 'Ahmad Fauzi',
      price: 85000,
      imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c',
    ),
    Book(
      id: '2',
      title: 'Belajar State Management',
      author: 'Budi Santoso',
      price: 95000,
      imageUrl: 'https://images.unsplash.com/photo-1532012197267-da84d127e765',
    ),
    Book(
      id: '3',
      title: 'Arsitektur Perangkat Lunak',
      author: 'Siti Rahma',
      price: 120000,
      imageUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6',
    ),
    Book(
      id: '4',
      title: 'Mastering Dart & Flutter',
      author: 'Rian Hidayat',
      price: 150000,
      imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaBookstore'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    if (cart.totalItems == 0) return const SizedBox();
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cart.totalItems}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyBooks.length,
        itemBuilder: (context, index) {
          final book = dummyBooks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    book.imageUrl,
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.book, size: 60),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Oleh: ${book.author}'),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${book.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().addItem(book);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${book.title} ditambahkan ke keranjang'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text('Tambah'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}