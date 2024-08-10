import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/navigation_service/navigation_service.dart';
import 'package:simple_todo_app/pages/about_page.dart';
import 'package:simple_todo_app/pages/completed_tasks_page.dart';
import 'package:simple_todo_app/pages/home_page.dart';

class HomePageDrawer extends StatefulWidget {
  // final NavigatorState? navigator;

  const HomePageDrawer({
    super.key,
    // required this.navigator,
  });

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  bool pendingTaskTileIsSelected = true;
  bool completedTaskTileIsSelected = false;
  bool aboutTileIsSelected = false;
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // print(ModalRoute.of(context)?.settings.name);
    // print("From Drawer: ${widget.navigator?.context}");
    print("From Drawer: ${HomePage().key}");

    final state = RootDrawer.of(context);

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: CircleAvatar(
              child: Icon(Icons.list),
            ),
          ),
          ListTile(
            selected: pendingTaskTileIsSelected,
            leading: const Icon(Icons.pending_actions),
            title: const Text("Pending Tasks"),
            onTap: () {
              print(ModalRoute.of(context)?.settings.name);
            },
          ),
          ListTile(
            selected: completedTaskTileIsSelected,
            leading: const Icon(Icons.checklist_rounded),
            title: const Text("Completed Tasks"),
            onTap: () {
              // widget.navigator?.pushReplacement(MaterialPageRoute(
              //   builder: (context) => CompletedTasksPage(),
              // ));
              // state.close();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CompletedTasksPage(),
              ));
              // print(ModalRoute.of(context)?.settings.name);
            },
          ),
          ListTile(
            selected: aboutTileIsSelected,
            leading: const Icon(CupertinoIcons.info_circle),
            title: const Text("About"),
            onTap: () {
              // widget.navigator?.pushReplacement(MaterialPageRoute(
              //   builder: (context) => AboutPage(),
              // ));
              state.close();
              // if (ModalRoute.of(context)?.settings.name == "/aboutPage") {
              //   Navigator.of(context).pop();
              // } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ));
              //   print(ModalRoute.of(context)?.settings.name);
              // }
            },
          )
        ],
      ),
    );
  }
}
