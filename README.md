# CocktailApp

## About

Cocktail App is a simple application that allows user to search for cocktail recipies. CocktailApp uses [Cocktail API Solvro](https://cocktails.solvro.pl/) as a source of data. 

> [!NOTE]
> CocktailApp was developed as a recrutation task for the [KN Solvro](https://solvro.pwr.edu.pl/).

## Application Preview

### Main Functionalities

- Displaying cocktails in **infinite scroll** page
- Searching for cocktails by name
- Filtering cocktails by searching for category / glass / "non alcoholic" / "alcohilic" etc.
- Detailed preview of cocktails

### Screenshots

![main view](https://i.postimg.cc/FFfW7fnS/Simulator-Screenshot-i-Phone-16-Pro-2024-10-28-at-09-36-53.png)
![detailed view](https://i.postimg.cc/qB9mnk95/Simulator-Screenshot-i-Phone-16-Pro-2024-10-28-at-09-37-20.png)
![searching for a drink](https://i.postimg.cc/2yRZj85s/Simulator-Screenshot-i-Phone-16-Pro-2024-10-28-at-10-21-49.png)
![searching for alcohol-free drinks](https://i.postimg.cc/TYdZh2gv/Simulator-Screenshot-i-Phone-16-Pro-2024-10-28-at-10-11-21.png)


## Code

### Code Structure

* **main.dart**: The main entry point of the app.
* **drinks_screen.dart**: Contains the main UI for listing cocktails, search bar functionality, and filter logic.
* **cocktail_card.dart**: Definition of *CocktailCard* widged used on a main screen of application.
* **cocktail_detailed.dart**: Defines detailed view for each cocktail, accessible by tapping on a cocktail in the list.
* **cocktail_api.dart**: Handles API requests for fetching cocktail data. Defines *Drink* and *DrinkDetailed* classes that store data from API responses.
