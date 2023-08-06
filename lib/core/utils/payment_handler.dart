import 'package:store_app_clean_architecture/core/utils/extentions/string_extentions.dart';
import 'package:store_app_clean_architecture/core/utils/url_handler.dart';
import 'package:zarinpal/zarinpal.dart';
import 'package:uni_links/uni_links.dart';

abstract class PaymentHandler {
  Future<void> initRequestPayment({required num amount});
  Future<void> sendRequestPayment();
  Future<void> verifyRequestPayment({required String deepLink});
}

class ZarinpalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  final CustomUrlHandler _urlHandler = CustomUrlLuncher();
  @override
  Future<void> initRequestPayment({required num amount}) async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(amount);
    _paymentRequest.setMerchantID('a10d06b3-a575-4bca-b176-0d695c5f5474');
    _paymentRequest.setDescription('خرید از اپل لند');
    _paymentRequest.setCallbackURL('pureflutter://shop');

    linkStream.listen((deepLink) {
      verifyRequestPayment(deepLink: deepLink!);
    });
  }

  @override
  Future<void> sendRequestPayment() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        _urlHandler.openUrl(
          url: paymentGatewayUri!,
        );
      }
    });
  }

  @override
  Future<void> verifyRequestPayment({required String deepLink}) async {
    if (deepLink.contains('Authority')) {
      final auth = deepLink.extract('Authority');
      final status = deepLink.extract('Status');

      ZarinPal().verificationPayment(
        status!,
        auth!,
        _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {},
      );
    }
  }
}
