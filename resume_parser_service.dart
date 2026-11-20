import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ResumeParserService {
  static Future<Map<String, String>> parsePdf(
    Uint8List bytes,
  ) async {
    final document = PdfDocument(inputBytes: bytes);

    try {
      final text = PdfTextExtractor(document).extractText();
      final lines = text
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final emailMatch = RegExp(
        r'[\w.+-]+@[\w.-]+\.[a-zA-Z]{2,}'
      ).firstMatch(text);

      final phoneMatch = RegExp(
        r'(?:\+91[\s-]?)?[6-9]\d{9}'
      ).firstMatch(text.replaceAll(RegExp(r'[\s-]'), ''));

      String findSection(List<String> keywords) {
        for (final line in lines) {
          if (keywords.any(
            (word) => line.toLowerCase().contains(word),
          )) {
            return line;
          }
        }
        return '';
      }

      String name = '';

      for (final line in lines.take(8)) {
        if (!line.contains('@') &&
            !RegExp(r'\d').hasMatch(line) &&
            line.length > 2 &&
            line.length < 50) {
          name = line;
          break;
        }
      }

      return {
        'name': name,
        'email': emailMatch?.group(0) ?? '',
        'phone': phoneMatch?.group(0) ?? '',
        'education': findSection([
          'education', 'qualification', 'b.tech',
          'degree', 'university'
        ]),
        'skills': findSection([
          'skills', 'technical skills', 'technologies'
        ]),
        'experience': findSection([
          'experience', 'internship', 'work experience'
        ]),
      };
    } finally {
      document.dispose();
    }
  }
}