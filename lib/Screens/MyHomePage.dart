import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/dataprovider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final provider = dataProvider();
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
        title: const Text('Pokedex'),
      ),
      body: Padding(
        padding:EdgeInsets.all(8.0),
        child: Consumer<dataProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: provider.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = provider.pokemons[index];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.blue,child: Text(pokemon.id.toString()),),
                  title: Text(pokemon.weight),
                  subtitle: Text(pokemon.name),
                );
              },
            );
          },
        ),
      )
    );
  }
}

