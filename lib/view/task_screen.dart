import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/controller/task_service.dart';
import 'package:d5n_interview/model/task_model.dart';
import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:d5n_interview/utils/snackbar.dart';
import 'package:d5n_interview/widgets/button_widget.dart';
import 'package:d5n_interview/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({
    super.key,
    this.head,
    required this.categoryId,
  });
  final String? head;
  final String categoryId;

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        title: Text(
          widget.head.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: ref.watch(getTaskProvider).when(
            data: (data) {
              if (data.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No task found",
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                );
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Checkbox(
                            side: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            shape: const CircleBorder(),
                            checkColor: Colors.white,
                            activeColor: Colors.green,
                            value: data.docs[index].data().isDone,
                            onChanged: (value) {
                              TaskService().toggleTaskStatus(
                                ref.read(authStateProvider).value!.uid,
                                widget.categoryId,
                                data.docs[index].id,
                                data.docs[index].data().isDone,
                              );
                            },
                          ),
                          title: Text(
                            data.docs[index].data().taskname,
                            maxLines: null,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) => AlertDialog(
                                          contentTextStyle: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
                                          title: Text(
                                            "Are you sure ?",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          content: const Text(
                                              "This task will delete permenantly"),
                                          actions: [
                                            TextButton(
                                                onPressed: (() {
                                                  Navigator.of(context).pop();
                                                }),
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : Colors.black),
                                                )),
                                            TextButton(
                                                onPressed: (() {
                                                  TaskService().deleteTask(
                                                      ref
                                                          .read(
                                                              authStateProvider)
                                                          .value!
                                                          .uid,
                                                      widget.categoryId,
                                                      data.docs[index].id);
                                                  Navigator.of(context).pop();
                                                }),
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        )));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )));
                    },
                  ),
                );
              }
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.all(R.rw(16, context)),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          )),
                      TextfieldWidget(
                          hinttext: "Type your task...",
                          textcontroller: taskController),
                      SizedBox(
                        height: R.rh(16, context),
                      ),
                      ButtonWidget(
                          text: "Add",
                          onpressed: () {
                            if (taskController.text.isNotEmpty) {
                              ref.read(taskServiceProvider).addTask(
                                  ref.read(authStateProvider).value!.uid,
                                  ref.read(getCategoryIdProvider).toString(),
                                  TaskModel(
                                      taskname: taskController.text,
                                      isDone: false));
                              taskController.clear();
                              Navigator.pop(context);
                            } else {
                              snackbar("Please fill the fields", context);
                            }
                          }),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: R.rw(32, context),
        ),
      ),
    );
  }
}
