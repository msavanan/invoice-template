import 'dart:io';

import 'package:invoice/constant.dart';
import 'package:invoice/template_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

generatePdf({required TemplateType templateType}) async {
  final pdf = pw.Document();

  final netImage = await networkImage('https://www.nfet.net/nfet.jpg');

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          PdfHeader(netImage: netImage, templateType: templateType),
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 5, bottom: 5),
            height: 1,
            color: PdfColor.fromHex('#000000'),
          ),
          PdfBilling(templateType: templateType),
          pw.SizedBox(height: 10),
          pw.Text("INVOICE"),
          pw.SizedBox(height: 5),
          PdfTable(),
          pw.SizedBox(height: 10),
          PdfTotal(),
          pw.SizedBox(height: 10),
          pw.Text("Terms & Notes"),
          pw.SizedBox(height: 10),
          pw.Text(
              "Fred, thank you very much. We really appreciate your business.\nPlease send payments before the due date."),
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
  final pw.ImageProvider netImage;

  PdfHeader(
      {super.crossAxisAlignment = pw.CrossAxisAlignment.start,
      required this.netImage,
      required TemplateType templateType})
      : super(children: [
          pw.Image(netImage, width: 65, height: 65),
          pw.SizedBox(width: 10),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            ...HeaderKeys.leftList.map(
              (e) => pw.Text(templateType.getValue(e)),
            ),
          ]),
          pw.Spacer(),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            ...HeaderKeys.rightList.map(
              (e) => pw.Text(templateType.getValue(e)),
            ),
          ]),
        ]);
}

class PdfBilling extends pw.Row {
  PdfBilling({
    super.crossAxisAlignment = pw.CrossAxisAlignment.start,
    required TemplateType templateType,
  }) : super(children: [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            ...BillingKeys.leftList
                .map((e) => pw.Text(templateType.getValue(e)))
            // pw.Text("Bill to:"),
            // pw.Text("Slate Rock and Gravel Company"),
            // pw.Text("222 Rocky Way"),
            // pw.Text("30000 Bedrock, Cobblestone County"),
            // pw.Text("+555 7 123-5555"),
            // pw.Text("fred@slaterockgravel.bed")
          ]),
          pw.Spacer(),
          pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  ...BillingKeys.rightListOne
                      .map((e) => pw.Text(templateType.getValue(e)))
                ]),
            pw.SizedBox(width: 8),
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
              ...BillingKeys.rightListTwo
                  .map((e) => pw.Text(templateType.getValue(e)))
            ]),
            // pw.Text("Invoice No: 1"),
            // pw.Text("Invoice Date: 2024-03-02"),
            // pw.Text("Issue Date: 2024-03-02"),
            // pw.Text("Due Date: 2024-03-02"),
          ]),
        ]);
}

class PdfTable extends pw.Table {
  PdfTable()
      : super(children: [
          pw.TableRow(
            children: [
              pw.Text("Slno"),
              pw.Text("Item"),
              pw.Text("Quantity"),
              pw.Text("Price"),
              pw.Text("Discount"),
              pw.Text("Tax"),
              pw.Text("Amount")
            ],
          ),
          pw.TableRow(children: [
            pw.Text("01"),
            pw.Text("Frozen Brontosaurus Ribs"),
            pw.Text("1"),
            pw.Text("100"),
            pw.Text("0"),
            pw.Text("19"),
            pw.Text("100")
          ]),
          pw.TableRow(children: [
            pw.Text("02"),
            pw.Text("Lamb Steak"),
            pw.Text("1"),
            pw.Text("120"),
            pw.Text("0"),
            pw.Text("19"),
            pw.Text("120")
          ]),
          pw.TableRow(children: [
            pw.Text("02"),
            pw.Text("Steamed Fish"),
            pw.Text("1"),
            pw.Text("80"),
            pw.Text("0"),
            pw.Text("19"),
            pw.Text("80")
          ]),
        ]);
}

class PdfTotalRow extends pw.Row {
  final String row1;
  final String row2;
  PdfTotalRow({
    super.crossAxisAlignment = pw.CrossAxisAlignment.start,
    super.mainAxisAlignment = pw.MainAxisAlignment.end,
    required this.row1,
    required this.row2,
  }) : super(children: [
          // pw.Column(
          //     crossAxisAlignment: pw.CrossAxisAlignment.start,
          //     children: [pw.Text(row1)]),
          // pw.SizedBox(width: 20),
          // pw.Column(children: [pw.Text(row2)]),
          pw.Text(row1),
          pw.SizedBox(width: 20),
          pw.Text(row2)
        ]);
}

class PdfTotal extends pw.Column {
  PdfTotal({
    super.crossAxisAlignment = pw.CrossAxisAlignment.end,
  }) : super(children: [
          PdfTotalRow(row1: "Sub Total", row2: "300"),
          PdfTotalRow(row1: "Tax 19%", row2: "57"),
          PdfTotalRow(row1: "Total", row2: "357"),
        ]);
}
