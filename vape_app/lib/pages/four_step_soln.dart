import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

class FourStepSoln extends StatefulWidget {
  @override
  _FourStepSolnState createState() => _FourStepSolnState();
}

class _FourStepSolnState extends State<FourStepSoln> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4 Step Solution'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Here we will explain how the four step solution is implemented in this application.',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              //Relabel
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                child: Column(children: <Widget>[
                  Container(
                    child: Text(
                      'Step 1: Relabel',
                      style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 2.0,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: EasyRichText(
                      "Take the pattern out of the autopilot and bring it to the conscious mind using mindfulness.",
                      defaultStyle: TextStyle(
                        color: Colors.grey[800],
                        letterSpacing: 2.0,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      patternList: [
                        EasyRichTextPattern(
                          targetString: 'mindfulness',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EasyRichText(
                        "Logging triggers provides the functionality to log if you felt the need to vape, have vaped, and if you finished a vape pod. This makes you more mindful of your bad habit as there are usually underlying causes. The progress screen shows the time since last hit which makes you more aware of how much you are vaping and the intervals.",
                        defaultStyle: TextStyle(
                            color: Colors.grey[700],
                            letterSpacing: 1.5,
                            fontSize: 16),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'Logging triggers',
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),

              //Reframe
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                child: Column(children: <Widget>[
                  Container(
                    child: Text(
                      'Step 2: Reframe',
                      style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 2.0,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: EasyRichText(
                      "Change one's perspective about the pattern and see it as it really is.",
                      defaultStyle: TextStyle(
                        color: Colors.grey[800],
                        letterSpacing: 2.0,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      patternList: [
                        EasyRichTextPattern(
                          targetString: 'really',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EasyRichText(
                        "Loading screen displays a different message or question to help reframe vaping as it really is.",
                        defaultStyle: TextStyle(
                            color: Colors.grey[700],
                            letterSpacing: 1.5,
                            fontSize: 16),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'Loading screen',
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),

              //Refocus
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                child: Column(children: <Widget>[
                  Container(
                    child: Text(
                      'Step 3: Refocus',
                      style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 2.0,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: EasyRichText(
                      " We need to understand that the only part of the pattern that we have control over is our actions.",
                      defaultStyle: TextStyle(
                        color: Colors.grey[800],
                        letterSpacing: 2.0,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      patternList: [
                        EasyRichTextPattern(
                          targetString: 'actions',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EasyRichText(
                        "Recommendations page shows custom recommendations based on the trigger chosen to help you refocus to a different and more meaningful task. This will slowly help you find a better alternative to vaping for different triggers.",
                        defaultStyle: TextStyle(
                            color: Colors.grey[700],
                            letterSpacing: 1.5,
                            fontSize: 16),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'Recommendations page',
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),

              //Refocus
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                child: Column(children: <Widget>[
                  Container(
                    child: Text(
                      'Step 4: Revalue',
                      style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 2.0,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: EasyRichText(
                      "Step back and see the bigger picture and see how this pattern affected your life negatively.",
                      defaultStyle: TextStyle(
                        color: Colors.grey[800],
                        letterSpacing: 2.0,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      patternList: [
                        EasyRichTextPattern(
                          targetString: 'Step back',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EasyRichText(
                        "Logging reflections provide you a safe space to talk about your vaping habits whenever you want, preferably at least once a every week to keep reminding you of your goals. A complementary feature is the statistics page which shows you the bigger picture that you can analyze.",
                        defaultStyle: TextStyle(
                            color: Colors.grey[700],
                            letterSpacing: 1.5,
                            fontSize: 16),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'Logging reflections',
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),

              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
