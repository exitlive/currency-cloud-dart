part of currency_cloud;

class BeneficiariesApi extends CurrencyCloudApi {
  BeneficiariesApi(client) : super(client);

  Future<Map<String, dynamic>> create(String bankAccountHolderName, String bankCountry, Currency currency, String name,
      {String email,
      String beneficiaryAddress,
      String beneficiaryCountry,
      String accountNumber,
      String routingCodeType1,
      String routingCodeValue1,
      String routingCodeType2,
      String routingCodeValue2,
      String bicSwift,
      String iban,
      bool defaultBeneficiary,
      String bankAddress,
      String bankName,
      String bankAccountType,
      String beneficiaryEntityType,
      String beneficiaryCompanyName,
      String beneficiaryFirstName,
      String beneficiaryLastName,
      String beneficiaryCity,
      String beneficiaryPostcode,
      String beneficiaryStateOrProvince,
      String beneficiaryDateOfBirth,
      String beneficiaryIdentificationType,
      String beneficiaryIdentificationValue,
      String paymentTypes,
      String onBehalfOf}) {
    var uri = '/beneficiaries/create';

    var body = {
      'bank_account_holder_name': bankAccountHolderName,
      'bank_country': bankCountry,
      'currency': currency.code,
      'name': name
    };

    if (email != null) body['email'] = email;
    if (beneficiaryAddress != null) body['beneficiary_address'] = beneficiaryAddress;
    if (beneficiaryCountry != null) body['beneficiary_country'] = beneficiaryCountry;
    if (accountNumber != null) body['account_number'] = accountNumber;
    if (routingCodeType1 != null) body['routing_code_type_1'] = routingCodeType1;
    if (routingCodeValue1 != null) body['routing_code_value_1'] = routingCodeValue1;
    if (routingCodeType2 != null) body['routing_code_type_2'] = routingCodeType2;
    if (routingCodeValue2 != null) body['routing_code_value_2'] = routingCodeValue2;
    if (bicSwift != null) body['bic_swift'] = bicSwift;
    if (iban != null) body['iban'] = iban;
    if (defaultBeneficiary != null) body['default_beneficiary'] = defaultBeneficiary;
    if (bankAddress != null) body['bank_address'] = bankAddress;
    if (bankName != null) body['bank_name'] = bankName;
    if (bankAccountType != null) body['bank_account_type'] = bankAccountType;
    if (beneficiaryEntityType != null) body['beneficiary_entity_type'] = beneficiaryEntityType;
    if (beneficiaryCompanyName != null) body['beneficiary_company_name'] = beneficiaryCompanyName;
    if (beneficiaryFirstName != null) body['beneficiary_first_name'] = beneficiaryFirstName;
    if (beneficiaryLastName != null) body['beneficiary_last_name'] = beneficiaryLastName;
    if (beneficiaryCity != null) body['beneficiary_city'] = beneficiaryCity;
    if (beneficiaryPostcode != null) body['beneficiary_postcode'] = beneficiaryPostcode;
    if (beneficiaryStateOrProvince != null) body['beneficiary_state_or_province'] = beneficiaryStateOrProvince;
    if (beneficiaryDateOfBirth != null) body['beneficiary_date_of_birth'] = beneficiaryDateOfBirth;
    if (beneficiaryIdentificationType != null) body['beneficiary_identification_type'] = beneficiaryIdentificationType;
    if (beneficiaryIdentificationValue != null)
      body['beneficiary_identification_value'] = beneficiaryIdentificationValue;
    if (paymentTypes != null) body['payment_types'] = paymentTypes;
    if (onBehalfOf != null) body['on_behalf_of'] = onBehalfOf;
    return client.post(uri, body: body);
  }

  Future<Map<String, dynamic>> retrieve(String beneficiaryId) {
    var uri = '/beneficiaries/${beneficiaryId}';
    return client.get(uri);
  }
}
