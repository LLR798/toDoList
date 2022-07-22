import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0445ce),
        title: const Text('Lista de tarefas',
        style: TextStyle(color: Color(0xFFF2F4F5),
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                height: 580,
                decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA),
                border: Border.all(
                  color: const Color(0xFFEAEAEA),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5)
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: tarefas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tarefas[index]),
                      onLongPress: () {
                        setState(() {
                          tarefas.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: const Color(0xFF0445CE),
            onPressed: () {
              _displayDialog();
            },
            tooltip: 'Add item',
            child: const Icon(
              Icons.add,
              color: Color(0xFFF2F4F5),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            backgroundColor: const Color(0xFF0445CE),
            onPressed: () {
              setState(() {
                tarefas = [];
              });
              _textEditingController.clear();
            },
            child: const Icon(
              Icons.delete,
              color: Color(0xFFF2F4F5),
            ),
          ),
        ],
      ),
    );
  }

  void addTarefas(String text) {
    setState(() {
      tarefas.add(_textEditingController.text);
    });
    _textEditingController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicione uma nova tarefa:'),
          content: TextField(
            autofocus: true,
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'Escreva sua tarefa:',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                return const Color(0xFFFF002A);
              })),
              child: const Text('Cancelar',
              style: TextStyle(color: Color(0xFFF2F4F5),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _textEditingController.clear();
              },
            ),
            TextButton(
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                return const Color(0xFF0445CE);
              })),
              child: const Text('Adicionar', 
              style: TextStyle(color: Color(0xFFF2F4F5),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                addTarefas(_textEditingController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
