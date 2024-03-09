import 'dart:convert';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:web/web.dart';
import 'package:pdf/widgets.dart' as pw;

download(pw.Document pdf) async {
  var savedFile = await pdf.save();
  List<int> fileInts = List.from(savedFile);

  final anchorElement = HTMLAnchorElement();
  anchorElement.href =
      "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}";

  anchorElement.setAttribute(
      "download", "${DateTime.now().millisecondsSinceEpoch}.pdf");

  anchorElement.click();
}

Future<ImageProvider> getImage(String path) {
  return networkImage(path);
}
