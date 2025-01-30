import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/blocs/actividad_bloc.dart';
import 'data/repositories/actividad_repository.dart';
import 'presentation/screens/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActividadBloc(
        actividadRepo: ActividadRepo(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xff7869f3),
          primarySwatch: Colors.purple,),
        home: const SearchPage(),
      ),
    );
  }
}
