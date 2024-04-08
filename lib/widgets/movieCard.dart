import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/upcoming.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<UpcomingMovieModel> future;
  final String headlinetext;
  const MovieCardWidget({super.key, required this.future, required this.headlinetext});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: future, builder: (context,snapshot){
      if(snapshot.hasData){
      var data = snapshot.data?.results;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headlinetext,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: data?.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context,index){
                     return Container(
                      padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network("$imageUrl${data?[index].posterPath}"),
                     );
            }),
          )
        ],
      );}
      else{
        return const SizedBox.shrink();
      }
    }
    );
  }
}