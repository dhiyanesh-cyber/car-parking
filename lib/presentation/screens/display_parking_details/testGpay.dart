import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

void main() {
  runApp(MyAppp());
}
const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "IN",
      "currencyCode": "INR"
    }
  }
}''';

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Pay Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Pay Demo'),
        ),
        body: Center(
          child: GooglePayButton(
            paymentConfiguration: PaymentConfiguration.fromJsonString(
                defaultGooglePay),
            paymentItems: [
              PaymentItem(
                amount: '10.00',
                
              ),
            ],
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }

  void onGooglePayResult(paymentResult) {
   
  }
}