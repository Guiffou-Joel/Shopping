import 'package:flutter/material.dart';
import 'package:shopping/models/list_items.dart';
import 'package:shopping/models/shopping_list.dart';
import 'package:shopping/util/dbhelper.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  ItemsScreen(this.shoppingList);
  @override
  _ItemsScreenState createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;
  DbHelper helper;
  List<ListItem> items;
  _ItemsScreenState(this.shoppingList);
  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(shoppingList.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: Container(),
    );
  }

  Future showData(int idList) async{
    await helper.openDb();
    items = await helper.getItems(idList);
    setState(() {
      items= items;
    });
  }
}
