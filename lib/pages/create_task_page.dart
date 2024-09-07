import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/common/show_error_popUps.dart';
import 'package:simple_todo_app/core/common/show_snackbar.dart';
import 'package:simple_todo_app/core/local_notifications/local_notifications_service.dart';
import 'package:simple_todo_app/core/model/task_model.dart';
import 'package:simple_todo_app/core/providers/schedule_date_time_provider.dart';
import 'package:simple_todo_app/core/widgets/create_task_leading_icons.dart';
import 'package:simple_todo_app/core/widgets/create_task_textfield.dart';
import 'package:simple_todo_app/core/widgets/important_task_icon.dart';
import 'package:simple_todo_app/core/widgets/reminder_option.dart';
import 'package:simple_todo_app/core/widgets/scheduled_task_icon.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';

class CreateTaskPage extends StatefulWidget {
  final TaskModel? oldTask;
  final bool editSpecificTask;
  final int? taskIndex;

  /// This page is returned when the user wants to `create or edit a task`.
  /// For editing purpose a boolean condition is checked.
  ///
  /// IF condition is true: TaskEdit widgets are returned
  ///
  /// ELSE: CreateTask widgets are returned
  const CreateTaskPage({
    super.key,
    this.oldTask,
    this.taskIndex,
    this.editSpecificTask = false,
  });

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController newTaskTitleController = TextEditingController();

  final TextEditingController newTaskDescriptionController =
      TextEditingController();

  late String currentDate;
  late String currentTime;

  bool remindMe = false;
  bool isImportant = false;
  bool firstRun = true;
  bool selectedNewScheduleDateTime = false;

  DateTime remindMeDate = DateTime.now();
  TimeOfDay remindMeTime = TimeOfDay.now();

  @override
  void initState() {
    Provider.of<ScheduleDateTimeProvider>(
      context,
      listen: false,
    ).resetDateTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.editSpecificTask && firstRun) {
      final prevTask = widget.oldTask!;

      remindMe = prevTask.remindMe;
      isImportant = prevTask.isImportant;
      newTaskTitleController.text = prevTask.taskTitle;
      newTaskDescriptionController.text = prevTask.taskDescription;

      firstRun = false;
    }

