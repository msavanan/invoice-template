import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

download(pw.Document pdf) async {
  final output = await getDownloadsDirectory();

  final file = File("${output?.path ?? ''}/example.pdf");
  file.writeAsBytes(await pdf.save());
}

pw.MemoryImage getImage(String path) {
  return pw.MemoryImage(File(path).readAsBytesSync());
}
