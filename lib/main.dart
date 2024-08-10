import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/local_notifications/local_notifications_service.dart';
import 'package:simple_todo_app/core/navigation_service/navigation_service.dart';
import 'package:simple_todo_app/hive_database/completed_tasks_db_services.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';
import 'package:simple_todo_app/pages/about_page.dart';
import 'package:simple_todo_app/pages/completed_tasks_page.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';
import 'package:simple_todo_app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await PendingTasksDbServices().storePreviousData();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
  await LocalNotificationsService().initialiseLocalNotifications();

  runApp(const SimpleTodoApp());
}

class SimpleTodoApp extends StatelessWidget {
  const SimpleTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PendingTasksDbServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompletedTasksDbServices(),
        )
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        title: "Simple Todo App",
        initialRoute: "/",
        routes: {
          "/": (context) => HomePage(),
          "/createTasksPage": (context) => CreateTaskPage(),
          "/completedTasksPage": (context) => CompletedTasksPage(),
          "/aboutPage": (context) => AboutPage(),
        },
        // builder: (context, child) {
        //   print("From MaterialApp: ${child?.key}");
        //   return Scaffold(
        //     drawer: HomePageDrawer(
        //       navigator:
        //           (child?.key as GlobalKey<NavigatorState>?)?.currentState,
        //     ),
        //     body: child,
        //   );
        // },
        // home: HomePage(),
      ),
    );
  }
}
