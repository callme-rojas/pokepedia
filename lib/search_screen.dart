import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  double hgToLbs(double weightInHg) {
    // Conversión de hg (hectogramos) a libras
    return weightInHg * 0.22046226;
  }

  double dmToFt(double heightInDm) {
    // Conversión de dm (decímetros) a pies
    return heightInDm * 0.32808399;
  }

  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      return;
    }

    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$query/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        searchResults = [
          {
            'name': data['name'],
            'types': data['types'],
            'spriteUrl': data['sprites']['front_default'],
            'weight': hgToLbs(data['weight']),
            'height': dmToFt(data['height']),
            'abilities': data['abilities'],
          }
        ];
      });
    } else {
      setState(() {
        searchResults = []; // Limpiar resultados si no se encuentra un Pokémon
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Pokémon'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration:
                  InputDecoration(labelText: 'Nombre o Número del Pokémon'),
              onSubmitted: (query) => searchPokemon(query),
            ),
          ),
          ElevatedButton(
            onPressed: () => searchPokemon(searchController.text),
            child: Text('Buscar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final pokemon = searchResults[index];
                final name = pokemon['name'];
                final types = pokemon['types'];
                final spriteUrl = pokemon['spriteUrl'];
                final weight = pokemon['weight'];
                final height = pokemon['height'];
                final abilities = pokemon['abilities'];

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  child: ExpansionTile(
                    leading: Image.network(spriteUrl, width: 100, height: 100),
                    title: Text(
                      name.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ListTile(
                        title: Text('Types: ${types.map((type) => type['type']['name']).join(', ')}'),
                      ),
                      ListTile(
                        title: Text('Weight: ${weight.toStringAsFixed(2)} lbs'),
                      ),
                      ListTile(
                        title: Text('Height: ${height.toStringAsFixed(2)} ft'),
                      ),
                      ListTile(
                        title: Text('Abilities: ${abilities.map((ability) => ability['ability']['name']).join(', ')}'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
