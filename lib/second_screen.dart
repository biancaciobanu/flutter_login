import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final email;
  const SecondScreen({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100,),
          Text('welcome, $email',style: const TextStyle(fontSize: 10, color: Colors.black))
        ],
      ),
    );
  }
}