import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class SideBarTextfield extends StatelessWidget {
  const SideBarTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextFormField(
        autocorrect: false,
        style: textMedium,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          hintText: 'Search',

          hoverColor: Colors.transparent, // No hover color
          // Ensuring the borders look the same across different states
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
