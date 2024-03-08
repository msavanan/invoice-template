import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/pdf/read_template_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

generatePdf() async {
  final pdf = pw.Document();

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          PdfHeader(),
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 5, bottom: 5),
            height: 1,
            color: PdfColor.fromHex('#000000'),
          ),
          PdfBilling(),
          pw.SizedBox(height: 10),
          PdfText(TableKeys.invoiceTitle),
          pw.SizedBox(height: 5),
          PdfTable(),
          pw.SizedBox(height: 10),
          PdfTotal(),
          pw.SizedBox(height: 10),
          PdfText(TermsKeys.termsLabel),
          pw.SizedBox(height: 10),
          PdfText(TermsKeys.terms),
        ]; // Center
      })); // Page

  final output = await getDownloadsDirectory();

  final file = File("${output?.path ?? ''}/example.pdf");
  file.writeAsBytes(await pdf.save());

  // var savedFile = await pdf.save();
  // List<int> fileInts = List.from(savedFile);
  // html.AnchorElement(
  //     href:
  //         "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
  //   ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
  //   ..click();
}

class PdfHeader extends pw.Row {
  PdfHeader({
    super.crossAxisAlignment = pw.CrossAxisAlignment.start,
  }) : super(children: [
          ReadTemplate.instance!.getValue(LayoutKeys.companyLogo).isNotEmpty
              ? pw.Image(
                  pw.MemoryImage(File(ReadTemplate.instance!
                          .getValue(LayoutKeys.companyLogo))
                      .readAsBytesSync()),
                  width: 65,
                  height: 65,
                  fit: pw.BoxFit.fill)
              : pw.SizedBox.shrink(),
          pw.SizedBox(width: 10),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            ...HeaderKeys.leftList.map(
              (e) => PdfText(e),
            ),
          ]),
          pw.Spacer(),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            ...HeaderKeys.rightList.map(
              (e) => PdfText(e),
            ),
          ]),
        ]);
}

class PdfBilling extends pw.Row {
  PdfBilling({
    super.crossAxisAlignment = pw.CrossAxisAlignment.start,
  }) : super(children: [
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [...BillingKeys.leftList.map((e) => PdfText(e))]),
          pw.Spacer(),
          pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [...BillingKeys.rightListOne.map((e) => PdfText(e))]),
            pw.SizedBox(width: 8),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [...BillingKeys.rightListTwo.map((e) => PdfText(e))]),
          ]),
        ]);
}

class PdfTable extends pw.Table {
  PdfTable()
      : super(children: [
          pw.TableRow(
            children: TableKeys.title.map((key) {
              final bool isItems = TableKeys.itemDescriptionLabel == key;

              return pw.Expanded(
                  flex: isItems ? 4 : 1,
                  child: PdfText(key, textAlign: pw.TextAlign.center));
            }).toList(),
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
          ),
          ...ReadTemplate.instance!.getItems().map((e) => pw.TableRow(
                children: [
                  ...e.keys.map(
                    (key) {
                      pw.TextAlign setTextAlign(String key) {
                        if (key == LayoutKeys.itemLineTotal) {
                          return pw.TextAlign.end;
                        } else if (key != TableKeys.itemDescription) {
                          return pw.TextAlign.center;
                        }
                        return pw.TextAlign.start;
                      }

                      return pw.Text(e[key].toString(),
                          textAlign: setTextAlign(key), softWrap: true);
                    },
                  )
                ],
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
              )),
        ]);
}

class PdfTotal extends pw.Column {
  PdfTotal({
    super.crossAxisAlignment = pw.CrossAxisAlignment.end,
  }) : super(children: [
          PdfTotalRow(
              key1: TotalKeys.amountSubtotalLabel,
              key2: TotalKeys.amountSubtotal),
          PdfTotalRow(key1: TotalKeys.taxName, key2: TotalKeys.taxValue),
          PdfTotalRow(
              key1: TotalKeys.amountTotalLabel, key2: TotalKeys.amountTotal)
        ]);
}

class PdfTotalRow extends pw.Row {
  final String key1;
  final String key2;
  PdfTotalRow({
    super.crossAxisAlignment = pw.CrossAxisAlignment.start,
    super.mainAxisAlignment = pw.MainAxisAlignment.end,
    required this.key1,
    required this.key2,
  }) : super(children: [
          pw.Text(key1 != TotalKeys.taxName
              ? ReadTemplate.instance!.getValue(key1)
              : ReadTemplate.instance!.getTaxValue(key1)),
          pw.SizedBox(width: 20),
          pw.Text(key2 != TotalKeys.taxValue
              ? ReadTemplate.instance!.getValue(key2)
              : ReadTemplate.instance!.getTaxValue(key2))
        ]);
}

class PdfText extends pw.Text {
  PdfText(
    String key, {
    super.style,
    super.textAlign,
    super.textDirection,
    super.softWrap,
    super.tightBounds,
    super.textScaleFactor,
    super.maxLines,
    TextOverflow? overflow,
  }) : super(ReadTemplate.instance!.getValue(key).toString());
}
