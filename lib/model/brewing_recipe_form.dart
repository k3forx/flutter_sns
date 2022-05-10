import 'dart:math';

import 'package:flutter/material.dart';

class BrewingRecipeForm {
  final int id;
  final TextEditingController controller;
  final String text;

  BrewingRecipeForm({
    required this.id,
    required this.text,
    required this.controller,
  });

  factory BrewingRecipeForm.create(String text) {
    return BrewingRecipeForm(
      id: Random().nextInt(99999),
      text: text,
      controller: TextEditingController(text: text),
    );
  }

  BrewingRecipeForm change(String text) {
    return BrewingRecipeForm(
      id: id,
      text: text,
      controller: controller,
    );
  }

  void dispose() {
    controller.dispose();
  }

  @override
  String toString() {
    return text;
  }
}
