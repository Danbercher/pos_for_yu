import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MyPos extends StatefulWidget {
  @override
  _PosState createState() => _PosState();
}

class _PosState extends State<MyPos> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("YU Hair & Beauty Spa"),
          backgroundColor: Colors.green,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 5),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: MyOrderScreen(),
       
      ),
    );
  }
}

class OrderModel extends ChangeNotifier {
  List<OrderItem>? items = [];
  String? userName = '';

  OrderModel({this.items, this.userName});

  void setUserName(String? name) {
    userName = name;
    notifyListeners();
  }

  void addItem(
      String itemName, String itemDescription, double itemPrice, String itemEmp, int quantity) {
    items = items ?? [];
    items!.add(OrderItem(itemName, itemDescription, itemPrice, itemEmp, quantity));
    notifyListeners();
  }

  void clearItems() {
    items?.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    return items?.fold(0.0, (sum, item) => sum! + (item.price * item.quantity)) ?? 0.0;
  }
}

class OrderItem {
  final String name;
  final String description;
  final double price;
  final String empName;
  final int quantity; // New field for quantity

  OrderItem(this.name, this.description, this.price, this.empName, this.quantity);
}

class MyOrderScreen extends StatefulWidget {
  @override
  OrderScreen createState() => OrderScreen();
}

class OrderScreen extends State<MyOrderScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemDescriptionController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemEmployeeController = TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController(); // New controller for quantity
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  OrderModel orderModel = OrderModel(items: [], userName: "");

  @override
  Widget build(BuildContext context) {
    orderModel = Provider.of<OrderModel>(context);
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.green,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[200],
                      labelText: 'Enter customer name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (value) {
                      orderModel.setUserName(value);
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _itemNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[200],
                      labelText: 'Enter service name',
                      prefixIcon: Icon(Icons.contact_support),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _itemPriceController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[200],
                      labelText: 'Enter price',
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _itemEmployeeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[200],
                      labelText: 'Enter Employee Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _itemQuantityController, // Controller for quantity
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green[200],
                      labelText: 'Enter quantity',
                      prefixIcon: Icon(Icons.add),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_itemNameController.text.isNotEmpty &&
                            _itemPriceController.text.isNotEmpty &&
                            _itemEmployeeController.text.isNotEmpty &&
                            _itemQuantityController.text.isNotEmpty) {
                          orderModel.addItem(
                            _itemNameController.text,
                            _itemDescriptionController.text,
                            double.tryParse(_itemPriceController.text) ?? 0.0,
                            _itemEmployeeController.text,
                            int.tryParse(_itemQuantityController.text) ?? 1, // Parse quantity
                          );
                          _itemNameController.clear();
                          _itemDescriptionController.clear();
                          _itemPriceController.clear();
                          _itemEmployeeController.clear();
                          _itemQuantityController.clear(); // Clear quantity field
                        }
                      },
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(
                            BorderSide(color: Colors.black, width: 1)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.green),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 16.0)),
                        textStyle: WidgetStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 18)),
                      ),
                      child: Text('Add Order'),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  if (orderModel.items != null && orderModel.items!.isNotEmpty) ...[
                    Text(
                      'Order for: "${orderModel.userName}"',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: 40.0, // Adjust column spacing
                          horizontalMargin: 16.0, // Adjust horizontal margin
                          dividerThickness: 2.0, // Increase divider thickness for column lines
                          // ignore: deprecated_member_use
                          dataRowHeight: 80.0, // Adjust data row height
                          showCheckboxColumn: false,
                          sortAscending: true,
                          sortColumnIndex: 0,
                          headingRowHeight: 40.0, // Adjust heading row height
                          headingTextStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          border: TableBorder.all(color: Colors.grey, width: 1.0), // Add table border for row lines
                          columns: const [
                            DataColumn(
                              label: Text(
                                'No.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Service',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Employee Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            
                            DataColumn(
                              label: Text(
                                'Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Action',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                          rows: orderModel.items!.asMap().entries.map((entry) {
                            int index = entry.key;
                            OrderItem item = entry.value;
                            return DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text((index + 1).toString()), // Displaying the row number
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(item.name),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(item.empName),
                                  ),
                                ),
                               
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(item.quantity.toString()),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(NumberFormat('#,###,###').format(item.price)),
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => deleteRow(item),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 16),
                  if (orderModel.items != null && orderModel.items!.isNotEmpty)
                    Text(
                      'Total Price: ${NumberFormat('#,###,###').format(orderModel.getTotalPrice())} MMK',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _printOrder(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text('Print Order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _printOrder(BuildContext context) async {
    var orderModel = Provider.of<OrderModel>(context, listen: false);
    List<OrderItem>? items = orderModel.items;
    String? userName = orderModel.userName;

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Order for $userName", style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Service', 'Employee Name', 'Quantity', 'Price'],
                data: items!
                    .map((item) => [
                          item.name,
                          item.empName,
                         
                          item.quantity.toString(),
                          item.price.toStringAsFixed(2),
                        ])
                    .toList(),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Total Price: \$${orderModel.getTotalPrice().toStringAsFixed(2)}',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
         return pdf.save();
      },
      name: "MyPDF.pdf",
    );
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void deleteRow(OrderItem item) {
    setState(() {
      orderModel.items!.remove(item);
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: MyPos(),
  ));
}
