class Log{

  var dateT, trigger, thoughts, recommendation;

  Log(trigger, thoughts, recommendation){
    dateT = new DateTime.now();
    this.trigger = trigger;
    this.thoughts = thoughts;
    this.recommendation = recommendation;
  }

  //for quick log
  Log.quick(trigger){
    dateT = new DateTime.now();
    this.trigger = trigger;
  }


}