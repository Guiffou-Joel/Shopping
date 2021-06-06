import 'package:flutter/material.dart';
import 'package:shopping/models/list_items.dart';
import 'package:shopping/models/shopping_list.dart';
import 'package:shopping/util/dbhelper.dart';
import 'package:shopping/ui/items_screen.dart';
import 'package:shopping/ui/shopping_list_dialog,dart.dart';

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
      home: ShList(),
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
  ShoppingListDialog dialog;

  @override
  void initState() {
    dialog = ShoppingListDialog();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(title: Text("Shopping List"),),
      body: ListView.builder(
        itemCount: (shoppingList != null)? shoppingList.length : 0,
        itemBuilder: (BuildContext context, int index){
          return Dismissible(
              key: Key(shoppingList[index].name),
              onDismissed: (direction){
                String strName = shoppingList[index].name;
                helper.deleteList(shoppingList[index]);
                setState(() {
                  shoppingList.removeAt(index);
                });
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("${strName} deleted")));
              },
              child: ListTile(
                title: Text(shoppingList[index].name),
                leading: CircleAvatar(
                  child: Text(shoppingList[index].priority.toString()),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog.buildDialog(
                          context,
                          shoppingList[index],
                          false,
                        )
                    );
                  },
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemsScreen(shoppingList[index])
                    ),
                  );
                },
              ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) => dialog.buildDialog(
              context,
              ShoppingList(0, "", 0),
              true
            ),
          );
        },
      ),
    );
  }

  Future showData() async{
    await helper.openDb();
    // ShoppingList list = ShoppingList(0, 'Bakery', 2);
    // int listId = await helper.insertList(list);
    // ListItem item = ListItem(0, listId, "Bread", "note", "1 Kg");
    // int itemId = await helper.insertItem(item);
    // print("List Id: " + listId.toString());
    // print("Item Id: " + itemId.toString());
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}

