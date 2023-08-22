import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 10,
            left: 10,
            child: AlertDialog(
              content: Text(
                errorMessage,
                style: TextStyle(
                  color: Color(0xFFAE2D3C),
                  fontSize: 12.0,
                  fontFamily: "MontserratMedium",
                ),
              ),
              backgroundColor: Color(0xFFEAD5D8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
                side: BorderSide(color: Color(0xFFAE2D3C)),
              ),
              
            ),
          )
        ],
      ),
    );
  }
}
