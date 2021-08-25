import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_app/classes/adaptivetextsize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../values.dart';

///the DetailsContainer widget shows the weather details of the current day
class DetailsContainer extends StatelessWidget {
  String city;
  String tempMax;
  String tempMin;
  String description;
  String temp;
  DateTime date;
  String iconImage;
  double maxHeight;
  double maxWidth;
  DetailsContainer({this.date,this.temp,this.city,this.description,this.iconImage,this.tempMin,this.tempMax,this.maxHeight,this.maxWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
        color:kBackgroundColor,
        ///450 is the avg of android screens width
        padding:  maxWidth < 450 ?EdgeInsets.only(left: maxWidth*0.1,right:maxWidth*0.1,top: maxWidth*0.1 ):EdgeInsets.all(maxWidth*0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(city,style: TextStyle(color: kFontColor,fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 25)),),
                 Text(
                   DateFormat('EEE d/M/y').format(date),style:TextStyle(color: kFontColor,fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 25)),
                 )
               ]
               ),
             SizedBox(height: maxHeight*0.03,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(description,style: TextStyle(color: kFontColor,fontWeight: KFontWeight,fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 25)),),
                 Row(
                   textBaseline: TextBaseline.ideographic,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("$tempMax/$tempMin",
                       style:TextStyle(color: kFontColor,fontSize:AdaptiveTextSize().getAdaptiveTextSize(context, 25),fontWeight: KFontWeight),),
                     Text('\u2103',style:TextStyle(fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 15), color: kFontColor,fontWeight: KFontWeight))
                   ],
                 )
               ],
             ),
           ],
         ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Container(
               height: maxHeight*0.15,
               width: maxHeight*0.15,
               child:CachedNetworkImage(
                 imageUrl: 'http://openweathermap.org/img/wn/$iconImage.png',
                 placeholder: (context, url) => CircularProgressIndicator(),
                 errorWidget: (context, url, error) => Icon(Icons.error),
               ),

             ),
              Row(
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(double.tryParse(temp).toStringAsFixed(0),style: TextStyle(fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 120),color: kFontColor),),
                  Text('\u2103',style:TextStyle(fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 40), color: kFontColor) ,)
            ],
          ),
        ],
      ),
     ]
    )
    );
  }
}

///the DayWeather widget is the component of the list view of 5 days after
class DayWeather extends StatelessWidget {
  String day;
  String date;
  String icon;
  String weatherDescription;
  String temp;
  double maxHeight;
  double maxWidth;
  DayWeather({this.weatherDescription,this.temp,this.icon,this.date,this.day,this.maxWidth,this.maxHeight});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: maxWidth*0.02),
      child: Container(
        ///450 is the avg of android screens width
        width: maxWidth< 450? maxWidth*0.30:maxWidth*0.15,
        decoration: BoxDecoration(
          color:kDayContainer,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: EdgeInsets.all(maxWidth< 450? maxWidth*0.025:maxWidth*0.015),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(day,style: TextStyle(color: kFontColor,fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 15)),),
              Text(date,style: TextStyle(color: kFontColor,fontSize:AdaptiveTextSize().getAdaptiveTextSize(context, 12)),),
              /// using the CachedNetworkImage to cache the data in the device
              CachedNetworkImage(
                imageUrl: 'http://openweathermap.org/img/wn/$icon.png',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Text(weatherDescription,style: TextStyle(color:kFontColor,fontSize:AdaptiveTextSize().getAdaptiveTextSize(context, 14) ),),
              Text("$temp\u00B0",style: TextStyle(fontWeight: KFontWeight,color: kFontColor,fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 15)),),
            ],
          ),
        ),
      ),
    );
  }
}

///the Details widget is the widget that show the hourly data and its used in DetailsScreen
class Details extends StatelessWidget {
  String icon;
  String time;
  String description;
  String temp;
  double maxHeight;
  double maxWidth;
  Details({this.icon,this.temp,this.description,this.time,this.maxWidth,this.maxHeight});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: maxWidth*0.05,vertical: maxHeight*0.021),
      child: Row(
        children: [
          Container(height: maxWidth < 450 ? maxHeight*0.04:maxHeight*0.1,width: maxWidth < 450 ? maxHeight*0.04:maxHeight*0.1,
            /// using the CachedNetworkImage to cache the data in the device
            child: CachedNetworkImage(
              imageUrl: 'http://openweathermap.org/img/wn/$icon.png',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            ),
          Text("$time  \u2022  $description",style: TextStyle(fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 18),color: kFontColor),),
          Expanded(child: Container()),
          Text('${double.tryParse(temp).toStringAsFixed(0)} \u00B0',style: TextStyle(fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 18),color: kFontColor,fontWeight: KFontWeight)),
        ],
      ),
    );
  }
}