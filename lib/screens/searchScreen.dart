import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/recommendation.dart';
import 'package:netflix_clone/models/search.dart';
import 'package:netflix_clone/screens/screenDetails.dart';
import 'package:netflix_clone/services/apiServices.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  TextEditingController searchController = TextEditingController();
 ApiServices apiServices = ApiServices();
late Future<MovieRecommendationModel> popularMovies;

 SearchModel? searchModel;

 void search(String query){
  apiServices.getSearchMovie(query).then((results) {
  setState(() {
    searchModel = results;
  });
  });
 }


 @override
  void initState() {
    popularMovies = apiServices.getPopularMovies();
    super.initState();
  }
 @override
  void dispose() {
   searchController.dispose();   //for avoiding memory leakage
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoSearchTextField(
                  
                  controller: searchController,
                  prefixIcon: const Icon(Icons.search,color: Colors.grey,
                  ),
                  suffixIcon: const Icon(Icons.cancel,color:  Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if(value.isEmpty){
          
                    }else{
                      search(searchController.text);
                    }
                  },
                ),
          
              ),

              searchController.text.isEmpty?
              FutureBuilder(future: popularMovies, builder: (context,snapshot){
      if(snapshot.hasData){
      var data = snapshot.data?.results;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            const Text("Top Searches",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 20,),
            ListView.builder(
              itemCount: data?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                     return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: 
                        (context) =>  ScreenMovieDetails(movieId: data[index].id,)));
                      },
                       child: Container(
                       height: 150,
                        padding: const EdgeInsets.all(5),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(20),
                                   ),
                                   child: Row(
                                     children: [
                                       Image.network("$imageUrl${data?[index].posterPath}"),
                                       const SizedBox(width: 20,),
                                       SizedBox(width: 260,
                                         child: Text(data![index].title,
                                         maxLines: 2,
                                         overflow: TextOverflow.ellipsis,),
                                       )
                                     ],
                                   ),
                       ),
                     );
            })
          ],
        ),
      );}
      else{
        return const SizedBox.shrink();
      }
    }):
              searchModel == null
              ? const SizedBox.shrink() :
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchModel?.results.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,mainAxisSpacing: 15,crossAxisSpacing: 5,childAspectRatio: 1.2 / 2), itemBuilder: (context,index){
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                        ScreenMovieDetails(movieId: searchModel!.results[index].id)));
                    },
                    child: Column(
                      children: [
                        searchModel!.results[index].backdropPath == null?
                        AspectRatio(aspectRatio: 1.2 /1.1,
                        child: Image.asset("assets/netflix.png"),
                        ):
                        CachedNetworkImage(
                          imageUrl: "$imageUrl${searchModel!.results[index].backdropPath}",
                          height: 170,),
                          SizedBox(
                            width: 100,
                            child: Text(searchModel!.results[index].originalTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),),
                          )
                      ],
                    ),
                  );
                })
            ],
          ),
        )
      ),
    );
  }
}