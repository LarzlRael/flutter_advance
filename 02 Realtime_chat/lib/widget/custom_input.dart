import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: this.widget.textController,
        obscureText: this.widget.isPassword ? showPassword : false,
        keyboardType: this.widget.keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            this.widget.icon,
            color: Colors.blue,
          ),
          suffixIcon: this.widget.isPassword
              ? IconButton(
                  icon: showPassword
                      ? Icon(Icons.password)
                      : Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : null,
          hintText: this.widget.placeholder,
        ),
      ),
    );
  }
}