    return Scaffold(
      appBar: AppBar(
        leading: widget.editSpecificTask
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close_rounded))
            : null,
        title: Text(widget.editSpecificTask ? "EDIT TASK" : "NEW TASK"),
        actions: [
          if (widget.editSpecificTask)
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: const Text("Delete"),
                  onTap: deleteTask,
                ),
              ],
            ),
          if (!widget.editSpecificTask)
            TextButton(
              onPressed: createOrEditTask,
              child: Icon(
                CupertinoIcons.check_mark,
                color: Theme.of(context).textTheme.headlineMedium!.color,
              ),
            ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CreateTaskTextfield(
                textController: newTaskTitleController,
                hintText: "Task title",
                textInputAction: TextInputAction.next,
                fontSize: 25,
              ),
              const SizedBox(
                height: 15,
              ),
              CreateTaskTextfield(
                textController: newTaskDescriptionController,
                hintText: "Task description...",
                textInputAction: TextInputAction.newline,
                maxLines: 5,
              ),
              if (widget.editSpecificTask)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Creation date: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.4),
                                  ),
                            ),
                            TextSpan(
                              text: widget.oldTask!.creationDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.4),
                                  ),
                            )
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Creation time: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.4),
                                  ),
                            ),
                            TextSpan(
                              text: widget.oldTask!.creationTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.4),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 25,
              ),
              CreateTaskLeadingIcons(
                titleText: "Mark as important",
                leadingIcon: ImportantTaskIcon(),
                isChecked: isImportant,
                onChanged: (value) {
                  setState(() {
                    isImportant = !isImportant;
                  });
                },
              ),
              CreateTaskLeadingIcons(
                titleText: "Remind me",
                leadingIcon: ScheduledTaskIcon(),
                isChecked: remindMe,
                onChanged: (val) => remindMeButtonOnTap(),
              ),
              const SizedBox(
                height: 25,
              ),
              remindMe
                  ? Consumer<ScheduleDateTimeProvider>(
                      builder: (context, dateTimeProvider, child) {
                        currentDate = dateTimeProvider.getScheduledDate;
                        currentTime = dateTimeProvider.getScheduledTime;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReminderOption(
                              onTap: pickDate,
                              textController:
                                  TextEditingController(text: currentDate),
                              tileLabel: "Date",
                            ),
                            ReminderOption(
                              onTap: pickTime,
                              textController:
                                  TextEditingController(text: currentTime),
                              tileLabel: "Time",
                            ),
                          ],
                        );
                      },
                    )
                  : const SizedBox(
                      height: 56,
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.235,
              ),
              if (widget.editSpecificTask == true)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff000c91),
                          Color(0xff3742b5),
                          Color(0xff6b74d0),
                          Color(0xffa5abed),
                          Color(0xffe0e2ff),
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () => createOrEditTask(editTask: true),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void remindMeButtonOnTap() async {
    final status = await Permission.notification.status;

    print(status);

    if (status.isPermanentlyDenied) {
      showErrorDialog(
        context,
        icon: Icons.notifications_off_rounded,
        titleText: "Notifications are turned off",
        contentText:
            "You need to allow the application to display notifications in order to schedule tasks.",
        actionButtonText: "Open App settings",
        onTap: () async {
          await openAppSettings();
          Navigator.of(context).pop();
        },
      );
    } else if (status.isDenied) {
      Permission.notification.request().then(
        (value) {
          if (value.isDenied || value.isPermanentlyDenied) {
            showErrorDialog(
              context,
              icon: Icons.notifications_off_rounded,
              titleText: "Notifications are turned off",
              contentText:
                  "You need to allow the application to display notifications in order to schedule tasks.",
              actionButtonText: "Open App settings",
              onTap: () async {
                await openAppSettings();
                Navigator.of(context).pop();
              },
            );
          }
        },
      );
    } else if (status.isGranted) {
      print("Granted callback");
      setState(() {
        remindMe = !remindMe;
      });
    }
  }

  void pickDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
      barrierDismissible: false,
    ).then(
      (newSelectedDate) {
        if (newSelectedDate != null) {
          Provider.of<ScheduleDateTimeProvider>(context, listen: false)
              .changeDate(newSelectedDate);
          selectedNewScheduleDateTime = true;
          remindMeDate = newSelectedDate;
        }
      },
    );
  }

  void pickTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (newSelectedTime) {
        if (newSelectedTime != null) {
          remindMeTime = newSelectedTime;
          final now = DateTime.now();

          DateTime selectedTime = DateTime(
            now.year,
            now.month,
            now.day,
            newSelectedTime.hour,
            newSelectedTime.minute,
          );

          Provider.of<ScheduleDateTimeProvider>(context, listen: false)
              .changeTime(selectedTime);
          selectedNewScheduleDateTime = true;
        }
      },
    );
  }

  DateTime scheduledDateTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  void deleteTask() {
    Provider.of<PendingTasksDbServices>(context, listen: false)
        .deleteSpecificTask(widget.taskIndex!);
    showSnackBar(
      context,
      "Deleted task successfully",
      Colors.purple[300]!,
    );

    Navigator.of(context).pop();
  }

  void createOrEditTask({bool editTask = false}) async {
    if (newTaskTitleController.text.isNotEmpty) {
      int currentTaskId =
          Provider.of<PendingTasksDbServices>(context, listen: false)
                  .getCurrentTaskIndex +
              1;
      try {
        if (remindMe && (editTask == false)) {
          await LocalNotificationsService().showScheduledNotification(
            notificationID: currentTaskId,
            title: "You have one pending task",
            description: newTaskTitleController.text,
            scheduledDateTime: scheduledDateTime(remindMeDate, remindMeTime),
          );
        }

        TaskModel newTask = TaskModel(
          taskId: editTask ? widget.oldTask!.taskId : currentTaskId,
          taskTitle: newTaskTitleController.text,
          taskDescription: newTaskDescriptionController.text,
          isImportant: isImportant,
          remindMe: remindMe,
          creationDate: DateFormat("dd/MM/yyyy")
              .format(DateTime.now())
              .replaceAll("/", "-"),
          creationTime: DateFormat.jm().format(DateTime.now()),
        );

        if (editTask) {
          Provider.of<PendingTasksDbServices>(
            context,
            listen: false,
          ).updateSpecificTask(
            newTask,
            widget.taskIndex!,
          );

          if (remindMe == false) {
            LocalNotificationsService()
                .cancelSpecificNotification(widget.oldTask!.taskId);
          } else {
            if (selectedNewScheduleDateTime) {
              LocalNotificationsService()
                  .cancelSpecificNotification(widget.oldTask!.taskId);

              await LocalNotificationsService().showScheduledNotification(
                notificationID: widget.oldTask!.taskId,
                title: "You have one pending task",
                description: newTaskTitleController.text,
                scheduledDateTime: scheduledDateTime(
                  remindMeDate,
                  remindMeTime,
                ),
              );
            }
          }

          showSnackBar(
            context,
            "Updated task successfully",
            Colors.purple[300]!,
          );
        } else {
          Provider.of<PendingTasksDbServices>(context, listen: false).addTask(
            newTask: newTask,
          );
          showSnackBar(
            context,
            "Created task successfully",
            Colors.purple[300]!,
          );
        }

        Navigator.of(context).pop();
      } on ArgumentError {
        showErrorDialog(
          context,
          icon: Icons.close_rounded,
          titleText: "Oops!!!",
          contentText:
              "Failed to create a new task. Please select a proper date/time that is in the future.",
        );
      } catch (e) {
        showSnackBar(
          context,
          e.toString(),
          Colors.red[400]!,
        );
      }
    } else {
      showErrorDialog(
        context,
        icon: CupertinoIcons.question,
        titleText: "ERROR",
        contentText: "Please fill in the task title to create a task.",
      );
    }
  }
}
