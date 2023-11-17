import 'package:flutter/material.dart';

PreferredSizeWidget home_app_bar = AppBar(
    backgroundColor: Colors.white,
    forceMaterialTransparency: true,
    centerTitle: true,
    title: const Text(
      "My Todo",
      style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontSize: 25),
    ));
