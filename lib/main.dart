import 'package:flutter/material.dart';
import 'package:shopping/models/list_items.dart';
import 'package:shopping/models/shopping_list.dart';
import 'package:shopping/util/dbhelper.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // DbHelper helper = DbHelper();
    // helper.tesdDb();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Shopping List"),),
        body: ShList(),
      ),
    );
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingList;
  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
      itemCount: (shoppingList != null)? shoppingList.length : 0,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text(shoppingList[index].name),
          leading: CircleAvatar(
            child: Text(shoppingList[index].priority.toString()),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){},
          ),
        );
      },
    );
  }

  Future showData() async{
    await helper.openDb();
    // ShoppingList list = ShoppingList(0, 'Bakery', 2);
    // int listId = await helper.insertList(list);
    // Listitem item = Listitem(0, listId, "Bread", "note", "1 Kg");
    // int itemId = await helper.insertItem(item);
    // print("List Id: " + listId.toString());
    // print("Item Id: " + itemId.toString());
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}

