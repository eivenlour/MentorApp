import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import '../../common/format_text.dart';
import '../../common/global_header.dart';
import '../../common/primary_button.dart';
import '../../constants/common_constants.dart';
import '../../constants/ftu_constants.dart';
import '../login_create_account/login_create_account.dart';

class OnboardingSteps extends StatefulWidget {
 
  OnboardingSteps({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnboardingSteps();
}

class _OnboardingSteps extends State<OnboardingSteps> {

  int stepIndex;
  double screenWidth, screenHeight;

  @override
  void initState() {
    super.initState();

    stepIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildHeader(),
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [ 
            buildSlidingContent(),
            buildFooter()
          ]
        )
      )
    );
  }

  GlobalHeader buildHeader() {
    var isLastStep = stepIndex == onboardingStepsConfig.length - 1;
    return isLastStep 
      ? GlobalHeader()
      : GlobalHeader(
        actionText: skipAction, 
        onActionTap: getSkipPage
      );
  }

  void getSkipPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginCreateAccount())
    );
  }

  Widget buildSlidingContent() {
    return SlideInRight(
      key: onboardingStepsConfig[stepIndex]["animatorKey"],
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.30),
        child: Column(
          children:[
            onboardingStepsConfig[stepIndex]["image"],
            Container(height: 1.5, color: Colors.black),
            buildOnboardingText()
          ]
        )
      )
    );
  }

  Widget buildOnboardingText() {
    var widthPadding = screenWidth * 0.24;
    var heightPadding = screenHeight * 0.15;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        widthPadding, 
        heightPadding, 
        widthPadding, 
        heightPadding
      ),
      child: FormatText(
        text: onboardingStepsConfig[stepIndex]["text"],
        textColor: Colors.black,
        textAlign: TextAlign.center,
        fontSize: 14.0,
        fontWeight: FontWeight.w500
      )
    );
  }

  Widget buildFooter() {
    return Positioned(
      bottom: screenHeight * 0.10,
      child: Column(
        children: <Widget>[
          buildCircleIndicators(),
          buildOnboardingButton()
        ]
      )
    );
  }

  Row buildCircleIndicators() {
    var circleDimensions = screenWidth * 0.01;
    var circles = <Widget>[];
    for (var i = 0; i < 3; i++) {
      circles.add(
        Container(
          width: circleDimensions, 
          height: circleDimensions, 
          margin: EdgeInsets.all(screenWidth * 0.02), 
          decoration: BoxDecoration(
            color: i == stepIndex ? 
              Theme.of(context).accentColor : Colors.grey, 
            shape: BoxShape.circle
          )
        )
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: circles
    );
  }

  Widget buildOnboardingButton() {
    return PrimaryButton(
      text: onboardingStepsConfig[stepIndex]["buttonText"],
      isLight: onboardingStepsConfig[stepIndex]["isLight"],
      onPressed: getNextStep
    );
  }

  void getNextStep() {
    if (stepIndex < 2) {
      setState(() { stepIndex += 1; });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginCreateAccount())
      );
    }
  }
}
