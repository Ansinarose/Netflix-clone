// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/tvSeries.dart';

class CarousalSlider_Widget extends StatelessWidget {
  final TvSeriesModel data;
  const CarousalSlider_Widget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      
      width: size.width ,
      height: (size.height *0.33 < 300) ? 300:size.height*0.33,
      child: CarouselSlider.builder(
        itemCount: data.results.length, 
        itemBuilder: (BuildContext context,int index,int realIndex) {
          var url = data.results[index].backdropPath.toString();
               return GestureDetector(
        child:   Column(
          children: [
            CachedNetworkImage(imageUrl: "$imageUrl$url"),
            const SizedBox(height: 20,),
            Text(data.results[index].name)
          ],

        ));
        },
        options: CarouselOptions(
          height: (size.height *0.33 < 300) ? 300:size.height*0.33,
          aspectRatio: 16 / 9,
          reverse: false,
          initialPage: 0,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,

        ),
        ),
    );
  }
}