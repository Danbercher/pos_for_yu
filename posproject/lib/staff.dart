import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class Staff extends StatefulWidget {
  @override
  _StaffsPageState createState() => _StaffsPageState();
}

class _StaffsPageState extends State<Staff> {
  final List<StaffItem> staffs = [];

  String searchText = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _positonController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStaffs();
  }

  Future<void> _loadStaffs() async {
    final StaffData = await DatabaseHelper.instance.getStaff();
    setState(() {
      staffs.clear();
      StaffData.forEach((staff) {
        staffs.add(StaffItem(
          id: staff['id'],
          name: staff['name'],
          position: staff['position'],
          image: AssetImage("assets/yuEmployee.jpg"), // Default image
          address: staff['address'],
          description: staff['description'],
        ));
      });
    });
  }

  Future<void> _addStaffsToDatabase(String name, String position, String address, String description) async {
    Map<String, dynamic> StaffData = {
      'name': name,
      'position': position,
      'address': address,
      'description': description,
    };
    await DatabaseHelper.instance.insertStaff(StaffData);
    _loadStaffs();
  }

  Future<void> _deleteStaffsfromDatabase(int id) async {
    await DatabaseHelper.instance.deleteStaffs(id);
    _loadStaffs();
  }

  void _addStaffsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Text(
            "Add New Staff",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _positonController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Position',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _addressController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("Add"),
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _nameController.text.isNotEmpty &&
                    _addressController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                
                  await _addStaffsToDatabase(
                    _nameController.text,
                    _positonController.text,
                    _addressController.text,
                    _descriptionController.text,
                  );
                  _nameController.clear();
                  _positonController.clear();
                  _addressController.clear();
                  _descriptionController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredServices = searchText.isEmpty
        ? staffs
        : staffs
            .where((item) => item.position.toLowerCase().contains(searchText.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('YU Beauty Spa - STAFFS'),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 5),
                Text(
                  "${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 130, 208, 165).withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 14,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Image.asset(
              "assets/yuEmployee.jpg",
              width: 350,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by Stuffs',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final item = filteredServices[index];
                return Container(
                  color: Color.fromARGB(255, 196, 230, 206),
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: item.image,
                    ),
                    title: Text(
                      item.name,
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      item.position,
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _deleteStaffsfromDatabase(item.id);
                        setState(() {
                          staffs.removeAt(index);
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailsPage(item: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'To add a staff, click this button ',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _addStaffsDialog,
            tooltip: 'Add Staff',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class ItemDetailsPage extends StatelessWidget {
  final StaffItem item;
  const ItemDetailsPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[         
                      
            Image(image: item.image),
            SizedBox(height: 20),
            Text('Name : ${item.name}'),
            SizedBox(height: 10),
            
            SizedBox(height: 20),
            Text(item.description),
          ],
        ),
      ),
    );
  }
}

class StaffItem {
  final int id;
  final String name;
  final String position;
  final ImageProvider image;
  final String address;
  final String description;
  StaffItem({
    required this.id,
    required this.name,
    required this.position,
    required this.image,
    required this.address,
    required this.description,
  });
}
