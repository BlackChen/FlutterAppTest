


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  @override
  createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  var _currentStep = 0;
  List<Step> _widgetList = [];

  _myStepper() {
    return Stepper(
      steps: _getStepList(),
      physics: AlwaysScrollableScrollPhysics(),
      type: StepperType.vertical,
      currentStep: _currentStep,
      onStepTapped: (index) {
        print('onStepTapped index = $index');
        setState(() {
          _currentStep = index;
        });
      },
      onStepContinue: () {
        print('onStepContinue');
        setState(() {
          if (_currentStep < _widgetList.length - 1) {
            _currentStep++;
          }
        });
      },
      onStepCancel: () {
        print('onStepCancel');
        setState(() {
          if (_currentStep > 0) {
            _currentStep--;
          }
        });
      },
    );
  }

  _myStep(int i) {
    return Step(
      title: Text('Step title$i'),
      subtitle: Text('Step subtitle$i'),
      content: Text('Step content$i'),
      state: _getStepState(i),
      isActive: _currentStep == i ? true : false,
    );
  }

  _getStepState(int i) {
    switch (i) {
      case 1:
        return StepState.editing;
      case 2:
        return StepState.disabled;
      case 3:
        return StepState.complete;
      case 4:
        return StepState.error;
      default:
        return StepState.indexed;
    }
  }

  _getStepList() {
    _widgetList.clear();
    for (var i = 0; i < 10; i++) {
      _widgetList.add(_myStep(i));
    }
    return _widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper'),
      ),
      body: _myStepper(),
    );
  }
}