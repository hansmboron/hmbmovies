import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieHeader extends StatelessWidget {
  const MovieHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.27,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: Get.width,
            child: Image.asset(
              'assets/images/header.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: Get.width * 0.9,
            padding: const EdgeInsets.only(bottom: 30),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Procurar Filmes',
                labelStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(Icons.search),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          )
        ],
      ),
    );
  }
}
