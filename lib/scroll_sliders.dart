import 'package:flutter/material.dart';

class ScrollSlider extends StatefulWidget {
  final Function valueChange;
  final double maxValue;
  final double value;
  ScrollSlider({this.valueChange, this.maxValue = 100, this.value = 0});
  @override
  _ScrollSliderState createState() => _ScrollSliderState();
}

class _ScrollSliderState extends State<ScrollSlider> {
  double _sliderWidth = 200;
  double _barHeight = 6;
  double marginLeft = 0;
  double _bigCircle = 16;
  double _currentDx;
  GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    // _sliderWidth = _key.currentContext.size.width;
    // print(_sliderWidth);
  }

  @override
  Widget build(BuildContext context) {
    // _sliderWidth = _key.currentContext.size.width;
    print(_key.currentContext.size.width);
    _currentDx = (_bigCircle / 2) +
        (widget.value / widget.maxValue) * (_sliderWidth - _bigCircle);
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onTapDown: _onTapDown,
      child: Container(
        width: double.infinity,
        key: _key,
        color: Colors.grey,
        height: 30,
        child: CustomPaint(
          painter: BasePainter(
            baseColor: Colors.blue,
            width: _currentDx,
            sliderWidth: _sliderWidth,
            barHeight: _barHeight,
            bigCircle: _bigCircle,
          ),
        ),
      ),
    );
  }

  _onHorizontalDragUpdate(DragUpdateDetails details) {
    RenderBox referenceBox = context.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    if (localPosition.dx < (_sliderWidth + marginLeft - _bigCircle / 2) &&
        (localPosition.dx) > (marginLeft + _bigCircle / 2)) {
      _currentDx = (localPosition.dx - marginLeft);
      widget.valueChange((_currentDx - _bigCircle / 2) /
          (_sliderWidth - _bigCircle) *
          widget.maxValue);
    } else {
      if (localPosition.dx < (marginLeft + _bigCircle / 2) &&
          localPosition.dx > marginLeft) {
        widget.valueChange(0.0);
      }
      if (localPosition.dx < (_sliderWidth + marginLeft) &&
          localPosition.dx > (_sliderWidth + marginLeft - _bigCircle / 2)) {
        widget.valueChange(widget.maxValue);
      }
    }
  }

  _onTapDown(TapDownDetails details) {
    RenderObject renderObject = _key.currentContext.findRenderObject();
    print(
        "semanticBounds:${renderObject.semanticBounds.size} paintBounds:${renderObject.paintBounds.size} size:${_key.currentContext.size}");
    renderObject.semanticBounds.size.width;
    RenderBox referenceBox = context.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    if (localPosition.dx < (_sliderWidth + marginLeft - _bigCircle / 2) &&
        (localPosition.dx) > (marginLeft + _bigCircle / 2)) {
      _currentDx = (localPosition.dx - marginLeft);
      double data = (_currentDx - _bigCircle / 2) /
          (_sliderWidth - _bigCircle) *
          widget.maxValue;
      if (data < 3) data = 0.0;
      if (data > 22 && data < 28) data = 25.0;
      if (data > 47 && data < 53) data = 50.0;
      if (data > 72 && data < 78) data = 75.0;
      if (data > 97) data = 100.0;
      widget.valueChange(data);
    } else {
      if (localPosition.dx < (marginLeft + _bigCircle / 2) &&
          localPosition.dx > marginLeft) {
        widget.valueChange(0.0);
      }
      if (localPosition.dx < (_sliderWidth + marginLeft) &&
          localPosition.dx > (_sliderWidth + marginLeft - _bigCircle / 2)) {
        widget.valueChange(widget.maxValue);
      }
    }
  }
}

class BasePainter extends CustomPainter {
  Color baseColor;
  final width;
  double sliderWidth;
  Offset center;
  double radius;
  double barHeight;
  double bigCircle;
  BasePainter(
      {@required this.baseColor,
      this.width,
      this.sliderWidth,
      this.barHeight,
      this.bigCircle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff2C3556)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    canvas.drawLine(Offset(bigCircle / 2, 15),
        Offset(sliderWidth - (bigCircle / 2), 15), paint);
    canvas.drawLine(Offset(bigCircle / 2, 15), Offset(width, 15),
        paint..color = Color(0xff17BC95));
    canvas.drawCircle(
        Offset(bigCircle / 2, 15), 4, paint..color = Color(0Xffdbe4fe));
    canvas.drawCircle(Offset((sliderWidth - bigCircle) / 4 + bigCircle / 2, 15),
        4, paint..color = Color(0Xffdbe4fe));
    canvas.drawCircle(
        Offset(sliderWidth / 2, 15), 4, paint..color = Color(0Xffdbe4fe));
    canvas.drawCircle(
        Offset(((sliderWidth - bigCircle) / 4) * 3 + bigCircle / 2, 15),
        4,
        paint..color = Color(0Xffdbe4fe));
    canvas.drawCircle(Offset(sliderWidth - (bigCircle / 2), 15), 4,
        paint..color = Color(0Xffdbe4fe));
    canvas.drawCircle(
        Offset(width, 15), bigCircle / 2, paint..color = Color(0Xffdbe4fe));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
