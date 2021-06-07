import 'package:flutter/material.dart';
import 'package:shopping/models/list_items.dart';
import 'package:shopping/util/dbhelper.dart';
import 'package:shopping/models/shopping_list.dart';

class ListItemDialog{
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  Widget buildDialog(BuildContext context, ListItem item, bool isNew){
    DbHelper helper = DbHelper();
    if (!isNew){
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
      return AlertDialog(
        title: Text((isNew)? "New List Item" : "Edit List Item"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: txtName,
                decoration: InputDecoration(
                    hintText: "List Item Name"
                ),
              ),
              TextField(
                controller: txtQuantity,
                decoration: InputDecoration(
                    hintText: "List Item quantity"
                ),
              ),
              TextField(
                controller: txtNote,
                decoration: InputDecoration(
                    hintText: "Note on the List Item"
                ),
              ),
              RaisedButton(
                child: Text("Save Item"),
                onPressed: (){
                  item.name = txtName.text;
                  item.quantity = txtQuantity.text;
                  item.note = txtNote.text;
                  helper.insertItem(item);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    }
}