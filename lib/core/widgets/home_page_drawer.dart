import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/navigation_service/navigation_service.dart';
import 'package:simple_todo_app/pages/about_page.dart';
import 'package:simple_todo_app/pages/completed_tasks_page.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({
    super.key,
  });

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  bool pendingTaskTileIsSelected = true;
  bool completedTaskTileIsSelected = false;
  bool aboutTileIsSelected = false;

  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CompletedTasksPage(),
              ));
            },
          ),
          ListTile(
            selected: aboutTileIsSelected,
            leading: const Icon(CupertinoIcons.info_circle),
            title: const Text("About"),
            onTap: () {
              state.close();

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AboutPage(),
              ));
            },
          )
        ],
      ),
    );
  }
}
