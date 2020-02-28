import 'package:intl/intl.dart';

class Log {
  var dateT,
      trigger,
      thoughts,
      recommendation,
      stressors,
      progress,
      formatted_time,
      formatted_day;

  Log(trigger, thoughts, recommendation, stressors, progress) {
    //TODO: .now only if the field is empty -- in case someone wanted to login later?
    dateT = new DateTime.now();
    this.formatted_time = DateFormat.jms().format(dateT);
    this.formatted_day = DateFormat.yMMMMd().format(dateT);
    this.trigger = trigger;
    this.thoughts = thoughts;
    this.recommendation = recommendation;
    this.stressors = stressors;
    this.progress = progress;
  }

  //for quick log
  Log.quick(trigger) {
    dateT = new DateTime.now();
    this.trigger = trigger;
  }
}
