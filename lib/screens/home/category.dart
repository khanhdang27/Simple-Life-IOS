import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart' as CategoryModel;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Category extends StatelessWidget {
  Category() {
    AppBloc.categoryBloc.add(CategoryGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: AppBloc.categoryBloc,
      builder: (context, state) {
        if (state is CategoryGetAllSuccess) {
          return GridView(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children: state.categories!.map((e) {
              return _CategoryItem(category: e);
            }).toList(),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryModel.Category category;

  const _CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          AppBloc.productBloc.add(ProductGetByCategory(category: category));
          AppBloc.viewBloc.add(ViewCategory());
        },
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 15),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: category.thumbnail != null
                        ? Image(
                            image: NetworkImage(category.thumbnail!),
                            fit: BoxFit.fill, // use this
                          )
                        : Container(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: SingleChildScrollView(
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontFamily: AppFont.monospace,
                      fontWeight: AppFont.wMedium,
                      fontSize: 14,
                    ),
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
