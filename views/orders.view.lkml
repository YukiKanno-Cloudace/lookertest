view: orders {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.orders` ;;

  # ===== Primary Key =====

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
    label: "注文ID"
  }

  # ===== Foreign Keys =====

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
    label: "ユーザーID"
  }

  # ===== 注文情報 =====

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "ステータス"
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    label: "性別"
  }

  dimension: num_of_item {
    type: number
    sql: ${TABLE}.num_of_item ;;
    label: "商品点数"
  }

  # ===== 日時情報 =====

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
    label: "注文日"
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month
    ]
    sql: ${TABLE}.shipped_at ;;
    label: "出荷日"
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month
    ]
    sql: ${TABLE}.delivered_at ;;
    label: "配達日"
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month
    ]
    sql: ${TABLE}.returned_at ;;
    label: "返品日"
  }

  # ===== 計算フィールド =====

  dimension: days_to_ship {
    type: number
    sql: DATE_DIFF(${shipped_date}, ${created_date}, DAY) ;;
    label: "出荷までの日数"
    description: "注文から出荷までにかかった日数"
  }

  dimension: days_to_deliver {
    type: number
    sql: DATE_DIFF(${delivered_date}, ${shipped_date}, DAY) ;;
    label: "配送日数"
    description: "出荷から配達までにかかった日数"
  }

  dimension: is_returned {
    type: yesno
    sql: ${returned_date} IS NOT NULL ;;
    label: "返品あり"
  }

  # ===== Measures =====

  measure: count {
    type: count
    label: "注文数"
    drill_fields: [order_id, created_date, status, num_of_item]
  }

  measure: total_items {
    type: sum
    sql: ${num_of_item} ;;
    label: "総商品点数"
  }

  measure: average_items_per_order {
    type: average
    sql: ${num_of_item} ;;
    label: "注文あたり平均商品点数"
    value_format_name: decimal_2
  }

  measure: returned_orders_count {
    type: count
    filters: [is_returned: "yes"]
    label: "返品された注文数"
  }

  measure: return_rate {
    type: number
    sql: 1.0 * ${returned_orders_count} / NULLIF(${count}, 0) ;;
    label: "返品率"
    value_format_name: percent_2
  }

  measure: average_days_to_ship {
    type: average
    sql: ${days_to_ship} ;;
    label: "平均出荷日数"
    value_format_name: decimal_1
  }

  measure: average_days_to_deliver {
    type: average
    sql: ${days_to_deliver} ;;
    label: "平均配送日数"
    value_format_name: decimal_1
  }
}

