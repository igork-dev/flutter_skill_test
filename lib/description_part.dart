import 'package:flutter/material.dart';
import 'package:test_task/recipe_model.dart';

class DescriptionPart extends StatelessWidget {
  const DescriptionPart({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    String formatted_id = recipe.id < 10 ? '0' + recipe.id.toString() : recipe.id.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              recipe.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              formatted_id,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Expanded(
          child: Text(
            recipe.description,
          ),
        ),
      ],
    );
  }
}
