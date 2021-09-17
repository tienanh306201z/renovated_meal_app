import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  final String avatarUrl =
      'https://scontent.fhan3-4.fna.fbcdn.net/v/t1.6435-9/171353902_1699765133542263_8789632920451818818_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=l1YuHaPPJLUAX-VmUkg&_nc_ht=scontent.fhan3-4.fna&oh=b533d63154cc7758b69447772b5b082d&oe=61666C49';

  Widget createDrawerButton(String title, IconData icon, BuildContext context,
      Function _onTapFuntion) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6!,
      ),
      onTap: () => _onTapFuntion(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Colors.limeAccent.shade200
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: LayoutBuilder(
              builder: (ctx, constraint) => Row(
                children: [
                  Container(
                    width: constraint.maxWidth * 1 / 3,
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth * 2 / 3,
                    height: 120,
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    child: Text(
                      'Cooking up!',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 27,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          createDrawerButton('Meals', Icons.restaurant, context,
              () => Navigator.of(context).pushReplacementNamed('/tab-screen')),
          createDrawerButton(
              'Settings',
              Icons.settings,
              context,
              () => Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName)),
        ],
      ),
    );
  }
}
