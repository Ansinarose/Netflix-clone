import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/details.dart';
import 'package:netflix_clone/models/recommendation.dart';
import 'package:netflix_clone/services/apiServices.dart';

class ScreenMovieDetails extends StatefulWidget {
  final int  movieId;
  const ScreenMovieDetails({super.key, required this.movieId});

  @override
  State<ScreenMovieDetails> createState() => _ScreenMovieDetailsState();
}

class _ScreenMovieDetailsState extends State<ScreenMovieDetails> {

  ApiServices apiServices = ApiServices();

  late Future<MovieDetailsModel> movieDetail;
  late Future <MovieRecommendationModel> movieRecommendations;

@override
  void initState() {
   super.initState();
   fetchInitialData();
  }

  fetchInitialData(){
    movieDetail = apiServices.getMovieDeatails(widget.movieId);
    movieRecommendations = apiServices.getMovieRecomendations(widget.movieId);

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print( "movie id  is ${widget.movieId}");
    return  Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetail,
          builder: (context,snapshot){
            if(snapshot.hasData){
              final movie = snapshot.data;
   String genreTeaxt = movie!.genres.map((genre) => genre.name).join(', ');

            return
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration:  BoxDecoration(image: DecorationImage(
                      image: NetworkImage("$imageUrl${movie.posterPath}",),
                    fit: BoxFit.cover
                    ),
                    ),
                    
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon:  const Icon(Icons.arrow_back_ios
                                ,color: Colors.white,),
                                onPressed: () {
                                         Navigator.pop(context);
                                            },),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(movie.title,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Text(movie.releaseDate.year.toString(),style: const TextStyle(color: Colors.grey),),
                      const SizedBox(width: 30,),
                      Text(genreTeaxt,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        
                        fontSize: 17,
                        
                      ),)
                    ],
                  ),
                  const SizedBox(height: 20,),
                   Text(movie.overview,
                   maxLines: 6,
                   overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),)
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(future: movieRecommendations, builder: (context,snapshot){
                if(snapshot.hasData){
                  final movie = snapshot.data;
                  return movie!.results.isEmpty

                  ?const SizedBox(): 
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('More like this'),
                    const SizedBox(height: 20,),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1.2/2), itemBuilder: (context,index){
                       return   CachedNetworkImage(
                        imageUrl: "$imageUrl${movie.results[index].posterPath}");
                         
                        }
                        )
                  ],
                    
                  ); 

                            }
                            return const Text('something went wrong');
              }
              )
            ],
          );
          }else{
            return const Text('error');
          }
           },
          
            ),
      ),
    );
  }
}