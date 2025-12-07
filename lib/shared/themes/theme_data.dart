import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/configs/app_colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: RickAndMortyAppColor.primary,
  scaffoldBackgroundColor: RickAndMortyAppColor.background,
  brightness: Brightness.light,
  fontFamily: 'Roboto',
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.white;
            }
            return null;
          },
        ),
      )
    //
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.pink,
  appBarTheme: AppBarTheme(color: Color(0xFF303236)),
  scaffoldBackgroundColor: Color(0xFF303236),
  brightness: Brightness.dark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey.withAlpha(50),
  ),
  fontFamily: 'Roboto',
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return Color(0xFF303236);
            }
            return null;
          },
        ),
      )

  ),
);
