import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_rierpod/Providers/todo_provider.dart';
import 'package:learning_rierpod/model/todo_model.dart';

class Todo extends ConsumerWidget {
  Todo({super.key});
  final TextEditingController inputController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Todo DEMO"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: inputController,
                decoration: InputDecoration(
                    hintText: "Type your TODO",
                    hintStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onFieldSubmitted: (value) {
                  ref.watch(todosProvider.notifier).addTodo(TodoModel(
                      id: Random().nextInt(9999),
                      description: value,
                      completed: false));
                  showSnackBar(context);
                  inputController.text = "";
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(builder: (context, WidgetRef ref, child) {
                final todos = ref.watch(todosProvider);

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: todos.length,
                    itemBuilder: ((context, index) => ListTile(
                          title: Text(todos[index].description,
                              style: todos[index].completed
                                  ? TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.green)
                                  : null),
                          trailing: Checkbox(
                            value: todos[index].completed,
                            onChanged: (value) => ref
                                .read(todosProvider.notifier)
                                .toogleTodo(todos[index].id, value!),
                          ),
                        )));
              })
            ],
          ),
        ),
      ),
    );
  }
}

showSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

const snackBar = SnackBar(
    content: Text(
  "Todo added successfully",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
));
