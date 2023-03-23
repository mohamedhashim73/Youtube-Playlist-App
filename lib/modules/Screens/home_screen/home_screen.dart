import 'package:code_app/layout/layout_cubit/layout_cubit.dart';
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:code_app/models/product_model.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  final pageController = PageController();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder:(context,state){
          return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 15),
                child: ListView(
                  shrinkWrap: true,
                  children:
                  [
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Search",
                          suffixIcon: const Icon(Icons.clear),
                          filled: true,
                          fillColor: Colors.black12.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.grey)
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 17),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    // Todo: Display Banners
                    cubit.banners.isEmpty ?
                    const Center(child: CupertinoActivityIndicator(),) :
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: PageView.builder(
                          controller: pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context,index){
                            return Image.network(cubit.banners[index].url!,fit: BoxFit.fill,);
                          }
                      ),
                    ),
                    const SizedBox(height: 15,),
                    // Todo: Smooth Page Indicator
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: const SlideEffect(
                            spacing: 8.0,
                            radius:  25,
                            dotWidth:  16,
                            dotHeight:  16.0,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth:  1.5,
                            dotColor:  Colors.grey,
                            activeDotColor: secondColor
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                      [
                        Text("Categories",style: TextStyle(color: mainColor,fontSize: 20,fontWeight: FontWeight.bold),),
                        Text("View all",style: TextStyle(color: secondColor,fontSize: 14,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    cubit.categories.isEmpty ?
                    const Center(child: CupertinoActivityIndicator(),) :
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: cubit.categories.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context,index){
                            return SizedBox(width: 15,);
                          },
                          itemBuilder: (context,index)
                          {
                            return CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(cubit.categories[index].url!),
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                      [
                        Text("Products",style: TextStyle(color: mainColor,fontSize: 20,fontWeight: FontWeight.bold),),
                        Text("View all",style: TextStyle(color: secondColor,fontSize: 14,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    cubit.products.isEmpty ?
                      const Center(child: CupertinoActivityIndicator(),) :
                      GridView.builder(
                        itemCount: cubit.filteredProducts.isEmpty ?
                          cubit.products.length :
                          cubit.filteredProducts.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.7
                          ),
                          itemBuilder: (context,index)
                          {
                            return _productItem(
                                model: cubit.filteredProducts.isEmpty ?
                                  cubit.products[index] :
                                  cubit.filteredProducts[index],
                              cubit: cubit
                            );
                          }
                      )
                  ],
                ),
              )
          );
        }
    );
  }
}

Widget _productItem({required ProductModel model,required LayoutCubit cubit}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: Colors.grey.withOpacity(0.2),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Expanded(
          child: Image.network(model.image!,fit: BoxFit.fill,width: double.infinity,height:double.infinity,),
        ),
        const SizedBox(height: 5,),
        Text(model.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16,overflow: TextOverflow.ellipsis),),
        const SizedBox(height: 2,),
        Row(
          children:
          [
            Expanded(
              child: Row(
                children:
                [
                  FittedBox(fit:BoxFit.scaleDown,child: Text("${model.price!} \$",style: TextStyle(fontSize:13),)),
                  SizedBox(width: 5,),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("${model.oldPrice!} \$",style: TextStyle(color:Colors.grey,fontSize: 12.5,decoration: TextDecoration.lineThrough),),)
                ],
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.favorite,
                size: 20,
                color: cubit.favoritesID.contains(model.id.toString())? Colors.red : Colors.grey,
              ),
              onTap: ()
              {
                // Add | remove product favorites
                cubit.addOrRemoveFromFavorites(productID: model.id.toString());
              },
            )
          ],
        )
      ],
    ),
  );
}