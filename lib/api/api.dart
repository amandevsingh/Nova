import 'package:flutter/foundation.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String idToken;
ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
      cache: GraphQLCache(),
      link: AuthLink(getToken: () async {
        if (getTokens() == null) {
          return "";
        } else {
          return "Bearer ${idToken}";
        }
      }).concat(HttpLink(
          'https://betanovagraphql.hlthclub.in/v1/graphql' /*,
        defaultHeaders: {
          'X-Parse-Application-Id': "",
          'X-Parse-Client-Key': "",
          'X-Parse-Master-Key': "",
          //'X-Parse-REST-API-Key' : kParseRestApiKey,
        },*/
          ))),
);
GraphQLClient clientSend = GraphQLClient(
    cache: GraphQLCache(),
    link: AuthLink(getToken: () async {
      if (getTokens() == null) {
        return "";
      } else {
        return "Bearer ${idToken}";
      }
    }).concat(HttpLink(
        'https://betanovagraphql.hlthclub.in/v1/graphql' /*,
        defaultHeaders: {
          'X-Parse-Application-Id': "",
          'X-Parse-Client-Key': "",
          'X-Parse-Master-Key': "",
          //'X-Parse-REST-API-Key' : kParseRestApiKey,
        },*/
        )));

Future<String> getTokens() async {
  var tokens = await Cognito.getTokens();
  idToken = tokens.idToken;
  return idToken;
}

final String getTasksQuery = """
query (\$phone: String!) {
  org_users(where: {phone: {_eq: \$phone}}, limit: 1) {
    id
    name
    phone
    gender
    email
    age
    user_centers {
      center {
        code
        name
        id
      }
    }
    user_cities {
      city {
        city
        city_code
        id
      }
    }
    user_roles {
      role {
        name
        id
      }
    }
  }
}

""";
final String getTreatmentDetail = """
query treatment_formatted_data (\$referral_id: String!) {
  treatment_data(referral_id: \$referral_id) {
    cycle
    last_status_date
    last_status 
    treatment_cycle
    dates
    values
  }
}
""";
final String getActivePatients = """
 query ActiveTreatments {
  referral_patient_referrals(where: {registrations: {registration_id: {_is_null: false}}},order_by: {created_at: desc}) {
    age
    email
    gender
    id
    name
    phone
    referred_date
    city {
      city
      city_code
      id
    }
    registrations {
      patient_registration {
        id
        registered_date
        consultant_name
      }
    }
    referral_center_mapping {
      center {
        id
        name
      }
    }
    patient_referral_notes {
      remarks
    }
    treatment_status {
      treatment_status
      treatment_date
    }
  }
}
""";
final String getDoctorQuery = """
query MyQuery {
   query_notes_user_queries(order_by: {created_at: desc}){
    id
    query_type
    status
    title
    closure_date
    query_center_mapping {
      center {
        id
        name
      }
    }
    referral {
      age
      city {
        city
        id
      }
      email
      gender
      id
      name
      phone
      referred_date
    }
    user_query_notes(order_by: {created_at: asc}) {
      attachment
      id
      remarks
      created_by_id
    }
  }
}
""";
final String getNotificationQuery = """
query MyQuery {
  notification_list(limit: 50) {
    body
    date
    title
  }
}

""";
final String getInActivePatients = """
query MyQuery {
  referral_patient_referrals (where: {_not: {registrations: {registration_id: {_is_null: false}}}},order_by: {created_at: desc}) {
    age
    email
    gender
    id
    name
    phone
    referred_date
    city {
      city
      city_code
      id
    }
    registrations {
      patient_registration {
        id
        registered_date
        consultant_name
      }
    }
    referral_center_mapping {
      center {
        id
        name
      }
    }
    patient_referral_notes {
      remarks
    }
  }
}
""";

final String createTaskMutation = """
mutation CreateTodo(\$id: ID!, \$title: String!) {
  createTodo(id: \$id, title: \$title, completed: false) {
    id
  }
}
""";

final String savePatientReferral = """
mutation (\$object:referral_patient_referrals_insert_input!){
  insert_referral_patient_referrals_one(object: \$object) {
    id
  }
}
""";
final String savePatientData = """
mutation UpdateUser(\$_set: org_users_set_input!, \$pk_columns: org_users_pk_columns_input!) {
  update_org_users_by_pk(pk_columns: \$pk_columns, _set: \$_set) {
    id
  }
}
""";
final String saveGeneralQuery = """
mutation MyMutation(\$object: query_notes_user_queries_insert_input!) {
  insert_query_notes_user_queries_one(object: \$object) {
    id
  }
}
""";
final String saveDocumentQuery = """
mutation MyMutation(\$object: query_notes_user_queries_insert_input!) {
  insert_query_notes_user_queries_one(object: \$object) {
    id
  }
}
""";
final String savePatientQuery = """
mutation MyMutation(\$object: query_notes_user_queries_insert_input!) {
  insert_query_notes_user_queries_one(object: \$object) {
    id
  }
}
""";
final String doctorContent = """
query MyContent {
  data_user_content(where: {is_active: {_eq: true}}, order_by: {created_at: desc}, offset: 0, limit: 10) {
    id
    img_url
    title
    description
    article_url
    created_at
  }
}
""";
final String doctorArticleUrl = """
query articleLink(\$article_id: String!) {
  user_article(article_id: \$article_id) {
    url
  }
}
""";
final String addNotificationToken = """
mutation addNotificationToken(\$device_id: String!, \$os: String!, \$platform: String!, \$token: String!) {
  register_notification_token(device_id: \$device_id, os: \$os, platform: \$platform, token: \$token) {
    message
  }
}
""";
