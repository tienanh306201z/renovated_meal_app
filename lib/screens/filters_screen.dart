import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function setFilter;
  final Map<String, bool> currentFilter;
  final Function setTheme;
  final String currentTheme;

  FiltersScreen(
      {required this.setFilter,
      required this.currentFilter,
      required this.setTheme,
      required this.currentTheme});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String dropdownValue = 'Bright';

  var _isGlutenFree = false;
  var _isVegetarian = false;
  var _isVegan = false;
  var _isLactoseFree = false;

  @override
  void initState() {
    dropdownValue = widget.currentTheme;
    _isGlutenFree = widget.currentFilter['gluten'] as bool;
    _isLactoseFree = widget.currentFilter['lactose'] as bool;
    _isVegan = widget.currentFilter['vegan'] as bool;
    _isVegetarian = widget.currentFilter['vegetarian'] as bool;
    super.initState();
  }

  void setFilter() {
    final selectedFilters = {
      'gluten': _isGlutenFree,
      'lactose': _isLactoseFree,
      'vegan': _isVegan,
      'vegetarian': _isVegetarian,
    };
    widget.setFilter(selectedFilters);
  }

  Widget customSwitchWidget(
      String title, String subtitle, bool checkValue, Function changeFunction) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: checkValue,
        onChanged: changeFunction as Function(bool));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Set app\'s theme',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      widget.setTheme(dropdownValue);
                    });
                  },
                  items: <String>['Bright', 'Dark']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                          margin: EdgeInsets.all(10), child: Text(value)),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust meals selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              customSwitchWidget('Gluten-free',
                  'Only include gluten-free meals.', _isGlutenFree, (newVal) {
                setState(() {
                  _isGlutenFree = newVal;
                  setFilter();
                });
              }),
              customSwitchWidget(
                  'Vegetarian', 'Only include vegetarian meals.', _isVegetarian,
                  (newVal) {
                setState(() {
                  _isVegetarian = newVal;
                  setFilter();
                });
              }),
              customSwitchWidget('Vegan', 'Only include vegan meals.', _isVegan,
                  (newVal) {
                setState(() {
                  _isVegan = newVal;
                  setFilter();
                });
              }),
              customSwitchWidget('Lactose-free',
                  'Only include lactose-free meals.', _isLactoseFree, (newVal) {
                setState(() {
                  _isLactoseFree = newVal;
                  setFilter();
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}
