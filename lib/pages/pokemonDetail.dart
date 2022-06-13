import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  var pokemon;

  PokemonDetail({this.pokemon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return list of pokemon details with special attacks
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon['name']),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(pokemon['image'], height: 200),
            Text(pokemon['name'],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            // map pokemon special attacks to list of widgets
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  // round borders
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pokemon['attacks']['special'].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(pokemon['attacks']['special'][index]['name']
                          .toString()),
                      subtitle: Text(pokemon['attacks']['special'][index]
                              ['damage']
                          .toString()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
