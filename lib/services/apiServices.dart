
import 'dart:convert';
import 'dart:developer';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/details.dart';
import 'package:netflix_clone/models/recommendation.dart';
import 'package:netflix_clone/models/search.dart';
import 'package:netflix_clone/models/tvSeries.dart';
import 'package:netflix_clone/models/upcoming.dart';
import 'package:http/http.dart' as http;



const baseUrl = "https://api.themoviedb.org/3/";
 var key ="?api_key=$apikey";
 late String endpoint;
 
 class ApiServices{
  Future <UpcomingMovieModel> getUpcomingMovies() async{
    endpoint="movie/upcoming";
    final url ="$baseUrl$endpoint$key";

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      log("Success");

      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw
     Exception('failed to load upcoming movies');
  }



   Future<UpcomingMovieModel> getNowPlayingMovies() async{
    endpoint="movie/now_playing";
    final url ="$baseUrl$endpoint$key";

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      log("Success");

      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }



  Future <TvSeriesModel> getTopratedSeries() async{
    endpoint="tv/1396/recommendations";
    final url ="$baseUrl$endpoint$key";

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      log("Success");

      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Top rated Tv series');
  }


  Future <SearchModel> getSearchMovie(String searchText) async{
    endpoint="search/movie?query=$searchText";
    final url ="$baseUrl$endpoint";
    print("Search url is $url");
    final response = await http.get(Uri.parse(url),
    headers: {
      'Authorization': 
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"
    });
    log(response.statusCode.toString());
    if(response.statusCode == 200){
      log("Success");

      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Searched movies');
  }
 

  Future <MovieRecommendationModel> getPopularMovies() async{
    endpoint="movie/popular";
    final url ="$baseUrl$endpoint$key";

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      log("Success");

      return MovieRecommendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Popular movies');
  }


  Future <MovieDetailsModel> getMovieDeatails(int movieId) async{
    endpoint="movie/$movieId";
    final url ="$baseUrl$endpoint$key";
    print("Movie details url is $url");
    final response = await http.get(Uri.parse(url),
    );
   // log(response.statusCode.toString());
    if(response.statusCode == 200){
      log("Success");

      return MovieDetailsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load movie details');
  }


  
  Future <MovieRecommendationModel> getMovieRecomendations(int movieId) async{
    endpoint="movie/$movieId/recommendations";
    final url ="$baseUrl$endpoint$key";
    print("Recommendation url is $url");
    final response = await http.get(Uri.parse(url),
    );
   // log(response.statusCode.toString());
    if(response.statusCode == 200){
      log("Success");

      return MovieRecommendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load more like this');
  }
 }