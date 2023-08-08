import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isSecret;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isSecret = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? isHide;
  @override
  void initState() {
    // TODO: implement initState
    isHide = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 25,
      ),
      child: TextField(
        obscureText: isHide!,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            widget.icon,
            size: 30,
          ),
          hintText: widget.hintText,
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isHide = !isHide!;
                    });
                  },
                  icon: Icon(
                    isHide == true
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
