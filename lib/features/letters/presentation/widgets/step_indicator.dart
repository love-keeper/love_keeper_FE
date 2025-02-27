import 'package:flutter/material.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/line_painter.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final double scaleFactor;
  final List<double> lineLengths;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.scaleFactor,
    required this.lineLengths,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 141 * scaleFactor,
      height: 20 * scaleFactor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return Row(
            children: [
              Container(
                width:
                    index == currentStep ? 20 * scaleFactor : 10 * scaleFactor,
                height:
                    index == currentStep ? 20 * scaleFactor : 10 * scaleFactor,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < currentStep
                      ? const Color(0xFFCCCCCC)
                      : index == currentStep
                          ? const Color(0xFFFF859B)
                          : Colors.transparent,
                  border: Border.all(
                    color: index == currentStep
                        ? const Color(0xFFFF859B)
                        : const Color(0xFFC3C6CF),
                    width: 2 * scaleFactor,
                  ),
                ),
                child: index == currentStep
                    ? Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12 * scaleFactor,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 12 / (12 * scaleFactor),
                            letterSpacing: -0.025 * (12 * scaleFactor),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (index < 3)
                SizedBox(
                  width: lineLengths[index] * scaleFactor,
                  height: 2 * scaleFactor,
                  child: CustomPaint(
                    painter: LinePainter(
                      isDashed: index >= currentStep,
                      color: const Color(0xFFC3C6CF),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
