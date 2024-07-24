import 'package:amazon_clone1/common/widgets/custom_textfield.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/features/address/services/address_services.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/adress';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  PaymentConfiguration? _googlePayConfiguration;

  List<PaymentItem> paymentItems=[];

  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    // _loadGooglePayConfiguration();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  Future<void> _loadGooglePayConfiguration() async {
    final String response = await rootBundle.loadString('gpay.json');
    final data = await PaymentConfiguration.fromJsonString(response);
    setState(() {
      _googlePayConfiguration = data;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }
  
  void onApplePayResult(res){
    if (Provider.of<UserProvider>(context).user.address.isEmpty){
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
  }

  void onGooglePayResult(res){}

  void payPressed(String addressFromProvider){
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller:
                          flatBuildingController, //manages the text input related here i.e name
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: areaController,
                      hintText: 'Area, street',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: cityController,
                      hintText: 'Town / City',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              // ApplePayButton( //9.15.00
              //   width: double.infinity,
              //   style: ApplePayButtonStyle.whiteOutline,
              //   height: 50,
              //   type: ApplePayButtonType.buy,
              //   paymentItems: paymentItems,
              //   onPaymentResult: onApplePayResult, 
              //   paymentConfiguration: PaymentConfiguration.fromJsonString('applepay.json'),
              //   margin: const EdgeInsets.only(top: 15),
              // ), 
              const SizedBox(height: 10,),
              GooglePayButton( //////////////////////////////////////////
                width: double.infinity,
                height: 50,
                onPressed: () => payPressed(address),
                theme: GooglePayButtonTheme.dark,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                paymentConfiguration: _googlePayConfiguration!, 
                paymentItems: paymentItems,
                onPaymentResult: onGooglePayResult,
                // loadingIndicator: const Center(child: CircularProgressIndicator(),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
