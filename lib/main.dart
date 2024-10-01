import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Título na Barra'),
        ),
        body: ListView(
          children: [
            Task('Título 1'),
            Task('Título 2'),
            Task('Título 3'),
            Task('Título 4'),
            Task('Título 5'),
            Task('Título 6'),
            Task('Título 7'),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed:(){}),
      )
    );
  }
}

class Task extends StatefulWidget {
  final String titulo;
  const Task(this.titulo,{super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Container(color: Colors.blue, height: 140,),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(color: Colors.black26, width: 72, height: 100,),
                      Container(
                          width: 200,
                          child: Text(this.widget.titulo, style: TextStyle(fontSize: 24, overflow: TextOverflow.ellipsis),)
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              setState(() {
                                nivel++;
                              });
                            },
                            child: Icon(Icons.arrow_drop_up)
                          ),
                          ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  nivel--;
                                });
                              },
                              child: Icon(Icons.arrow_drop_down)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Text('Nível $nivel')
              ],
            )
          ],
        ),
      ),
    );
  }
}


