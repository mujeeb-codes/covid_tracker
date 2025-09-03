import 'package:flutter/material.dart';

class DetialsScreen extends StatefulWidget {
  final int deaths, cases, active, recovered;
  final String flag, country, continent;
  const DetialsScreen({
    required this.active,
    required this.cases,
    required this.country,
    required this.continent,
    required this.deaths,
    required this.flag,
    required this.recovered,
    super.key,
  });
  @override
  State<DetialsScreen> createState() => _DetialsScreenState();
}

class _DetialsScreenState extends State<DetialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.country,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "DMSerifText",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.blueGrey.withOpacity(.2),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  SizedBox(height: 200),
                  Card(
                    color: Colors.black,
                    child: Column(
                      children: [
                        resue(title: "Continent", value: widget.continent),
                        Divider(),
                        resue(title: "Cases", value: widget.cases.toString()),
                        Divider(),
                        resue(title: "Active", value: widget.active.toString()),
                        Divider(),
                        resue(
                          title: "Recovered",
                          value: widget.recovered.toString(),
                        ),
                        Divider(),
                        resue(title: "Deaths", value: widget.deaths.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.flag),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class resue extends StatefulWidget {
  final String title, value;
  const resue({required this.title, required this.value, super.key});

  @override
  State<resue> createState() => _resueState();
}

class _resueState extends State<resue> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "DMSerifText",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.value,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "DMSerifText",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
