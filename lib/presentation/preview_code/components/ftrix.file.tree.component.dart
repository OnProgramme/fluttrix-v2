import 'package:flutter/material.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';
import 'package:fluttrix/files/ftrix.file.dart';
import 'package:fluttrix/files/ftrix.folder.dart';
import 'package:fluttrix/utils/app.images.dart';

class FTrixFileTreeComponent extends StatefulWidget {
  final List<FTrixBaseFile> files;
  const FTrixFileTreeComponent({super.key, required this.files});

  @override
  State<FTrixFileTreeComponent> createState() => _FTrixFileTreeComponentState();
}

class _FTrixFileTreeComponentState extends State<FTrixFileTreeComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.files.length,
      separatorBuilder: (context, index) => Container(
        height: 30, // Hauteur du séparateur
        color: Colors
            .grey.shade300, // Couleur temporaire pour visualiser l'espacement
      ),
      itemBuilder: (context, index) {
        final file = widget.files[index];
        return _buildFileItem(file);
      },
    );
  }

  Widget _buildFileItem(FTrixBaseFile file) {
    if (file is FTrixFolder) {
      return _buildFolderItem(file);
    } else if (file is FTrixFile) {
      return Row(
        children: [
          Image.asset(
            AppImages.dart,
            width: 16,
          ),
          SizedBox(width: 5),
          Text(
            file.name,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildFolderItem(FTrixFolder folder) {
    return Column(
      key: PageStorageKey<FTrixFolder>(folder),
      children: [
        InkWell(
          onTap: () {
            setState(() {
              folder.isOpen = !folder.isOpen;
            });
          },
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
        AnimatedContainer(
          padding: EdgeInsets.only(left: 17),
          duration: Duration(milliseconds: 200),
          constraints: BoxConstraints(maxHeight: folder.isOpen ? 500 : 0),
          child: SingleChildScrollView(
            child: Column(
              children: folder.files.map((child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _buildFileItem(child),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
