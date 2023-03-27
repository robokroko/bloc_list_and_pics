import 'package:bloc_list_and_image/blocs/bloc/list_bloc.dart';
import 'package:bloc_list_and_image/blocs/cubit/cubit/list_cubit.dart';
import 'package:bloc_list_and_image/repository/repository.dart';
import 'package:bloc_list_and_image/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListCubit>(
          create: (context) => ListCubit(repository: Repository()),
        ),
        BlocProvider<ListItemBloc>(
          create: (context) => ListItemBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/mainScreen': (BuildContext context) => const MainScreen(),
        },
        home: const MainScreen(),
      ),
    );
  }
}
