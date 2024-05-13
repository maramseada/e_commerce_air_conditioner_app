import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constant/app_constants.dart';
import '../../../data/models/projectsCategory.dart';
import '../../controllers/our_projects_cubit.dart';
import '../../screens/our_project_details.dart';

class OurProjectsGridViewItem extends StatefulWidget {
 final  Projects project ;
  const OurProjectsGridViewItem({super.key, required this.project});

  @override
  State<OurProjectsGridViewItem> createState() => _OurProjectsGridViewItemState();
}

class _OurProjectsGridViewItemState extends State<OurProjectsGridViewItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        BlocProvider.of<OurProjectsCubit>(context).getProjectByTypes(id: widget.project.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OurProjectsScreen(
              id: widget.project.id.toString(),
              name: widget.project.name,
            ),
          ),
        ).then((_) {
          if (mounted) {
            setState(() {
              BlocProvider.of<OurProjectsCubit>(context).getProjectsCategories();
            });
          }
        });

      },

      child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFf2f7fb),
              borderRadius: BorderRadius.circular(20),
              border: const Border.symmetric(
                horizontal: BorderSide(width: 6, color: Colors.white),
                vertical: BorderSide(width: 1, color: Colors.white),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFdbe9f3),
                          width: 10.0,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xFFc6dcec)),
                    alignment: Alignment.center,
                    height: 110,
                    width: 110,
                    child: CachedNetworkImage(
                      imageUrl: '$baseUrl${widget.project.image}',
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.2,
                  child: Text(
                    widget.project.name,
                    style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.04, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
