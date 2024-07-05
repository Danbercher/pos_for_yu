import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String selectedCountry = 'USA'; // Initially selected value

  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem(child: Text('USA'), value: 'USA'),
      DropdownMenuItem(child: Text('Canada'), value: 'Canada'),
      DropdownMenuItem(child: Text('Brazil'), value: 'Brazil'),
      DropdownMenuItem(child: Text('England'), value: 'England'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCountry,
      items: dropdownItems,
      onChanged: (newValue) {
        setState(() {
          selectedCountry = newValue!;
        });
      },
    );
  }
}

