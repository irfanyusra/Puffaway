import 'package:flutter/material.dart';
import 'package:vape_app/PodLoader/liquid_custom_progress_indicator.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:vape_app/shared/Calendar.dart';
import 'package:vape_app/PodLoader/PodPainter.dart';
import 'package:vape_app/PodLoader/ProgressBar.dart';
import 'package:vape_app/shared/Timer.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Path _buildVapePath() {
    return Path()
    ..moveTo(0, 100*0.45)
    ..lineTo(50*0.1, 100*0.45)
    ..lineTo(50*0.25, 100*0.375)
    ..lineTo(50*0.75, 100*0.375)
    ..lineTo(50*0.9, 100*0.45)
    ..lineTo(50, 100*0.45)
    ..lineTo(50, 100*0.875)
    ..lineTo(50*0.85, 100)
    ..lineTo(50*0.15, 100)
    ..lineTo(0, 100*0.875)
    ..lineTo(0, 100*0.45)
    ..lineTo(50*0.1, 100*0.45)
    ..close();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Log>>.value(
      value: DatabaseService(uid:user.uid).logs,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right:20.0),
              child: GestureDetector(
                onTap: (){},
                child: Icon(
                  Icons.settings,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(child: Text("Time Since Last Hit", style: TextStyle(fontSize: 20))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: timer(),
              ),
              LiquidCustomProgressIndicator(
                  value: 0.2, // Defailts to 0.5.
                  valueColor: AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
                  backgroundColor: Colors.grey.withOpacity(0.5), // Defaults to the current Theme's backgroundColor.
                  direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right).
                  shapePath: _buildVapePath(), // A Path object used to draw the shape of the progress indicator.
            ),
              /*Center(
                child: CustomPaint(
                  painter: PodPainter(),
                  child: Container(
                    height: 100,
                    width: 50,
                  ),
                ),
              ),*/
              //ProgressBar(),
              Calendar(),
              ],
            ),
          ),
        )
    );
  }
}
