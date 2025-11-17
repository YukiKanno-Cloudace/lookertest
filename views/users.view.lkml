view: users {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.users` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "ユーザーID"
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    label: "名"
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    label: "姓"
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    label: "メールアドレス"
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    label: "年齢"
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    label: "性別"
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    label: "州"
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    label: "市"
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    label: "国"
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
    label: "郵便番号"
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
    label: "流入元"
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    label: "登録"
  }

  measure: count {
    type: count
    label: "ユーザー数"
    drill_fields: [id, first_name, last_name, email, country, state]
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
    label: "平均年齢"
    value_format_name: decimal_1
  }
}
