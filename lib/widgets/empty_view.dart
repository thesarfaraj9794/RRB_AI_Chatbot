import 'package:flutter/material.dart';

Widget emptyview(){
  return Expanded(
    child: Column(
      children: [
        const SizedBox(height: 50),
              const SizedBox(height: 50),
               Image.asset('assets/images/hi_bot.png', height: 220),
               const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                 child: Row(
                 mainAxisSize: MainAxisSize.min,
                  children: [
                   Icon(Icons.star, color: Colors.black87),
                     SizedBox(width: 5),
                    Text(
                       'Hi,you can ask me anything!',
                       style: TextStyle(color: Colors.black87),
                     ),
                   ],
                 ),
               ),
      ],
),
);
}
