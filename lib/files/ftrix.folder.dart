import 'package:fluttrix/files/ftrix.base.file.dart';

class FTrixFolder extends FTrixBaseFile{
  @override
  String name;
  List<FTrixBaseFile> files;
  bool isOpen;
  FTrixFolder({required this.name, required this.files, this.isOpen = true});
}