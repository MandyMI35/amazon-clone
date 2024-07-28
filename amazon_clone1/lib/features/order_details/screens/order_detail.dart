import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/features/search/screens/search_screen.dart';
import 'package:amazon_clone1/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    void navigateToSearchScreen(String query) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          //we need a gradient but appbar doesnt have that property so we add container to do that
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View Order Detaisls',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date:      ${DateFormat().format(
                        DateTime.fromMicrosecondsSinceEpoch(
                          widget.order.orderedAt)
                        )
                      }',
                    ),
                    Text(
                      'Order ID:        ${widget.order.id}'
                    ),
                    Text(
                      'Order ID:       \$${widget.order.totalPrice}'
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Purchase details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(int i=0;i<widget.order.products.length;i++){
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0], //10.18
                          )
                        ],
                      )
                    }
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
