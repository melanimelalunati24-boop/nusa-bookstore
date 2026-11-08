class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });
}