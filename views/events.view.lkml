view: events {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.events` ;;

  # ===== Primary Key =====

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "イベントID"
  }

  # ===== Foreign Keys =====

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
    label: "ユーザーID"
  }

  # ===== イベント情報 =====

  dimension: sequence_number {
    type: number
    sql: ${TABLE}.sequence_number ;;
    label: "シーケンス番号"
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    label: "セッションID"
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
    label: "イベントタイプ"
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
    label: "IPアドレス"
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
    label: "ブラウザ"
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
    label: "流入元"
  }

  dimension: uri {
    type: string
    sql: ${TABLE}.uri ;;
    label: "URI"
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    label: "市"
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    label: "州"
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
    label: "郵便番号"
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    label: "国"
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
    label: "緯度"
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
    label: "経度"
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
    label: "OS"
  }

  # ===== 日時情報 =====

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      hour_of_day,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    label: "発生日時"
  }

  # ===== 位置情報 =====

  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
    label: "位置"
  }

  # ===== Measures =====

  measure: count {
    type: count
    label: "イベント数"
    drill_fields: [id, created_time, event_type, user_id, session_id]
  }

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ;;
    label: "セッション数"
  }

  measure: user_count {
    type: count_distinct
    sql: ${user_id} ;;
    label: "ユーザー数"
  }

  measure: events_per_session {
    type: number
    sql: 1.0 * ${count} / NULLIF(${session_count}, 0) ;;
    label: "セッションあたりイベント数"
    value_format_name: decimal_2
  }
}

