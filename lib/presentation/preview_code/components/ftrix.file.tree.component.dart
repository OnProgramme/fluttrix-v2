import 'package:flutter/material.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';
import 'package:fluttrix/files/ftrix.file.dart';
import 'package:fluttrix/files/ftrix.folder.dart';
import 'package:fluttrix/utils/app.images.dart';

class FTrixFileTreeComponent extends StatefulWidget {
  final List<FTrixBaseFile> files;
  final String? selectedFileName;
  final ValueChanged<FTrixFile>? onFileTap;
  const FTrixFileTreeComponent({
    super.key,
    required this.files,
    this.selectedFileName,
    this.onFileTap,
  });

  @override
  State<FTrixFileTreeComponent> createState() => _FTrixFileTreeComponentState();
}

class _FTrixFileTreeComponentState extends State<FTrixFileTreeComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.files.map((file) => _buildFileItem(file, 0)).toList(),
    );
  }

  Widget _buildFileItem(FTrixBaseFile file, int depth) {
    if (file is FTrixFolder) {
      return _buildFolderItem(file, depth);
    } else if (file is FTrixFile) {
      return _buildFileRow(file, depth);
    }
    return SizedBox.shrink();
  }

  Widget _buildFileRow(FTrixFile file, int depth) {
    final isSelected = widget.selectedFileName == file.name;
    return InkWell(
      onTap: () => widget.onFileTap?.call(file),
      child: Container(
        padding: EdgeInsets.only(left: depth * 16.0, top: 6, bottom: 6),
        color: isSelected ? Colors.blue.withOpacity(.2) : Colors.transparent,
        child: Row(
          children: [
            Image.asset(
              AppImages.dart,
              width: 16,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                file.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFolderItem(FTrixFolder folder, int depth) {
    return Column(
      key: PageStorageKey<FTrixFolder>(folder),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              folder.isOpen = !folder.isOpen;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: Row(
              children: [
                Icon(
                  folder.isOpen
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.keyboard_arrow_right_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                Icon(
                  folder.isOpen ? Icons.folder_open : Icons.folder,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  folder.name,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
        if (folder.isOpen)
          ...folder.files.map((child) => _buildFileItem(child, depth + 1)),
      ],
    );
  }
}
