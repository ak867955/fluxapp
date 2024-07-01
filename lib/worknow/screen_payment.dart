import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux/data/payment_controller.dart';
import 'package:upi_india/upi_exception.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';


class PaymentScreen extends StatefulWidget {
  double amount;
  String recieverUPIID;
  String accountHolerName;
  PaymentScreen(
      {super.key,
      required this.amount,
      required this.accountHolerName,
      required this.recieverUPIID
    });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final now = DateTime.now();
    int _selectedPaymentMethod = 0;

  // String date = DateFormat("dd/MM/yyyy").format(DateTime.now());
  Future<UpiResponse>? transaction;
  @override
  Widget build(BuildContext context) {
    // String dateAfter1Year = DateFormat("dd/MM/yyyy")
    //     .format(DateTime(now.year + 1, now.month, now.day));


    return Column(children: [
       
    
        FutureBuilder(
          future: PaymentController().initializeUpiIndia(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildPaymentMethodOption(context, index, snapshot.data![index].name, "",snapshot.data![index]);
                },
              ),
            );
          },
        ),
        FutureBuilder(
            future: transaction,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(_upiErrorHandler(snapshot.error.runtimeType),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ));
                }
                UpiResponse upiResponse = snapshot.data!;

                String txnId = upiResponse.transactionId ?? 'N/A';
                String resCode = upiResponse.responseCode ?? 'N/A';
                String txnRef = upiResponse.transactionRefId ?? 'N/A';
                String status = upiResponse.status ?? 'N/A';
                String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
                _checkTxnStatus(status);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      displayTransactionData('Transaction Id', txnId),
                      displayTransactionData('Response Code', resCode),
                      displayTransactionData('Reference Id', txnRef),
                      displayTransactionData('Status', status.toUpperCase()),
                      displayTransactionData('Approval No', approvalRef),
                    ],
                  ),
                );
              }

              return const Text(
                "",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              );
            }),
        const SizedBox(
          height: 30,
        )
      ]);
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              )),
          Flexible(
              child: Text(
            body,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  Widget _buildPaymentMethodOption(BuildContext context, int value, String title, String subtitle,UpiApp app) {
    return GestureDetector(
      onTap: () {
       
             PaymentController()
                          .initiateTransaction(context,
                              app: app,
                              receiverUpiId: widget.recieverUPIID,
                              receiverName:widget.accountHolerName ,
                              amount: widget.amount)
                          .then((value) async {
                      
                        return transaction = value as Future<UpiResponse>?;
                      }).catchError((error) {
                       // drop you function
                        log("out");

                      });
        //                setState(() {
        //   _selectedPaymentMethod = value;
        // });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: _selectedPaymentMethod == value
                ? const Color.fromRGBO(8, 38, 76, 1)
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                  value: value,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedPaymentMethod = newValue!;
                    });
                  },
                  activeColor: const Color.fromRGBO(8, 38, 76, 1),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}


 