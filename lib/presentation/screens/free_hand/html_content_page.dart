import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlContentPage extends StatelessWidget {
  final String data;

  const HtmlContentPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    if (data.isEmpty) {
      return const Center(
        child: Text(
          "No description available",
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      child: Html(
        data: data,
        style: {

          "body": Style(
            fontSize: FontSize(18),
            color: Colors.white70,
            lineHeight: LineHeight(1.5),
            textAlign: TextAlign.left,
          ),

          "strong": Style(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),

          "em": Style(
            color: Colors.tealAccent,
            fontStyle: FontStyle.italic,
          ),

          "li": Style(
            margin: Margins.only(bottom: 10),
          ),
        },
      ),
    );
  }
}