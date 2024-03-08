import 'package:flutter/material.dart';

class CategoryDropdownWidget extends StatefulWidget {
  const CategoryDropdownWidget({
    super.key,
    this.selectedCategory,
    required this.onCategoryChanged,
  });
  final String? selectedCategory;
  final Function(String?) onCategoryChanged;

  @override
  CategoryDropdownWidgetState createState() => CategoryDropdownWidgetState();
}

class CategoryDropdownWidgetState extends State<CategoryDropdownWidget> {
  final List<String?> categories = ['Робота', 'Особисті справи', 'Спорт'];
  String? currentSelectedCategory;

  @override
  void initState() {
    super.initState();
    currentSelectedCategory = widget.selectedCategory;
  }

  @override
  void didUpdateWidget(covariant CategoryDropdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategory != oldWidget.selectedCategory) {
      setState(() {
        currentSelectedCategory = widget.selectedCategory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String?>(
      hint: const Text("Виберіть категорію"),
      value: currentSelectedCategory,
      isExpanded: true,
      items: [
        const DropdownMenuItem<String?>(
          value: '',
          child: Text("Без категорії"),
        )
      ]..addAll(
          categories.map(
            (String? value) {
              return DropdownMenuItem<String?>(
                value: value,
                child: Text(value!),
              );
            },
          ).toList(),
        ),
      onChanged: (newValue) {
        setState(() {
          currentSelectedCategory = newValue;
        });
        widget.onCategoryChanged(newValue);
      },
      underline: Container(
        height: 1,
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
