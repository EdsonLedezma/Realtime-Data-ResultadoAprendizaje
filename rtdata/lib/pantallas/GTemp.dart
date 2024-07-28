import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GTemp extends StatelessWidget {
  final double temperature;

  const GTemp({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    String message;
    Color messageColor;

    if (temperature < 0) {
      message = 'Congelado';
      messageColor = Colors.blue;
    } else if (temperature >= 0.1 && temperature < 30) {
      message = 'Clima Agradable';
      messageColor = Colors.green;
    } else if (temperature > 30){
      message = 'Hace Caloooor';
      messageColor = Colors.red;
    }
    else {
      message = 'Buscando datos Firebase';
      messageColor = Colors.red;
    }

    return Column(
      children: [
        SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            labelsPosition: ElementsPosition.outside,
            axisLineStyle: const AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor,
              thickness: 0.1,
            ),
            majorTickStyle: const MajorTickStyle(
                length: 0.1, thickness: 2, lengthUnit: GaugeSizeUnit.factor),
            minorTickStyle: const MinorTickStyle(
                length: 0.05, thickness: 1.5, lengthUnit: GaugeSizeUnit.factor),
            minimum: -50,
            maximum: 50,
            interval: 5,
            useRangeColorForAxis: true,
            axisLabelStyle: const GaugeTextStyle(fontWeight: FontWeight.bold),
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: -50,
                  endValue: 0,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.blue,
                  endWidth: 0.03,
                  startWidth: 0.03),
              GaugeRange(
                  startValue: 0,
                  endValue: 30,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.green,
                  endWidth: 0.03,
                  startWidth: 0.03),
              GaugeRange(
                  startValue: 30,
                  endValue: 50,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.red,
                  endWidth: 0.03,
                  startWidth: 0.03),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: temperature,
                needleColor: Colors.black,
                tailStyle: const TailStyle(
                    length: 0.18,
                    width: 8,
                    color: Colors.black,
                    lengthUnit: GaugeSizeUnit.factor),
                needleLength: 0.68,
                needleStartWidth: 1,
                needleEndWidth: 8,
                knobStyle: const KnobStyle(
                    knobRadius: 0.07,
                    color: Colors.white,
                    borderWidth: 0.05,
                    borderColor: Colors.black),
                lengthUnit: GaugeSizeUnit.factor,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Text(
                    '$temperature °C',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  positionFactor: 0.8,
                  angle: 90)
            ],
          ),
        ]),
        Text(
          message,
          style: TextStyle(color: messageColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
