import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; 

//Creo la clase randomWords que estiende de Stateful Widget
// 
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
  
class RandomWordsState extends State<RandomWords> {
  //creo variables final "constantes que toman valor al incio de la aplicación"
  //ahora creo una lista de palabras del tipo WordPair esto viene del impor de palarbar en
  //ingles, textStyle es un widget de flutter material
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>(); 
  //Creo dos nuevos widgets privados que son _buildRow y buildSuggestions
  //widget para crear la fila de la lista
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red[400]: null,
    ),
    onTap: () {      // Add 9 lines from here...
      setState(() {
        if (alreadySaved) {
          _saved.remove(pair);
        } else { 
          _saved.add(pair); 
        } 
      });
    },   
    );
  }
  //Construccion de la lista
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // The itemBuilder callback is called once per suggested 
      // word pairing, and places each suggestion into a ListTile
      // row. For even rows, the function adds a ListTile row for
      // the word pairing. For odd rows, the function adds a 
      // Divider widget to visually separate the entries. Note that
      // the divider may be difficult to see on smaller devices.
      itemBuilder: (BuildContext _context, int i) {
        // Add a one-pixel-high divider widget before each row 
        // in the ListView.
        if (i.isOdd) {
          return new Divider();
        }

        // The syntax "i ~/ 2" divides i by 2 and returns an 
        // integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings 
        // in the ListView,minus the divider widgets.
        final int index = i ~/ 2;
        // If you've reached the end of the available word
        // pairings...
        if (index >= _suggestions.length) {
          // ...then generate 10 more and add them to the 
          // suggestions list.
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  
  _pushSaved() {
  Navigator.of(context).push(
    new MaterialPageRoute<void>(   // Add 20 lines from here...
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
          (WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();

          return new Scaffold(         // Add 6 lines from here...
          appBar: new AppBar(
            title: const Text('Words Save'),
            backgroundColor: Colors.red[400]
          ),
          body: new ListView(children: divided),
        );   
      },
    ),                           
  );
}

  @override                                 
  Widget build(BuildContext context) {
    return new Scaffold (                   // Add from here... 
      appBar: new AppBar(
        title: new Text('words'),
        backgroundColor: Colors.red[400],
          actions: <Widget>[      
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],  
      ),
      body: _buildSuggestions(),
    );

  }   
}