import 'package:flutter/material.dart';
import 'package:meal_app/data.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailScreen extends StatefulWidget {
  static const String routeName = '/meal-detail';
  final String _theme;
  final Function setFavoriteMeal;
  final Function removeFavoriteMeal;
  final List<Meal> favoriteList;

  MealDetailScreen(this._theme, this.setFavoriteMeal, this.removeFavoriteMeal,
      this.favoriteList);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Color? iconColor = Colors.white;
  String mealID = '';
  late Meal mealDetail;
  String affordabilityString = '';
  String complexityString = '';
  var _isFullyLoaded = false;
  var _isFavoriteTab = true;

  @override
  void didChangeDependencies() {
    if (!_isFullyLoaded) {
      final mealArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      mealID = mealArgs['id'] as String;
      iconColor = widget.favoriteList.contains(
              MEALS_DATA.firstWhere((element) => element.id == mealID))
          ? Colors.yellow
          : Colors.white;
      _isFavoriteTab = mealArgs['isFavoriteTab'] as bool;
      affordabilityString = mealArgs['affordabilityString'] as String;
      complexityString = mealArgs['complexityString'] as String;
      mealDetail = MEALS_DATA.firstWhere((element) => element.id == mealID);
      _isFullyLoaded = true;
      super.didChangeDependencies();
    }
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      alignment: Alignment.center,
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }

  void addToFavoriteList() {
    final snackBar = SnackBar(
      content: Text(
        'Added to Favorite List',
        textAlign: TextAlign.center,
      ),
      elevation: 10,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void removeFromFavoriteList() {
    final snackBar = SnackBar(
      content: Text(
        'Remove from Favorite List',
        textAlign: TextAlign.center,
      ),
      elevation: 10,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(mealDetail.title),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                if (iconColor == Colors.yellow) {
                  iconColor = Colors.white;
                  removeFromFavoriteList();
                  widget.removeFavoriteMeal(mealID);
                } else {
                  iconColor = Colors.yellow;
                  addToFavoriteList();
                  widget.setFavoriteMeal(mealID);
                }
              });
            },
            icon: Icon(
              Icons.star,
              color: iconColor,
            ))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: Image.network(
                    mealDetail.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.transparent,
                    widget._theme.compareTo('Bright') == 0
                        ? Color.fromRGBO(255, 254, 229, 1)
                        : Color(0xFF0C063D)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Positioned(
                    bottom: 50,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: mediaQuery.size.width,
                        alignment: Alignment.center,
                        child: Text(
                          mealDetail.title,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: 35,
                                  color: Theme.of(context).colorScheme.primary),
                        ))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule,
                        color: Theme.of(context).colorScheme.secondary),
                    SizedBox(
                      width: 6,
                    ),
                    Text('${mealDetail.duration} min')
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.work,
                        color: Theme.of(context).colorScheme.secondary),
                    SizedBox(
                      width: 6,
                    ),
                    Text(complexityString.toString())
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money,
                        color: Theme.of(context).colorScheme.secondary),
                    SizedBox(
                      width: 6,
                    ),
                    Text(affordabilityString.toString())
                  ],
                ),
              ],
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            height: 150,
            width: mediaQuery.size.width * 0.6,
            margin: EdgeInsets.fromLTRB(40, 20, 40, 40),
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: mealDetail.ingredients.length,
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mealDetail.ingredients[index]),
                ),
              ),
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: mealDetail.steps
                  .map((step) => Column(children: [
                        ListTile(
                          leading: CircleAvatar(
                            child:
                                Text('# ${mealDetail.steps.indexOf(step) + 1}'),
                          ),
                          title: Text(step),
                        ),
                        Divider(
                          color: Colors.black54,
                        )
                      ]))
                  .toList(),
            ),
          ),
          _isFavoriteTab
              ? Container()
              : Container(
                  height: 50,
                  width: mediaQuery.size.width * 0.5,
                  margin: EdgeInsets.symmetric(
                      horizontal: mediaQuery.size.width * 0.35),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).primaryColor.withBlue(100),
                        Color(0xFFF8E1A2)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(mealID);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.delete), Text('Delete')],
                    ),
                  ),
                ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
