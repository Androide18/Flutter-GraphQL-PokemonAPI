import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../pages/pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String getPokemons = """
query getPokemons {
  pokemons(first: 10){
    id
    name
    image
    maxHP
    maxCP
    attacks {
      special {
        name
        damage
      }
    }
  }
}
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Query(
        options: QueryOptions(document: gql(getPokemons)),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          List pokemons = result.data!['pokemons'];
          // print(pokemons);

          return ListView.builder(
            shrinkWrap: true,
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(pokemons[index]['name']),
                subtitle: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("MaxHP " + pokemons[index]['maxHP'].toString(),
                            style: TextStyle(color: Colors.green)),
                        Text("MaxCP " + pokemons[index]['maxCP'].toString(),
                            style: TextStyle(color: Colors.green)),
                      ]),
                ]),
                leading: Image.network(pokemons[index]['image']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonDetail(
                        pokemon: pokemons[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
