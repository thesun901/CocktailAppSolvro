import 'package:flutter/material.dart';
import 'cocktail_card.dart';
import 'cocktail_api.dart';
import 'cocktail_detailed.dart';
import 'constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: SafeArea(
          child: DrinksScreen(),
        ),
      ),
    );
  }
}

class DrinksScreen extends StatefulWidget {
  const DrinksScreen({super.key});

  @override
  DrinksScreenState createState() => DrinksScreenState();
}

class DrinksScreenState extends State<DrinksScreen> {
  List<Drink> drinks = [];
  List<Drink> filteredDrinks = [];
  int page = 1;
  int maxPage = 15;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDrinks();
    filteredDrinks = drinks;

    _searchController.addListener(_filterDrinks);

    //Listener for infinite scrolling - we dont want to fetch all drinks at once, just only when user gets to the bottom of already fetched list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading) {
        _fetchDrinks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _navigateToDetail(BuildContext context, int drinkId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      DrinkDetailed drinkDetail = await fetchDetailed(drinkId);

      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CocktailDetailed(drinkDetail),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load drink details $drinkId")),
      );
    }
  }

  void _filterDrinks() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredDrinks = drinks;
      } else {
        filteredDrinks = drinks.where((drink) {
          return (drink.name.toLowerCase().contains(query) ||
              drink.category.toLowerCase().contains(query) ||
              drink.glass.toLowerCase().contains(query) ||
              (drink.alcoholic && ALCOHOLIC_STRINGS.any((s) => s == query)) ||
              (!drink.alcoholic &&
                  NON_ALCOHOLIC_STRINGS.any((s) => s == query)));
        }).toList();

        if (page < maxPage && filteredDrinks.length < 5) {
          _fetchDrinks();
        }
      }
    });
  }

  Future<void> _fetchDrinks() async {
    if (page <= maxPage) {
      setState(() {
        isLoading = true;
      });

      List<Drink> newDrinks = await fetchDrinks(page, 15);
      setState(() {
        drinks.addAll(newDrinks);
        page++;
        isLoading = false;
        if (_searchController.text.isNotEmpty) {
          _filterDrinks();
        } else {
          filteredDrinks = drinks;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          leading: Icon(Icons.search),
          controller: _searchController,
          hintText: 'Search for a cocktail, glass, category etc...',
          onChanged: (query) {
            _filterDrinks();
          },
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: filteredDrinks.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < filteredDrinks.length) {
                return CocktailCard(
                  filteredDrinks[index],
                  onTapBehaviour: () =>
                      _navigateToDetail(context, filteredDrinks[index].id),
                );
              } else if (isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
