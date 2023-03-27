import 'package:bloc_list_and_image/blocs/bloc/list_bloc.dart';
import 'package:bloc_list_and_image/blocs/bloc/list_state.dart';
import 'package:bloc_list_and_image/models/image_raw_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageDataListItem extends StatefulWidget {
  ImageDataListItem({
    Key? key,
    required this.imageRawData,
    this.onTap,
    this.isSelected,
  }) : super(key: key);

  final ImageRawData imageRawData;
  final VoidCallback? onTap;
  bool? isSelected = false;

  @override
  State<ImageDataListItem> createState() => _ImageDataListItemState();
}

class _ImageDataListItemState extends State<ImageDataListItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemBloc, ListItemState>(
      builder: (context, state) {
        return Material(
          color: widget.isSelected == true ? Colors.green : Colors.white,
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              children: [
                Text(widget.imageRawData.name.toString()),
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  imageUrl: widget.imageRawData.image!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
