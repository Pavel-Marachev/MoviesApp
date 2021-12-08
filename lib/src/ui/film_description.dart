import 'package:bloc_app/src/blocs/movies_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bloc.filmDefinition(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Film is"),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Text(snapshot.data as String),
              ),
            ),
          );
        }
        return CupertinoActivityIndicator();
      },
    );
  }
}
