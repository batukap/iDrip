import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.yellow, Colors.orange]),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.arrow_forward_sharp,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Başla",
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}