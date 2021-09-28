import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favoriteList;

  TabsScreen(this.favoriteList);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Category'},
      {'page': FavoritesScreen(widget.favoriteList), 'title': 'Favorite'}
    ];
    super.initState();
  }

  var _selectedIndex = 0;

  void _selectPage(int selectIndex) {
    setState(() {
      _selectedIndex = selectIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedIndex]['title'] as String),
          elevation: 5,
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedIndex]['page'] as Widget,
        bottomNavigationBar: MyBNB(_selectPage, _selectedIndex)
        /*BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedIndex,
        elevation: 5,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),*/
        );
  }
}

class MyBNB extends StatefulWidget {
  final Function _selectPage;
  int _selectedIndex;

  MyBNB(this._selectPage, this._selectedIndex);

  @override
  _MyBNBState createState() => _MyBNBState();
}

class _MyBNBState extends State<MyBNB> {
  Color _setColor(int index) {
    if (widget._selectedIndex == index) {
      return Theme.of(context).colorScheme.secondary;
    } else
      return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
              onPressed: () => widget._selectPage(0),
              icon: Icon(
                Icons.category,
                color: _setColor(0),
              ),
              label: Text(
                'Category',
                style: TextStyle(
                  color: _setColor(0),
                ),
              )),
          TextButton.icon(
              onPressed: () => widget._selectPage(1),
              icon: Icon(
                Icons.star,
                color: _setColor(1),
              ),
              label: Text(
                'Favorite',
                style: TextStyle(
                  color: _setColor(1),
                ),
              ))
        ],
      ),
    );
  }
}
