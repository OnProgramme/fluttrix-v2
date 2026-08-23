import 'package:fluttrix/files/ftrix.base.file.dart';

class FTrixFile extends FTrixBaseFile {
  @override
  String name;
  String content;
  FTrixFile(this.name, {this.content = ''});
}
