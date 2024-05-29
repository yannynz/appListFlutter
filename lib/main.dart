import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Contato {
  String nome;
  String email;
  bool favorite;

  Contato(this.nome, this.email, {this.favorite = false});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaPage(),
    );
  }
}

class ListaPage extends StatefulWidget {
  ListaPage({Key? key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  List<Contato> contatos = [Contato('Sim', 'demo@demo.com')];

  void addContato(String nome, String email) {
    setState(() {
      contatos.add(Contato(nome, email));
    });
  }

  void removContato(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remover Contato'),
          content: Text('Deseja remover o contato do(a) ${contatos[index].nome}?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  contatos.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Não'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Lista de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(contatos[index].nome[0]),
            ),
            title: Text(contatos[index].nome),
            subtitle: Text(contatos[index].email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    setState(() {
                      contatos[index].favorite = !contatos[index].favorite;
                    });
                  },
                  color: contatos[index].favorite ? Colors.amber : Colors.grey,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    removContato(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String nome = '';
              String email = '';
              return AlertDialog(
                title: Text('Adicionar Contato'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Nome'),
                        onChanged: (value) {
                          nome = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      addContato(nome, email);
                      Navigator.of(context).pop();
                    },
                    child: Text('Adicionar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
