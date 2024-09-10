import 'package:d5n_interview/controller/user_service.dart';
import 'package:d5n_interview/utils/dynamic_sizing.dart';
import 'package:d5n_interview/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            title: const Text(
              "Settings",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true),
        body: ref.watch(getUserProvider).when(
              data: (data) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: R.rw(30, context),
                        backgroundImage: const NetworkImage(
                            "https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp"),
                      ),
                      title: Text(
                        "${data!.data()!.name[0].toUpperCase()}${data.data()!.name.substring(1)}",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data.data()!.email,
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                      ),
                      trailing: Material(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white12
                              : Colors.black,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: R.rh(10, context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: R.rh(8, context),
                          horizontal: R.rw(20, context)),
                      child: Text(
                        "Hi!My name is ${data.data()!.name[0].toUpperCase()}${data.data()!.name.substring(1)}, I'm a community manager from Rabat, Morocco.",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: R.rh(50, context),
                    ),
                    const ListTileWidget(
                        text: "Notifications", icon: Icons.notifications),
                    const ListTileWidget(text: "General", icon: Icons.settings),
                    const ListTileWidget(text: "Account", icon: Icons.person),
                    const ListTileWidget(text: "About", icon: Icons.info),
                  ],
                );
              },
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              loading: () => const Center(child: CircularProgressIndicator()),
            ));
  }
}
