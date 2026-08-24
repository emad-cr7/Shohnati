class AuthQueries {
  static const String loginMutation = r'''
  mutation Login($username: String!, $password: String!, $rememberMe: Boolean!) {
    login(input: {
      username: $username
      password: $password
      rememberMe: $rememberMe
    }) {
      token
      expiresAt
      user {
        id
        username
        active
        isSuper
      }
    }
  }
''';

  static const String registerMutation = r'''
  mutation Register(
    $businessName: String!
    $name: String
    $email: String!
    $password: String!
    $mobile: String!
    $zoneId: Int!
    $subzoneId: Int!
    $address: String!
    $postalCode: String
    $paymentMethodCode: PaymentMethodCode!
    $customerTypeCode: CustomerTypeCode!
  ) {
    register(input: {
      businessName: $businessName
      name: $name
      email: $email
      password: $password
      mobile: $mobile
      zoneId: $zoneId
      subzoneId: $subzoneId
      address: $address
      postalCode: $postalCode
      paymentMethodCode: $paymentMethodCode
      customerTypeCode: $customerTypeCode
    })
  }
''';
}
