import 'package:flutter/material.dart';

navigateTo(context, route) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));

navigateAndReplace(context, route) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => route));
