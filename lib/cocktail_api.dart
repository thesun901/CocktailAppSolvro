import 'package:http/http.dart';
import 'dart:convert';

class Drink {
  final int id;
  final String name;
  final String category;
  final String glass;
  final String instructions;
  final String imageUrl;
  final bool alcoholic;

  Drink({
    required this.id,
    required this.name,
    required this.category,
    required this.glass,
    required this.instructions,
    required this.imageUrl,
    required this.alcoholic,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      glass: json['glass'],
      instructions: json['instructions'],
      imageUrl: json['imageUrl'],
      alcoholic: json['alcoholic'],
    );
  }
}

class DrinkDetailed {
  final int id;
  final String name;
  final String category;
  final String glass;
  final String instructions;
  final String imageUrl;
  final bool alcoholic;
  final List<Ingredient> ingredients;

  DrinkDetailed({
    required this.id,
    required this.name,
    required this.category,
    required this.glass,
    required this.instructions,
    required this.imageUrl,
    required this.alcoholic,
    required this.ingredients,
  });

  factory DrinkDetailed.fromJson(Map<String, dynamic> json) {
    var ingredientsFromJson = json['ingredients'] as List;
    List<Ingredient> ingredientList = ingredientsFromJson.map((ingredientJson) {
      return Ingredient.fromJson(ingredientJson);
    }).toList();

    return DrinkDetailed(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      glass: json['glass'],
      instructions: json['instructions'],
      imageUrl: json['imageUrl'],
      alcoholic: json['alcoholic'],
      ingredients: ingredientList,
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final String? description;
  final bool alcohol;
  final String? type;
  final int? percentage;
  final String? imageUrl;
  final String? measure;

  Ingredient({
    required this.id,
    required this.name,
    this.description,
    required this.alcohol,
    this.type,
    this.percentage,
    this.imageUrl,
    this.measure,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      alcohol: json['alcohol'] ?? false,
      type: json['type'],
      percentage: json['percentage'],
      imageUrl: json['imageUrl'],
      measure: json['measure'],
    );
  }
}

Future<List<Drink>> fetchDrinks(int page, int perPage) async {
  final response = await get(Uri.parse(
      'https://cocktails.solvro.pl/api/v1/cocktails?page=$page&perPage=$perPage'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<Drink> drinkList = [];
    List jsonList = jsonResponse['data'];

    for (Map<String, dynamic> element in jsonList) {
      drinkList.add(Drink.fromJson(element));
    }

    return drinkList;
  } else {
    return [];
  }
}

Future<DrinkDetailed> fetchDetailed(int id) async {
  final response =
      await get(Uri.parse('https://cocktails.solvro.pl/api/v1/cocktails/$id'));

  print(response.statusCode);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    print("decoded");

    return DrinkDetailed.fromJson(jsonResponse['data']);
  } else {
    throw Exception('Failed to load detailed drink');
  }
}
