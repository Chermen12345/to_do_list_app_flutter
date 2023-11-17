import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/data/models/todo.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_bloc.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_event.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_state.dart';
import 'package:to_do_list/features/todolist/presentation/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  int tasks_amount = 0;
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = GetNotesBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetNotes());
    widget.tasks_amount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: home_app_bar,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () {
              showAddDialog(context);
            },
            backgroundColor: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Remaining tasks: (${widget.tasks_amount})",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
            ),
            Expanded(
              child: BlocBuilder<GetNotesBloc, GetNotesState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is GetNotesLoaded) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      setState(() {
                        widget.tasks_amount = state.note_list.length;
                      });
                    });
                    if (state.note_list.isEmpty) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Center(
                              child: Lottie.asset(
                                "animations/todo_anim.json",
                              ),
                            ),
                          ),
                          const Text(
                            "you don't have any todos",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      );
                    } else {
                      return ListView.builder(
                          itemCount: state.note_list.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 10, right: 20),
                                              child: Text(
                                                state.note_list[i].title,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  bottom: 20,
                                                  top: 5,
                                                  right: 20),
                                              child: Text(
                                                  state.note_list[i].content),
                                            )
                                          ]),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 10),
                                          child: IconButton(
                                              onPressed: () {
                                                showUpdateDialog(
                                                    i,
                                                    state.note_list[i],
                                                    context);
                                              },
                                              icon: const Icon(Icons.edit)),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, right: 10),
                                            child: IconButton(
                                                onPressed: () {
                                                  _bloc.add(DeleteNote(i));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12))),
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        content: const Text(
                                                            "deleted successfully")),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }
                  return Center();
                },
              ),
            )
          ],
        ));
  }

  void showAddDialog(BuildContext ctxt) {
    showDialog(
        context: ctxt,
        builder: (ctxt) {
          TextEditingController title_contr = TextEditingController();
          TextEditingController content_contr = TextEditingController();
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text("add your note"),
            content: SizedBox(
              height: 200,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: title_contr,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 5, right: 0, top: 0, bottom: 0),
                          hintText: "type the title of your todo",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: content_contr,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 5, right: 0, top: 0, bottom: 0),
                        hintText: "type the description of your todo",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    if (title_contr.text.isNotEmpty &&
                        content_contr.text.isNotEmpty) {
                      _bloc.add(AddNote(title_contr.text, content_contr.text));

                      Navigator.pop(ctxt);
                    } else {
                      print("something is empty");
                    }
                  },
                  child: Text("Add Note")),
            ],
          );
        });
  }

  void showUpdateDialog(int index, ToDo toDo, BuildContext ctx) {
    TextEditingController title_contr = TextEditingController(text: toDo.title);
    TextEditingController content_contr =
        TextEditingController(text: toDo.content);
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text("Update your todo"),
            content: SizedBox(
              height: 200,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      controller: title_contr,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 5, right: 0, top: 0, bottom: 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: content_contr,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 5, right: 0, top: 0, bottom: 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (title_contr.text.isNotEmpty &&
                        content_contr.text.isNotEmpty) {
                      Navigator.pop(ctx);
                      ToDo new_todo =
                          ToDo(title_contr.text, content_contr.text);
                      _bloc.add(UpdateNote(index, new_todo));
                    }
                  },
                  child: Text("Update"))
            ],
          );
        });
  }
}
