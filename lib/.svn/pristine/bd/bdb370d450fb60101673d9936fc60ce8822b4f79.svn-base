import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  final controller = PageController(initialPage: 0);
  final entries = [
    Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orange, width: 5)),
      child: Image.asset('assets/logo.png'),
    ),
    Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orangeAccent, width: 5)),
      child: const Center(
        child: Text(
          "App designed for learning new languages and for the author to learn Flutter framework.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Container(
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: const Color.fromARGB(255, 248, 184, 101), width: 5)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              "Contact with the author:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            EmailRow(),
            LinkedinRow(),
            GithubRow(),
          ]),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About"),
          backgroundColor: Colors.orange,
        ),
        body: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller,
          padding: const EdgeInsets.all(10),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: entries[index]);
          },
        ));
  }
}

class EmailRow extends StatefulWidget {
  const EmailRow({super.key});
  @override
  State<EmailRow> createState() => _EmailRowState();
}

class _EmailRowState extends State<EmailRow> {
  IconData _copyIcon = Icons.copy_all;
  final String _email = "HubertR2019@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Icon(FontAwesomeIcons.envelopeCircleCheck, color: Colors.orange),
      Text(_email),
      IconButton(
          onPressed: (() async {
            await Clipboard.setData(ClipboardData(text: _email));
            setState(() {
              _copyIcon = Icons.check;
            });
          }),
          icon: Icon(_copyIcon))
    ]);
  }
}

class GithubRow extends StatefulWidget {
  const GithubRow({super.key});

  @override
  State<GithubRow> createState() => _GithubRowState();
}

class _GithubRowState extends State<GithubRow> {
  final _url = 'https://github.com/hbrt-rdzk';
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Icon(FontAwesomeIcons.github),
      const Text("Check app's source code:"),
      IconButton(
          onPressed: (() async {
            if (!await launchUrl(Uri.parse(_url))) {
              throw Exception('Could not launch $_url');
            }
          }),
          icon: const Icon(FontAwesomeIcons.arrowUpRightFromSquare))
    ]);
  }
}

class LinkedinRow extends StatefulWidget {
  const LinkedinRow({super.key});

  @override
  State<LinkedinRow> createState() => _LinkedinRowState();
}

class _LinkedinRowState extends State<LinkedinRow> {
  final _url = 'https://www.linkedin.com/in/hubert-rudzik-76253622b/';
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Icon(FontAwesomeIcons.linkedin, color: Colors.blueAccent),
      const Text("My linkedin profile:"),
      IconButton(
          onPressed: (() async {
            if (!await launchUrl(Uri.parse(_url))) {
              throw Exception('Could not launch $_url');
            }
          }),
          icon: const Icon(FontAwesomeIcons.arrowUpRightFromSquare))
    ]);
  }
}
