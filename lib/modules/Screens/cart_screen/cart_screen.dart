import 'package:code_app/layout/layout_cubit/layout_cubit.dart';
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body: BlocConsumer<LayoutCubit,LayoutStates>(
        listener:(context,state){},
        builder:(context,state){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
            child: Column(
              children:
              [
                Expanded(
                  child: cubit.carts.isNotEmpty ?
                  ListView.separated(
                      itemCount: cubit.carts.length,
                      separatorBuilder: (context,index){
                        return SizedBox(height: 12,);
                      },
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: fourthColor
                          ),
                          child: Row(
                            children:
                            [
                              Image.network(cubit.carts[index].image!,height: 100,width: 100,fit: BoxFit.fill,),
                              SizedBox(width: 12.5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  [
                                    Text(cubit.carts[index].name!,style: TextStyle(color: mainColor,fontSize: 17,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                    SizedBox(height: 5,),
                                    Row(
                                      children:
                                      [
                                        Text("${cubit.carts[index].price!} \$"),
                                        SizedBox(width: 5,),
                                        if( cubit.carts[index].price != cubit.carts[index].oldPrice)
                                        Text("${cubit.carts[index].oldPrice!} \$",style: TextStyle(decoration: TextDecoration.lineThrough),),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:
                                      [
                                        OutlinedButton(
                                            onPressed: ()
                                            {
                                              cubit.addOrRemoveFromFavorites(productID: cubit.carts[index].id.toString());
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: cubit.favoritesID.contains(cubit.carts[index].id.toString()) ? Colors.red : Colors.grey,
                                            )
                                        ),
                                        GestureDetector(
                                          onTap: (){},
                                          child: Icon(Icons.delete,color: Colors.red,),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  ) :
                      Center(child: Text("Loading....."),)
                ),
                Container(
                  child: Text("TotalPrice : ${cubit.totalPrice} \$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: mainColor),),
                )
              ],
            ),
          );
        }
      )
    );
  }
}
