import 'package:flutter/material.dart';
import 'package:macros_practice/macros/inherited_widget_macro.dart';

const String clockColor = '#FF0000';

interface class GenericInterface<T> {}

@Inherited()
class ClockColor {
  ClockColor();
  final Color baseColor = Colors.black;
}

// usage: declare widget in build()
/** 
 * ClockColorMaintainer(
 *   child: child,
 * ) 
*/

// usage: retrieve value
/**
 * color: ClockColorTheme.of(context).clockColor;
 */

// usage: retrieve maintainer state object and update color 
/**
 * final maintainer = ClockColorMaintainer.of(context);
 * maintainer.update('#0000FF');
 */