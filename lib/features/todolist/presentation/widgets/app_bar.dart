import 'package:flutter/material.dart';

PreferredSizeWidget home_app_bar = AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Todo",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ));
