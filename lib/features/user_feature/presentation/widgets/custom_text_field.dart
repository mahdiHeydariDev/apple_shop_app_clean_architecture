import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isSecret;
  bool haveError;
  String errorText;
  CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isSecret = false,
    this.haveError = false,
    this.errorText = '',
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
        bottom: 10,
      ),
      child: Column(
        children: <Widget>[
          TextField(
            controller: widget.controller,
            obscureText: isHide!,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: widget.haveError
                    ? const BorderSide(
                        color: ConstantsColors.red,
                        width: 3,
                      )
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.haveError == false
                      ? ConstantsColors.grey
                      : ConstantsColors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: ConstantsColors.blue,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              prefixIcon: Icon(
                widget.icon,
                size: 30,
              ),
              prefixIconColor: ConstantsColors.blue,
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
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.haveError ? widget.errorText : '',
              style: const TextStyle(
                color: ConstantsColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
