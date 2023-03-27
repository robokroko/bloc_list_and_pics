import 'package:bloc_list_and_image/components/image_data_list.dart';
import 'package:bloc_list_and_image/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_list_and_image/blocs/cubit/cubit/list_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint("new connectivity status: $result");
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void checkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      debugPrint("connected to a mobile network");
      Fluttertoast.showToast(
          msg: "No internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      debugPrint("connected to network");
    }
  }

  @override
  Widget build(BuildContext context) {
    checkStatus();
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        appBar: AppBar(title: const Text('List of Images')),
        body: orientation == Orientation.portrait
            ? BlocBuilder<ListCubit, ListState>(
                builder: (context, state) {
                  context.read<ListCubit>().fetchImageDataList();
                  return const ImageDateListView();
                },
              )
            : Row(
                children: [
                  BlocBuilder<ListCubit, ListState>(
                    builder: (context, state) {
                      context.read<ListCubit>().fetchImageDataList();
                      return const ImageDateListView();
                    },
                  )
                ],
              ));
  }
}

class ImageDateListView extends StatefulWidget {
  const ImageDateListView({super.key});

  @override
  State<ImageDateListView> createState() => _ImageDateListViewState();
}

class _ImageDateListViewState extends State<ImageDateListView> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ListCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return Center(
          child: Column(
            children: [
              const Text('Oops something went wrong! Please check the internet connection, and try to refresh!'),
              FloatingActionButton(
                  onPressed: () async {
                    try {
                      context.read<ListCubit>().fetchImageDataList();
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "No internet",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    setState(() {});
                  },
                  child: const Icon(Icons.refresh))
            ],
          ),
        );
      case ListStatus.success:
        return ImageDataList(items: state.items);
      case ListStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
