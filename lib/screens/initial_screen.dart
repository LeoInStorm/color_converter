import 'package:color_converter/components/task_color.dart';
import 'package:color_converter/data/task_color_dao.dart';
import 'package:color_converter/screens/converter_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
  
}

class _InitialScreenState extends State<InitialScreen> {
   void _refreshList() {
    setState(() => {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ColorAll'),
        leading: const Icon(Icons.color_lens_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<TaskColor>>(
            future: TaskColorDao().findALL(),
            builder: (context, snapshot) {
              List<TaskColor>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Carregando"),
                      ],
                    ),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Carregando"),
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Carregando"),
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final TaskColor tarefa = items[index];
                            return TaskColor(
                          selectedColor: tarefa.selectedColor,
                          hexValue: tarefa.hexValue,
                          rgbValue: tarefa.rgbValue,
                          hsvValue: tarefa.hsvValue,
                          hslValue: tarefa.hslValue,
                          onDelete: _refreshList,);
                          });
                    }
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.color_lens,
                            size: 128,
                          ),
                          Text(
                            "Adicione novas cores abaixo",
                            style: TextStyle(fontSize: 32),textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }
                  return const Text("Erro ao carregar Tarefas");
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConverterScreen(colorContent: context,))).then((value) => _refreshList());
      },child: const Icon(Icons.add),)
    );
  }
}
