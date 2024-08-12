import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/local_notifications/local_notifications_service.dart';
import 'package:simple_todo_app/core/navigation_service/navigation_service.dart';
import 'package:simple_todo_app/core/providers/navigation_provider.dart';
import 'package:simple_todo_app/core/providers/schedule_date_time_provider.dart';
import 'package:simple_todo_app/core/theme/theme_provider.dart';
import 'package:simple_todo_app/hive_database/completed_tasks_db_services.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';
import 'package:simple_todo_app/hive_database/shared_preferences_local_storage.dart';
import 'package:simple_todo_app/pages/about_page.dart';
import 'package:simple_todo_app/pages/completed_tasks_page.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';
import 'package:simple_todo_app/pages/drawer_navigation.dart';

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
  final _isDark = await SharedPreferencesLocalStorage().getCurrentTheme();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(
        isDark: _isDark ?? true,
      ),
      builder: (context, child) => const SimpleTodoApp(),
    ),
  );
}

class SimpleTodoApp extends StatefulWidget {
  const SimpleTodoApp({super.key});

  @override
  State<SimpleTodoApp> createState() => _SimpleTodoAppState();
}

class _SimpleTodoAppState extends State<SimpleTodoApp> {
  late ThemeData currentTheme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PendingTasksDbServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompletedTasksDbServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleDateTimeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getCurrentTheme,
          title: "Simple Todo App",
          initialRoute: "/",
          routes: {
            "/": (context) => DrawerNavigation(),
            "/createTasksPage": (context) => CreateTaskPage(),
            "/completedTasksPage": (context) => CompletedTasksPage(),
            "/aboutPage": (context) => AboutPage(),
          },
        ),
      ),
    );
  }
}
