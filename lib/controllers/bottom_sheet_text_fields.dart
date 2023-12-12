import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';

OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: CupertinoColors.systemGrey));

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: Colors.red));

OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: Colors.black, width: 1));

class TextFieldBottomSheet extends StatelessWidget {
  const TextFieldBottomSheet(this.controller, this.fieldName,
      {this.isTask = false, Key? key})
      : super(key: key);
  final bool isTask;
  final TextEditingController? controller;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            "$fieldName",
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
          ),
        ),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: (isTask)
                ? ("Enter task ") + fieldName.toLowerCase()
                : ("Enter todo ") + fieldName.toLowerCase(),
            filled: true,
            fillColor: textFieldBg,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
          ),
          maxLines: (fieldName == "Title") ? 1 : 5,
          maxLength: (fieldName == "Title") ? 20 : 150,
          validator: (value) {
            if (value == null || value.trim() == "") {
              return "$fieldName can't be empty";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class DropDownCategory extends StatefulWidget {
  DropDownCategory({super.key, required this.setCategory});
  final Function(String?) setCategory;
  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  final List<String> _categoriesList = [
    "Work",
    "Leisure",
    "Office",
    "Important"
  ];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropDownList = _categoriesList
        .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 18))))
        .toList();

    return DropdownButtonFormField(
      hint: Text(
        "Category",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15),
      ),
      value: _selectedCategory,
      validator: (value) {
        if (value == null) {
          return "Select any category";
        }
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorBorder: errorBorder,
      ),
      items: dropDownList,
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
        widget.setCategory(_selectedCategory);
      },
    );
  }
}
