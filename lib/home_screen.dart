import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> pokemonList = [];
  int offset = 0; // Índice de inicio de la próxima página
  int limit = 1008; // Cantidad de resultados a cargar en cada página
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (isLoading) return; // Evitar solicitudes duplicadas
    isLoading = true;

    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];

      if (results.isEmpty) {
        // Ya no hay más Pokémon para cargar
        isLoading = false;
        return;
      }

      for (var result in results) {
        final name = result['name'];
        final url = result['url'];
        final response = await http.get(Uri.parse(url));
        final pokemonData = json.decode(response.body);
        final types = pokemonData['types'];
        final spriteUrl = pokemonData['sprites']['front_default'];

        setState(() {
          pokemonList.add({
            'name': name.toUpperCase(), // Convierte el nombre a mayúsculas
            'types': types,
            'spriteUrl': spriteUrl,
          });
        });
      }

      setState(() {
        offset += limit; // Aumenta el índice de inicio para la próxima página
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: ListView.builder(
        itemCount: (pokemonList.length / 2).ceil(), // Divide en grupos de dos
        itemBuilder: (context, index) {
          final startIndex = index * 2;
          final endIndex = startIndex + 2;
          final pokemonGroup = pokemonList.sublist(startIndex, endIndex);

          return Row(
            children: pokemonGroup.map((pokemon) {
              final name = pokemon['name'];
              final types = pokemon['types'];
              final spriteUrl = pokemon['spriteUrl'];

              return Expanded(
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: spriteUrl,
                        width: 400, // Aumenta el tamaño del sprite
                        height: 200,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      ListTile(
                        title: Text(name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold)), // Estilo del nombre
                        subtitle: Text(
                            'Types: ${types.map((type) => type['type']['name']).join(', ')}'),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
