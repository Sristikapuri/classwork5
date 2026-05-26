import 'author.dart';

class Book {
  final String bookId;
  final String bookName;
  final String isbnNumber;
  final double bookPrice;
  final Author author;

  Book({
    required this.bookId,
    required this.bookName,
    required this.isbnNumber,
    required this.bookPrice,
    required this.author,
  });
}