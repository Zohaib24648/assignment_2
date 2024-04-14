import 'package:assignment_2/Screens/pokemonDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/dataprovider.dart';
import 'RetryableNetworkImage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final provider = dataProvider();
  Map<String, Color> typeColors = {
    'Poison': Colors.purple,
    'Ground': Colors.brown,
    'Rock': Colors.blueGrey,
    'Bug': Colors.lightGreen,
    'Ghost': Colors.indigo,
    'Steel': Colors.lime,
    'Fire': Colors.orange,
    'Water': Colors.blue,
    'Grass': Colors.green,
    'Electric': Colors.yellow,
    'Psychic': Colors.pink,
    'Ice': Colors.cyan,
    'Dragon': Colors.indigo,
    'Fairy': Colors.pink,
    'Fighting': Colors.red,
    'Normal': Colors.grey,
  };

  Color getAverageColor(List<String> types) {
    return typeColors[types[0]] ?? Colors.black;
    // int r = 0, g = 0, b = 0;
    // for (String type in types) {
    //   Color color = typeColors[type] ?? Colors.black; // Default to black if type not found
    //   r += color.red;
    //   g += color.green;
    //   b += color.blue;
    // }
    // int n = types.length;
    // return Color.fromRGBO(r ~/ n, g ~/ n, b ~/ n, 1);

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<dataProvider>(context, listen: false);
      provider.getAllPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Pokedex',style: TextStyle(fontWeight: FontWeight.bold,fontSize:25),)),

        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<dataProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the number of items per row
                crossAxisSpacing: 10, // Horizontal space between items
                mainAxisSpacing: 10, // Vertical space between items
                childAspectRatio: 1, // Aspect ratio of each item
              ),
              itemCount: provider.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = provider.pokemons[index];
                final colorpokemon = getAverageColor(pokemon.type);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PokemonDetails(
                          pokemon: pokemon,
                          colors: colorpokemon,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation:10, shadowColor: colorpokemon,
                    color: colorpokemon,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Hero(
                              tag: pokemon.id,
                              child: RetryableNetworkImage(
                                imageUrl: pokemon.img,
                                maxRetries: 3,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(pokemon.name,style: const TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),),
                            subtitle: Row(children:[ Container(padding: const EdgeInsets.fromLTRB(0,5,5,5),decoration: BoxDecoration( borderRadius:BorderRadius.circular(5),color: Colors.black.withOpacity(0.3),),child: Text(pokemon.type[0],style: const TextStyle(color: Colors.white,fontSize:13,fontWeight: FontWeight.bold),)),Spacer()]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },
            );
          },
        ),
      ),
    );
  }
}
