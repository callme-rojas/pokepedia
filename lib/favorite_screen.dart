import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> favoritePokemonList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Favoritos'),
      ),
      body: ListView.builder(
        itemCount: favoritePokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = favoritePokemonList[index];
          final name = pokemon['name'];
          final types = pokemon['types'];
          final spriteUrl = pokemon['spriteUrl'];

          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Image.network(
                  spriteUrl,
                  width: 120,
                  height: 120,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('Types: ${types.map((type) => type['type']['name']).join(', ')}'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
