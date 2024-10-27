import 'package:flutter/material.dart';
import 'cocktail_api.dart';

class CocktailCard extends StatefulWidget {
  final Drink drink;
  final VoidCallback onTapBehaviour;

  const CocktailCard(this.drink, {super.key, required this.onTapBehaviour});

  @override
  CocktailCardState createState() => CocktailCardState();
}

class CocktailCardState extends State<CocktailCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTapBehaviour(),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 3,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.drink.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.drink.category),
                  Text(widget.drink.glass),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    child: widget.drink.alcoholic
                        ? const Icon(Icons.local_drink)
                        : const Icon(Icons.no_drinks),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 200,
              height: 200,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(0, 0, 0, 0)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image.network(
                widget.drink.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
