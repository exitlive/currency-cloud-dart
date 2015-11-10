part of currency_cloud;

class PaymentsApi extends CurrencyCloudApi {
  PaymentsApi(authToken) : super(authToken);

  Future<Map<String, String>> create(Money money, String beneficiaryId, String reason, String reference) {
    return null;
  }
}
