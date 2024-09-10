import 'dart:developer';
import 'package:d5n_interview/controller/auth_service.dart';
import 'package:d5n_interview/controller/category_service.dart';
import 'package:d5n_interview/controller/task_service.dart';
import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:d5n_interview/utils/snackbar.dart';
import 'package:d5n_interview/view/auth/login_screen.dart';
import 'package:d5n_interview/view/settings_screen.dart';
import 'package:d5n_interview/view/task_screen.dart';
import 'package:d5n_interview/widgets/button_widget.dart';
import 'package:d5n_interview/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController emojiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
          },
          child: Padding(
            padding: EdgeInsets.only(left: R.rw(10, context)),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp"),
            ),
          ),
        ),
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
                AuthService().logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: R.rh(16, context), horizontal: R.rw(16, context)),
        child: Column(
          children: [
            Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white12
                        : Colors.black12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://pics.craiyon.com/2023-11-26/oMNPpACzTtO5OVERUZwh3Q.webp"),
                ),
                title: Text(
                  "\"The memories is a shield and life helper.\"",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Tamim-Al-Barghouti",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: R.rh(30, context),
            ),
            ref.watch(getCategoriesProvider).when(
                  data: (data) {
                    log(data.toString());
                    if (data != null) {
                      return Expanded(
                          child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.docs.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: R.rh(120, context)),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      contentPadding:
                                          EdgeInsets.all(R.rw(16, context)),
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            TextfieldWidget(
                                              hinttext: "Emoji",
                                              textcontroller: emojiController,
                                            ),
                                            SizedBox(height: R.rh(16, context)),
                                            TextfieldWidget(
                                              hinttext: "Title",
                                              textcontroller: titleController,
                                            ),
                                            SizedBox(height: R.rh(16, context)),
                                            ButtonWidget(
                                              text: "Add",
                                              onpressed: () async {
                                                if (titleController
                                                        .text.isNotEmpty &&
                                                    emojiController
                                                        .text.isNotEmpty) {
                                                  await CategoryService()
                                                      .addCategory(
                                                    AuthService()
                                                        .auth
                                                        .currentUser!
                                                        .uid,
                                                    titleController.text,
                                                    emojiController.text,
                                                  );
                                                  emojiController.clear();
                                                  titleController.clear();
                                                  Navigator.pop(context);
                                                } else {
                                                  snackbar(
                                                      "Please fill all the fields",
                                                      context);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Material(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white12
                                          : Colors.black12),
                                  borderRadius:
                                      BorderRadius.circular(R.rw(4, context)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: R.rh(16, context),
                                    bottom: R.rh(16, context),
                                    left: R.rh(16, context),
                                  ),
                                  child: Icon(
                                    Icons.add_circle,
                                    size: R.rw(40, context),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            final category = data.docs[index - 1];
                            return GestureDetector(
                              onTap: () {
                                ref.read(getCategoryIdProvider.notifier).state =
                                    category.id;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskScreen(
                                      categoryId: category.id,
                                      head: category
                                          .data()
                                          .categoryname
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Material(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white12
                                          : Colors.black12),
                                  borderRadius:
                                      BorderRadius.circular(R.rw(4, context)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: R.rh(16, context),
                                    bottom: R.rh(16, context),
                                    left: R.rh(16, context),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            category.data().emoji.toString(),
                                            style: TextStyle(
                                                fontSize: R.rw(20, context)),
                                          ),
                                          Text(
                                            category
                                                .data()
                                                .categoryname
                                                .toString(),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: R.rw(16, context),
                                            ),
                                          ),
                                          Text(
                                            "${category.data().tasks ?? 0} tasks",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  const Text("Are you sure ?"),
                                              content: const Text(
                                                  "This category will be deleted permanently."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    CategoryService()
                                                        .deleteCategory(
                                                            ref
                                                                .read(
                                                                    authStateProvider)
                                                                .value!
                                                                .uid,
                                                            category.id);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ));
                    } else {
                      return const SizedBox();
                    }
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                )
          ],
        ),
      ),
    );
  }
}
