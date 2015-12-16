part of currency_cloud;

class PaymentsApi extends CurrencyCloudApi {
  PaymentsApi(client) : super(client);

  /// [paymentType] will default to [PaymentType.regular] if not provided
  Future<Map<String, String>> create(Money money, String beneficiaryId, String reason, String reference,
      {String conversionId, PaymentType paymentType}) {
    var uri = '/payments/create';

    var body = {
      'amount': money.amountAsString,
      'currency': money.currency.code,
      'beneficiary_id': beneficiaryId,
      'reason': reason,
      'reference': reference,
    };

    if (conversionId != null) body['conversion_id'] = conversionId;
    body['payment_type'] = paymentType?.toString()?.split('.')?.last ?? 'regular';

    return client.post(uri, body: body);
  }
}
