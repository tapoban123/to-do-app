import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/providers/navigation_provider.dart';
import 'package:simple_todo_app/page_specific_widgets/about_page_appbar.dart';
import 'package:simple_todo_app/page_specific_widgets/completed_tasks_page_appbar.dart';
import 'package:simple_todo_app/page_specific_widgets/home_page_appbar.dart';
import 'package:simple_todo_app/page_specific_widgets/home_page_floating_action_button.dart';
import 'package:simple_todo_app/pages/about_page.dart';
import 'package:simple_todo_app/pages/completed_tasks_page.dart';
import 'package:simple_todo_app/pages/home_page.dart';
import 'package:simple_todo_app/pages/settings_page.dart';

class DrawerNavigation extends StatefulWidget {
  DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  ScrollController scrollController = ScrollController();
  bool isFabBVisible = true;
  late int currentIndex;

  List<Map<String, dynamic>> navItems = [
    {
      "icon": Icons.pending_actions,
      "name": "PENDING TASKS",
    },
    {
      "icon": Icons.checklist_rounded,
      "name": "COMPLETED TASKS",
    },
    {
      "icon": CupertinoIcons.info_circle,
      "name": "ABOUT",
    },
  ];

  List<Widget> getPages() {
    List<Widget> pages = [
      HomePage(
        scrollDirection: scrollController,
      ),
      CompletedTasksPage(),
      AboutPage(),
    ];

    return pages;
  }

  PreferredSizeWidget returnPageSpecificAppBars() {
    switch (currentIndex) {
      case 0:
        return HomePageAppbar();
      case 1:
        return CompletedTasksPageAppbar();
      case 2:
        return AboutPageAppbar();
      default:
        return AppBar();
    }
  }

  @override
  void initState() {
    scrollController.addListener(
      () {
        final scrollDirection = scrollController.position.userScrollDirection;

        if (scrollDirection == ScrollDirection.forward) {
          setState(() {
            isFabBVisible = true;
          });
        } else if (scrollDirection == ScrollDirection.reverse) {
          setState(() {
            isFabBVisible = false;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentIndex = Provider.of<NavigationProvider>(context).currentPageNumber;

    return Scaffold(
      appBar: returnPageSpecificAppBars(),
      floatingActionButton: (isFabBVisible && currentIndex == 0)
          ? HomePageFloatingActionButton()
          : null,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/to-do-list.png"),
            ),
            Expanded(
              flex: 9,
              child: ListView.builder(
                itemCount: getPages().length,
                itemBuilder: (context, index) {
                  final eachItem = navItems[index];

                  return ListTile(
                    selected: (currentIndex == index) ? true : false,
                    selectedTileColor: Theme.of(context).focusColor,
                    // selectedColor: Colors.white,
                    leading: Icon(eachItem["icon"]),
                    title: Text(
                      eachItem["name"],
                      style: TextStyle(
                        fontWeight: (currentIndex == index)
                            ? FontWeight.w900
                            : FontWeight.w400,
                        letterSpacing: 3,
                      ),
                    ),
                    iconColor: (currentIndex != index)
                        ? Theme.of(context)
                            .listTileTheme
                            .iconColor!
                            .withOpacity(0.5)
                        : Theme.of(context).listTileTheme.titleTextStyle?.color,
                    onTap: () {
                      Provider.of<NavigationProvider>(context, listen: false)
                          .navigateToPage(index);
                      Scaffold.of(context).closeDrawer();
                    },
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SettingsPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween = Tween(
                        begin: Offset(1, 0),
                        end: Offset.zero,
                      ).chain(
                        CurveTween(curve: Curves.decelerate),
                      );

                      final animationOffset = animation.drive(tween);

                      return SlideTransition(
                        position: animationOffset,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 500),
                  ));
                },
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        children: getPages(),
        index: currentIndex,
      ),
    );
  }
}
