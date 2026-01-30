import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tareas',
      home: const TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _controller = TextEditingController();

  // Lista de tareas
  List<Map<String, dynamic>> tareas = [];

  void agregarTarea() {
    if (_controller.text.trim().isEmpty) {
      return; // Evita tareas vacías
    }

    setState(() {
      tareas.add({
        'titulo': _controller.text,
        'completada': false,
      });
      _controller.clear();
    });
  }

  void eliminarTarea(int index) {
    setState(() {
      tareas.removeAt(index);
    });
  }

  void completarTarea(int index, bool? valor) {
    setState(() {
      tareas[index]['completada'] = valor!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Tareas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nueva tarea',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: agregarTarea,
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: tareas[index]['completada'],
                    onChanged: (valor) =>
                        completarTarea(index, valor),
                  ),
                  title: Text(
                    tareas[index]['titulo'],
                    style: TextStyle(
                      decoration: tareas[index]['completada']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => eliminarTarea(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
