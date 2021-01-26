import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'RandomWords.dart';

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  int cnt =0;
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
        ),
        body: _buildSuggestions(),
      );
    }

  Widget _buildSuggestions() {
    cnt=0;
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    
    return ListTile(
      leading: _buildIndex(),
      title: _buildWord(pair),
      trailing: _buildIcon(alreadySaved) ,
      onTap: () {      // NEW lines from here...
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

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style:  new TextStyle(
                              fontSize: 20.0, 
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader= LinearGradient(colors: <Color>[Colors.blueAccent, Colors.redAccent])
                                                            .createShader(Rect.fromLTWH(50.0, 0.0, 100.0, 50.0)),
                            ),
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }

  Widget _buildIndex(){
    return Text(
        (++cnt).toString(),
        style: new TextStyle(
          fontSize: 20.0, 
          fontWeight: FontWeight.bold,
          foreground: Paint()..shader= LinearGradient(colors: <Color>[Colors.blueAccent, Colors.redAccent])
                                        .createShader(Rect.fromLTWH(0.0, 0.0, 1.0, 10.0)),
        ));
  }

  Widget _buildWord(WordPair pair){
    return Text(
        pair.asPascalCase,
        style: new TextStyle(
          fontSize: 20.0, 
          fontWeight: FontWeight.bold,
          foreground: Paint()..shader= LinearGradient(colors: <Color>[Colors.blueAccent, Colors.redAccent])
                                        .createShader(Rect.fromLTWH(50.0, 0.0, 100.0, 50.0)),
        ),
      
      );
  }

  Widget _buildIcon( bool alreadySaved){
    return Icon(   // NEW from here... 
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.blue,
      );
  }
}