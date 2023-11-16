import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_bloc.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_event.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_state.dart';
import 'package:to_do_list/features/todolist/presentation/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: home_app_bar,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () {
              dialogShowing(context);
            },
            backgroundColor: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        body: BlocBuilder<GetNotesBloc, GetNotesState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is GetNotesLoaded) {
              return ListView.builder(
                  itemCount: state.note_list.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 20, right: 20),
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
                                      child: Text(state.note_list[i].content),
                                    )
                                  ]),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 10),
                                    child: IconButton(
                                        onPressed: () {
                                          _bloc.add(DeleteNote(
                                              state.note_list[i].content));
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
            return Center();
          },
        ));
  }

  void dialogShowing(BuildContext ctxt) {
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
                    width: double.infinity,
                    height: 40,
                    child: TextField(
                      controller: title_contr,
                      decoration: InputDecoration(
                          hintText: "type the title of your todo",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: content_contr,
                    decoration: InputDecoration(
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
}
