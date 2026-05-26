import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/book.dart';
import '../model/author.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final uuid = const Uuid();

  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<Author> authors = [];
  Author? selectedAuthor;

  List<Book> books = [];

  @override
  void initState() {
    super.initState();

    authors = [
      Author(authorId: uuid.v4(), authorName: "Author A"),
      Author(authorId: uuid.v4(), authorName: "Author B"),
      Author(authorId: uuid.v4(), authorName: "Author C"),
    ];
  }

  void addBook() {
    if (bookNameController.text.isEmpty ||
        isbnController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedAuthor == null) {
      return;
    }

    final book = Book(
      bookId: uuid.v4(),
      bookName: bookNameController.text,
      isbnNumber: isbnController.text,
      bookPrice: double.parse(priceController.text),
      author: selectedAuthor!,
    );

    setState(() {
      books.add(book);
    });

    bookNameController.clear();
    isbnController.clear();
    priceController.clear();
    selectedAuthor = null;
  }

  @override
  Widget build(BuildContext context) {
    const lilac = Color(0xFFC8A2C8);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F1FA),
      appBar: AppBar(
        backgroundColor: lilac,
        centerTitle: true,
        title: const Text(
          "Book Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Book Name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: lilac),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: bookNameController,
                decoration: const InputDecoration(
                  labelText: "Book Name",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.book),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ISBN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: lilac),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: isbnController,
                decoration: const InputDecoration(
                  labelText: "ISBN Number",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Price
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: lilac),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: lilac),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<Author>(
                value: selectedAuthor,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text("Select Author"),
                  ],
                ),
                items: authors.map((author) {
                  return DropdownMenuItem(
                    value: author,
                    child: Text(author.authorName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAuthor = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lilac,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: addBook,
                child: const Text(
                  "Add Book",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Book List
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.menu_book,
                        color: lilac,
                      ),
                      title: Text(
                        book.bookName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "ISBN: ${book.isbnNumber}\nPrice: ${book.bookPrice}\nAuthor: ${book.author.authorName}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}