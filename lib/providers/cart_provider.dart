import 'package:flutter/foundation.dart';
import '../models/book.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get totalItems {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.book.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      _items.update(
        book.id,
        (existingCartItem) => CartItem(
          book: existingCartItem.book,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        book.id,
        () => CartItem(book: book, quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String bookId) {
    if (!_items.containsKey(bookId)) return;
    
    if (_items[bookId]!.quantity > 1) {
      _items.update(
        bookId,
        (existingCartItem) => CartItem(
          book: existingCartItem.book,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(bookId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}