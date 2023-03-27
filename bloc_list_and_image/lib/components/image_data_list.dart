import 'package:bloc_list_and_image/blocs/bloc/list_bloc.dart';
import 'package:bloc_list_and_image/blocs/bloc/list_state.dart';
import 'package:bloc_list_and_image/components/image_data_list_item.dart';
import 'package:bloc_list_and_image/components/pop_up.dart';
import 'package:bloc_list_and_image/models/image_raw_data.dart';
import 'package:bloc_list_and_image/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageDataList extends StatefulWidget {
  ImageDataList({super.key, required this.items, this.selectedListItem});

  final List<ImageRawData> items;
  ImageRawData? selectedListItem;

  @override
  State<ImageDataList> createState() => _ImageDataListState();
}

class _ImageDataListState extends State<ImageDataList> {
  final Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return widget.items.isEmpty
        ? const Center(child: Text('No content to load. Please try again later!'))
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              var imageData = widget.items[index];
              return BlocConsumer<ListItemBloc, ListItemState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ImageDataListItem(
                    imageRawData: imageData,
                    onTap: () async {
                      var imageDetails;
                      setState(() {
                        if (widget.selectedListItem != null) {
                          widget.selectedListItem!.isSelected = false;
                        }
                        widget.items[index].isSelected = !widget.items[index].isSelected;
                        widget.selectedListItem = widget.items[index];
                      });

                      if (state.listItemStatus == ListItemStatus.normal) {
                        state.listItemStatus = ListItemStatus.selected;
                      }
                      try {
                        imageDetails = await repository.fetchImageDetails(imageData.name!);
                        await PopUpDialogs.openDialog(
                            imageDetails: imageDetails, context: context, title: imageDetails.name, message: imageDetails.text);
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
                    },
                    isSelected: null,
                  );
                },
              );
            },
            itemCount: widget.items.length,
          );
  }
}
