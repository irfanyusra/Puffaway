import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/Models/pod.dart';
import 'package:vape_app/services/database.dart';

import 'loading.dart';

class TimeSeriesBar extends StatefulWidget {

  @override
  _TimeSeriesBarState createState() => _TimeSeriesBarState();
}

class _TimeSeriesBarState extends State<TimeSeriesBar> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<charts.Series<TimeSeriesData, DateTime>> _seriesData = new List<charts.Series<TimeSeriesData, DateTime>>();
    List<TimeSeriesData> data = new List();

      return StreamBuilder<List<Pod>>(
          stream: DatabaseService(uid: user.uid).pods,
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              var podDates = snapshot.data;

              //add all data
              for(var i=1; i<podDates.length; i++) {
                var lastHitTime= DateTime.parse(
                    podDates[i-1].dateTime.toDate().toString());

                var current = DateTime.parse(
                    podDates[i].dateTime.toDate().toString());

                var diff = current.difference(lastHitTime);

                data.add(new TimeSeriesData(current, diff.inDays));

              }
              _seriesData.add(
                  charts.Series<TimeSeriesData, DateTime>(
                    id: 'Vaping Stats',
                    colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                    domainFn: (TimeSeriesData stats, _) => stats.time,
                    measureFn: (TimeSeriesData stats, _) => stats.podLength,
                    data: data,
                  )
                );

              return Container(
                height: 200, width: 400,
                  child: charts.TimeSeriesChart(
                  _seriesData,
                  animate: true,
                  defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                  defaultInteractions: false,
                  behaviors: [
                    new charts.SelectNearest(),
                    new charts.DomainHighlighter()
                  ],
                )
              );
            } else {
              return Loading();
            }
          }
      );
    }
  }

class TimeSeriesData {
  final DateTime time;
  final int podLength;

  TimeSeriesData(this.time, this.podLength);
}