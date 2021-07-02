import 'package:flutter/material.dart';
import 'package:test_task/recipe_model.dart';

class ImagePart extends StatelessWidget {
  const ImagePart({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      recipe.pictureUrl,
    );
  }
}
