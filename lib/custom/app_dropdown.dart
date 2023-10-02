
import 'package:flutter/material.dart';

class AppDropDown extends StatefulWidget {
  final List<String> dropDownItems;
  final String labelText;
  final String? dropdownValue;
  final void Function(String? value)? onChanged;
  final GlobalKey? dropdownKey;
  final String? hint;
  const AppDropDown(
      {Key? key,
      this.style,
      required this.dropDownItems,
      this.labelText = '',
      this.dropdownValue,
      this.onChanged,
      this.dropdownKey,
      this.hint,})
      : super(key: key);

  final TextStyle? style;

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    return  Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: widget.dropdownValue,
                    hint: Text(widget.hint??''),
                    items: widget.dropDownItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: widget.onChanged,
                  ),
                ),
              );
  }
}


