import 'package:flutter/material.dart';
import 'package:svg_icon/svg_icon.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType? keyboardType;
  bool obscureText;
  bool customObscureText = true;
  final ValueChanged<String>? onChanged;

  CustomTextField({
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFB2BBCA), width: 0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.hintText}",
                style: TextStyle(
                    fontFamily: "MontserratRegular",
                    fontSize: 12,
                    color: Color(0xFF323E48))),
            TextField(
              onChanged: widget.onChanged,
              obscureText: widget.obscureText
                  ? widget.customObscureText
                  : widget.obscureText,
              keyboardType: widget.keyboardType,
              style: TextStyle(
                  fontFamily: "MontserratMedium",
                  fontSize: 14,
                  color: Color(0xFF323E48)),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontFamily: "MontserratRegular",
                    fontSize: 14,
                    color: Color(0xFFB2BBCA)),
                border: InputBorder.none,
                suffixIcon: widget.obscureText
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.customObscureText =
                                !widget.customObscureText;
                          });
                        },
                        icon: SvgIcon(
                          widget.customObscureText
                              ? "assets/icon/visibleOffIcon.svg"
                              : "assets/icon/visibleIcon.svg",
                          width: 16,
                        ),
                      )
                    : Icon(null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
