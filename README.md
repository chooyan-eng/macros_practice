# macros_practice

Some practice macros by @chooyan-eng.

# Macros

## route_macro.dart

`@RouteMacro<T>` help us create `.route()` static method that returns `MaterialPageRoute<T>` for navigating to the page.

See [next_page.dart](lib/next_page.dart) for the usage of this macro.

## stateful_widget_macro.dart

With applying `@Stateful` to your class with `build()` method, you don't need to define `StatefulWidget` class and `State` class.

See [book_list_page.dart](lib/book_list_page.dart) for the usage of this macro.

## inherited_widget_macro.dart

`@InheritedWidgetMacro` would solve the boilerplate issue of `InheritedWidget` by defining `.of` method and `.maybeOf` method automatically. In addition, this macro tries to define `StatefulWidget` to maintain `InheritedWidget`'s state.

This macro is still in progress and no example usage is comitted.
