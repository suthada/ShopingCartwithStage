import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;
  final List<GlobalKey<_ShoppingItemState>> _itemKeys = [
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
  ];

  void updateTotal(int price, int count) {
    setState(() {
      total += price * count;
    });
  }

  void clearAll() {
    setState(() {
      total = 0;
    });
    for (var key in _itemKeys) {
      key.currentState?.resetCount();
    }
  }

  String formatPrice(int price) {
    return price
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: const Color.fromARGB(255, 228, 155, 133),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  ShoppingItem(
                    key: _itemKeys[0],
                    title: "iPad Pro",
                    price: 32000,
                    onUpdateTotal: updateTotal,
                  ),
                  ShoppingItem(
                    key: _itemKeys[1],
                    title: "iPad Mini",
                    price: 25000,
                    onUpdateTotal: updateTotal,
                  ),
                  ShoppingItem(
                    key: _itemKeys[2],
                    title: "iPad Air",
                    price: 29000,
                    onUpdateTotal: updateTotal,
                  ),
                  ShoppingItem(
                    key: _itemKeys[3],
                    title: "iPad Pro",
                    price: 39000,
                    onUpdateTotal: updateTotal,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    '${formatPrice(total)} ฿',
                    style: const TextStyle(fontSize: 30),
                  ),
                  ElevatedButton(
                    onPressed: clearAll,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 252, 227, 236),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Clear",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final Function(int price, int count) onUpdateTotal;

  ShoppingItem({
    required Key key,
    required this.title,
    required this.price,
    required this.onUpdateTotal,
  }) : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;

  void _incrementCount() {
    setState(() {
      count++;
    });
    widget.onUpdateTotal(widget.price, 1);
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
      });
      widget.onUpdateTotal(widget.price, -1);
    }
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.price} ฿",
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _decrementCount,
                icon: const Icon(Icons.remove, color: Colors.red),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                count.toString(),
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: _incrementCount,
                icon: const Icon(Icons.add, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
