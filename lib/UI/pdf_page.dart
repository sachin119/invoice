import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GeneratePDF extends StatefulWidget {
  final Map data;
  const GeneratePDF({super.key, required this.data});

  @override
  State<GeneratePDF> createState() => _GeneratePDFState();
}

class _GeneratePDFState extends State<GeneratePDF> {
  Future<Uint8List> saveInvoice() async {
    double width = MediaQuery.of(context).size.width;
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/NotoSansJP-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    pw.ImageProvider? firstImage;
    pw.ImageProvider? secondImage;
    final logoImage = await networkImage('assets/logo.png');

    if (widget.data['images'][0] != null) {
      firstImage = await networkImage(widget.data['images'][0]);
    }

    if (widget.data['images'][1] != null) {
      secondImage = await networkImage(widget.data['images'][1]);
    }

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Image(logoImage, width: 200),
            pw.SizedBox(height: 20),
            pw.Text(
              '基本資料可上傳行照/身分證或駕照，僅填寫手機號碼即可。）',
              style: pw.TextStyle(fontSize: 18, font: ttf),
            ),
            pw.SizedBox(height: 20),
            pw.Padding(
                padding: pw.EdgeInsets.only(bottom: 20),
                child: pw.Row(children: [
                  firstImage != null
                      ? pw.Container(
                          width: 100,
                          height: 100,
                          decoration: pw.BoxDecoration(
                              image: pw.DecorationImage(image: firstImage),
                              borderRadius: pw.BorderRadius.circular(8),
                              border: pw.Border.all(color: PdfColors.grey)),
                        )
                      : pw.SizedBox(),
                  pw.SizedBox(width: 20),
                  secondImage != null
                      ? pw.Container(
                          width: 100,
                          height: 100,
                          decoration: pw.BoxDecoration(
                              image: pw.DecorationImage(image: secondImage),
                              borderRadius: pw.BorderRadius.circular(8),
                              border: pw.Border.all(color: PdfColors.grey)),
                        )
                      : pw.SizedBox()
                ])),
            ...List.generate(widget.data['textFields'].length, (index) {
              Map data = widget.data['textFields'].values.elementAt(index);
              return getFormRow(width, data['label'], data['data'], ttf);
            }),
            pw.SizedBox(height: 30),
            pw.SizedBox(
                width: width,
                child: pw.Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: pw.WrapAlignment.start,
                    direction: pw.Axis.horizontal,
                    children: [
                      ...List.generate(widget.data['checkBox'].length, (index) {
                        String dataKey =
                            widget.data['checkBox'].keys.elementAt(index);
                        bool value =
                            widget.data['checkBox'].values.elementAt(index);

                        return pw.SizedBox(
                            width: width / 8,
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  pw.Text("${dataKey}: ",
                                      style: pw.TextStyle(
                                          fontSize: 14, font: ttf)),
                                  pw.SizedBox(width: 12),
                                  pw.Text(value ? 'Yes' : 'No',
                                      style:
                                          pw.TextStyle(fontSize: 14, font: ttf))
                                ]));
                      })
                    ])),
            pw.SizedBox(height: 30),
            ...List.generate(widget.data['injuryList'].length, (index) {
              Map item = widget.data['injuryList'].elementAt(index);
              return (item['name'].text.isNotEmpty ||
                      item['idCardFontSize'].text.isNotEmpty ||
                      item['dob'].text.isNotEmpty ||
                      item['idCardFontSize'].text.isNotEmpty)
                  ? pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 12.0),
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey),
                          borderRadius: pw.BorderRadius.circular(6),
                        ),
                        padding: pw.EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: pw.Wrap(
                          direction: pw.Axis.horizontal,
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            pw.SizedBox(
                              width: width / 8,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('姓名: ',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                  pw.SizedBox(height: 12),
                                  pw.Text('${item['name'].text}',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                ],
                              ),
                            ),
                            pw.SizedBox(
                              width: width / 8,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('身分證字號: ',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                  pw.SizedBox(height: 12),
                                  pw.Text('${item['idCardFontSize'].text}',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                ],
                              ),
                            ),
                            pw.SizedBox(
                              width: width / 8,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('出生年月日: ',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                  pw.SizedBox(height: 12),
                                  pw.Text('${item['dob'].text}',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                ],
                              ),
                            ),
                            pw.SizedBox(
                              width: width / 8,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('關係: ',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                  pw.SizedBox(height: 12),
                                  pw.Text('${item['relation'].text}',
                                      style: pw.TextStyle(
                                          font: ttf, fontSize: 14)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : pw.SizedBox();
            }),
          ]; // Center
        }));

    return pdf.save(); // Page
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      canDebug: false,
      canChangeOrientation: false,
      canChangePageFormat: false,
      maxPageWidth: 700,
      build: (format) => saveInvoice(),
    );
  }

  pw.Widget getFormRow(double width, String label, String data, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: Device.screenType == ScreenType.mobile ? 120 : 160,
            child: pw.Text(
              "$label: ",
              style: pw.TextStyle(
                  fontSize: 14, fontWeight: pw.FontWeight.bold, font: font),
            ),
          ),
          pw.SizedBox(width: 12),
          pw.Text(
            data,
            style: const pw.TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
