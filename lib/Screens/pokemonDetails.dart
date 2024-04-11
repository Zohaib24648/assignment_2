import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:assignment_2/Providers/dataprovider.dart';
import 'package:assignment_2/Models/pokemonModel.dart';
import 'package:assignment_2/Screens/pokemonDetails.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  var colors;

   PokemonDetails({super.key, required this.pokemon,required this.colors});

  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [ Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,shadowColor: Colors.transparent,),
        body: Consumer<dataProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Text(pokemon.name,style: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text('#0${pokemon.id.toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white.withOpacity(0.8)),),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Container(padding: const EdgeInsets.all(8),decoration: BoxDecoration( borderRadius:BorderRadius.circular(15),color: Colors.black.withOpacity(0.3),),child: Text(pokemon.type.join(', '),style: const TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.bold),)),
                    const Spacer()
                    ],
                  ), // Join the types with a comma
                ),

              ],

            );
          },
        ),backgroundColor: colors,
        bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            TextStyle textStyle1 =  const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            );
            TextStyle textStyle2 = const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            );

            return  SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // Adjust the height as needed
              child: Container(
                margin: const EdgeInsets.only(top: 45, left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text('Name:', style: textStyle1))),
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text(pokemon.name, style: textStyle2))),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text('Height:', style: textStyle1))),
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text(pokemon.height, style: textStyle2))),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text('Weight:', style: textStyle1))),
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text(pokemon.weight, style: textStyle2))),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text('Spawn Time:', style: textStyle1))),
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text(pokemon.spawnTime, style: textStyle2))),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text('Weaknesses:', style: textStyle1))),
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text(pokemon.weaknesses.join(', '), style: textStyle2))),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text('Previous Evolution:', style: textStyle1))),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: pokemon.prevEvolution.isEmpty
                                ? Text('Just Hatched', style: textStyle2)
                                : Text(pokemon.prevEvolution[0].name, style: textStyle2),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(margin: const EdgeInsets.all(5), child: Text('Next Evolution:', style: textStyle1))),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: pokemon.nextEvolution.isNotEmpty
                                ? Text(pokemon.nextEvolution[0].name, style: textStyle2)
                                : Text('Maxed Out', style: textStyle2),
                          ),
                        ),
                      ],
                    ),
                    // Add more rows as needed
                  ],
                ),
              ),
            );

          },
        ),
      ),
       Positioned(
         left: 0,
         right: 0,
         bottom: (MediaQuery.of(context).size.width*0.5)+150,
         child: SizedBox(
           width: MediaQuery.of(context).size.width,
           height: 300,
           child: Hero(
              tag: pokemon.id
               ,child: Image.network(pokemon.img, fit: BoxFit.fitHeight)),
         ),
       ),
    ]);
  }
}
