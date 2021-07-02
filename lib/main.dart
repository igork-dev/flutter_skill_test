import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_task/recipe_model.dart';

import 'description_part.dart';
import 'image_part.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 18.0),
          headline6: TextStyle(fontSize: 18.0, color: Colors.black45, height: 1.5),
          bodyText2: TextStyle(fontSize: 16.0, color: Colors.black45, height: 1.5),
        ),
      ),
      home: MyHomePage(title: 'My Recipes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Recipe>>? recipesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipesFuture = getRepositoryFuture();
  }

  Future<List<Recipe>> getRepositoryFuture() async {
    var response = await fetchRecipes();
    final body = json.decode(response.body);
    // print(body[0]);
    List<Recipe> recepes = [];
    for (var r in body) {
      recepes.add(Recipe.fromJson(r));
    }
    recepes.sort((a, b) => a.id.compareTo(b.id));
    return recepes;
  }

  Future<http.Response> fetchRecipes() {
    return http.get(Uri.parse('https://raw.githubusercontent.com/ababicheva/FlutterInternshipTestTask/main/recipes.json'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {},
            )
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: recipesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListOfRecipes(
                      recipes: snapshot.data as List<Recipe>,
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class ListOfRecipes extends StatelessWidget {
  const ListOfRecipes({Key? key, required this.recipes}) : super(key: key);

  final List<Recipe>? recipes;
  final double _rowHeight = 100;
  final double _imageWidth = 120;
  final double _dividerOffset = 130;

  @override
  Widget build(BuildContext context) {
    List<Container> childrenWidgets = [];
    for (var recipe in recipes!) {
      var listChild = Container(
        height: _rowHeight,
        child: Row(
          //Выравнивание по верху
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _imageWidth,
              padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
              child: ImagePart(recipe: recipe),
            ),
            Container(
              width: MediaQuery.of(context).size.width - _imageWidth,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: DescriptionPart(recipe: recipe),
            ),
          ],
        ),
      );

      childrenWidgets.add(listChild);
    }

    return ListView.separated(
      itemCount: childrenWidgets.length,
      separatorBuilder: (BuildContext context, int index) => Container(
        padding: EdgeInsets.fromLTRB(_dividerOffset, 0, 0, 0),
        child: Divider(height: 1),
      ),
      itemBuilder: (BuildContext context, int index) {
        return childrenWidgets[index];
      },
    );
  }
}
