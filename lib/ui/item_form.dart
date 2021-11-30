import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_items/constants/themes.dart';
import 'package:menu_items/models/data_model.dart';
import 'package:menu_items/services/database_services.dart';

class ItemForm extends StatefulWidget {
  ItemForm(this.label, {Key? key}) : super(key: key);
  String label = "";

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  var image = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Themes.gradientBackground,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    widget.label,
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  elevation: 0.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        image == null
                            ? InkWell(
                                onTap: () async {
                                  XFile? file = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  image = File(file!.path);
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 50,
                                      ),
                                      Text("Add Image")
                                    ],
                                  ),
                                ))
                            : displayImage(),
                        const SizedBox(height: 20),
                        formField("Name", nameController),
                        const SizedBox(height: 20),
                        formField("Description", descriptionController),
                        const SizedBox(height: 20),
                        formField("Price", priceController),
                        const SizedBox(height: 20),
                        formField("Category", categoryController),
                        const SizedBox(height: 20),
                        submitButton(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  displayImage() {
    return Container(
        height: 200,
        child: Stack(
          children: [
            Image.file(image),
            InkWell(
                onTap: () {
                  image == null;
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
        ));
  }

  submitButton() {
    return InkWell(
      onTap: () {
        ItemModel item = ItemModel(
            name: nameController.text,
            description: descriptionController.text,
            price: priceController.text,
            image: "",
            category: categoryController.text);
        DatabaseServices().addItem(item, image);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Themes.menuItemBg, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: Text("${widget.label}"),
      ),
    );
  }

  formField(label, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
