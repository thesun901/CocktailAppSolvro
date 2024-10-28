import 'package:flutter/material.dart';
import 'cocktail_api.dart';

class CocktailDetailed extends StatelessWidget {
  final DrinkDetailed detailed;

  const CocktailDetailed(this.detailed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailed.name),
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        detailed.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    detailed.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Category: ${detailed.category}"),
                  Text("Glass Type: ${detailed.glass}"),
                  Text("Alcoholic: ${detailed.alcoholic ? 'Yes' : 'No'}"),
                  const SizedBox(height: 16),
                  const Text(
                    "Instructions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(detailed.instructions),
                  const SizedBox(height: 16),
                  const Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  ...detailed.ingredients.map((ingredient) {
                    return ListTile(
                      leading: const Icon(
                        Icons.circle,
                        size: 10,
                      ),
                      title: Text(ingredient.name),
                      subtitle: Text(ingredient.measure ?? ""),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
