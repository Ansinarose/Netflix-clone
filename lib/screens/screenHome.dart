
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/tvSeries.dart';
import 'package:netflix_clone/models/upcoming.dart';
import 'package:netflix_clone/screens/searchScreen.dart';
import 'package:netflix_clone/services/apiServices.dart';
import 'package:netflix_clone/widgets/carousal.dart';
import 'package:netflix_clone/widgets/movieCard.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

ApiServices apiServices = ApiServices();

late Future<UpcomingMovieModel> upcomingFuture;
late Future<UpcomingMovieModel> nowPlayingFuture ;
late Future<TvSeriesModel> topRatedSeries;




@override
  void initState() {
    upcomingFuture=apiServices.getUpcomingMovies();
    nowPlayingFuture=apiServices.getNowPlayingMovies();
    topRatedSeries = apiServices.getTopratedSeries();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Image.asset("assets/logo.png",
         height: 50,
         width: 120,
          ),
          actions:  [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap:  () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const ScreenSearch()));
                },
              child: 
              const Icon(Icons.search,
              size: 30,
               color: Colors.white,
              ),
                         ),
            ),
           ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ) ,
           ),
           const SizedBox(width: 20,)
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<TvSeriesModel>(
              future: topRatedSeries, 
            builder: (context, snapshot){
              if(snapshot.hasData){
   return CarousalSlider_Widget(data: snapshot.data!);          
     }
      return const SizedBox();
     
            
              
            } 
            ),
            const SizedBox(
              height: 20,
            ),
             SizedBox(
              height: 220,
              child: MovieCardWidget(
                future: nowPlayingFuture,
                 headlinetext: "Now Playing")),
              const SizedBox(height: 20,),
             SizedBox(
              height: 220,
              child: MovieCardWidget(
                future: upcomingFuture, 
                headlinetext: "Upcoming Movies")),
             
             ],
          
        ),
      )
    );
  }
}