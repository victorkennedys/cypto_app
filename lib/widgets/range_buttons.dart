import 'package:flutter/material.dart';
import 'package:cypto_tracker_2/constants.dart';

class RangeSelector extends StatelessWidget {
  final String text;
  final Function selectRange;
  final DateTime functionInput;
  final Color color;

  RangeSelector(this.text, this.selectRange, this.functionInput, this.color);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlatButton(
        color: color,
        child: Text(text),
        onPressed: () {
          selectRange(functionInput);
        },
      ),
    );
  }
}

class RangeRow extends StatelessWidget {
  final Function changeRange;
  final DateTime selectedRange;

  RangeRow(this.changeRange, this.selectedRange);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RangeSelector(
            "3y",
            changeRange,
            threeYearAgo,
            selectedRange == threeYearAgo
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
        RangeSelector(
            "1y",
            changeRange,
            yearAgo,
            selectedRange == yearAgo
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
        RangeSelector(
            "6m",
            changeRange,
            sixMonthsAgo,
            selectedRange == sixMonthsAgo
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
        RangeSelector(
            "3m",
            changeRange,
            threeMonthsAgo,
            selectedRange == threeMonthsAgo
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
        RangeSelector(
            "1m",
            changeRange,
            monthAgo,
            selectedRange == monthAgo
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
        RangeSelector(
            "1w",
            changeRange,
            weekAgo,
            selectedRange == weekAgo
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
        RangeSelector(
            "1d",
            changeRange,
            yesterday,
            selectedRange == yesterday
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
      ],
    );
  }
}
