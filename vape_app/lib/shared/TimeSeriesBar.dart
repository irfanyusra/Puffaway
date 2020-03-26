import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/Models/pod.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/shared/loading.dart';

class TimeSeriesBar extends StatefulWidget {
  @override
  _TimeSeriesBarState createState() => _TimeSeriesBarState();
}

class _TimeSeriesBarState extends State<TimeSeriesBar> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<charts.Series<TimeSeriesData, DateTime>> _seriesData =
        new List<charts.Series<TimeSeriesData, DateTime>>();
    List<TimeSeriesData> data = new List();

    return StreamBuilder<List<Pod>>(
        stream: DatabaseService(uid: user.uid).pods,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var podDates = snapshot.data;

            //add all data
            for (var i = 1; i < podDates.length; i++) {
              var podStartDate =
                  DateTime.parse(podDates[i - 1].dateTime.toDate().toString());

              var podEndDate =
                  DateTime.parse(podDates[i].dateTime.toDate().toString());

              var diff = podStartDate.difference(podEndDate);

              data.add(new TimeSeriesData(podStartDate, diff.inDays));
            }
            _seriesData.add(charts.Series<TimeSeriesData, DateTime>(
              id: 'Vaping Stats',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (TimeSeriesData stats, _) => stats.time,
              measureFn: (TimeSeriesData stats, _) => stats.podLength,
              data: data,
            ));

            return Container(
                height: 230,
                width: 400,
                child: Center(
                    child: Column(children: <Widget>[
                  Text('How Long Pods Last',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: charts.TimeSeriesChart(
                    _seriesData,
                    animate: true,
                    defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                    defaultInteractions: false,
                    behaviors: [
                      new charts.SelectNearest(),
                      new charts.DomainHighlighter(),
                      new charts.ChartTitle('Pod Start Date',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea,
                          titleStyleSpec: charts.TextStyleSpec(fontSize: 10)),
                      new charts.ChartTitle('Pod Duration (Days)',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea,
                          titleStyleSpec: charts.TextStyleSpec(fontSize: 10))
                    ],
                  ))
                ])));
          } else {
            return Loading();
          }
        });
  }
}

class TimeSeriesData {
  final DateTime time;
  final int podLength;

  TimeSeriesData(this.time, this.podLength);
}
