import 'package:flutter/material.dart';

class AdaptiveTextSize {
  const AdaptiveTextSize();
  ///this method is being used to get responsive text font
  getAdaptiveTextSize(BuildContext context, dynamic value) {
    /// 720 is medium screen height
    if(MediaQuery.of(context).orientation == Orientation.portrait ){
      return (value / 720) * MediaQuery.of(context).size.height;
    }else{
      return (value / 720) * MediaQuery.of(context).size.width;
    }
  }
}