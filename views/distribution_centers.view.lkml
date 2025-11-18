view: distribution_centers {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.distribution_centers` ;;

  # ===== Primary Key =====

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "配送センターID"
  }

  # ===== 基本情報 =====

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    label: "配送センター名"
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
    label: "配送センター数"
    drill_fields: [id, name]
  }
}

