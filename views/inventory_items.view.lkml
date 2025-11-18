view: inventory_items {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.inventory_items` ;;

  # ===== Primary Key =====

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "在庫アイテムID"
  }

  # ===== Foreign Keys =====

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
    hidden: yes
    label: "商品ID"
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
    hidden: yes
    label: "配送センターID"
  }

  # ===== 基本情報 =====

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
    label: "ブランド"
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
    label: "カテゴリ"
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
    label: "部門"
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
    label: "商品名"
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
    label: "小売価格"
    value_format_name: usd
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    label: "原価"
    value_format_name: usd
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
    label: "SKU"
  }

  # ===== 日時情報 =====

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.created_at ;;
    label: "作成日"
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.sold_at ;;
    label: "販売日"
  }

  # ===== 計算フィールド =====

  dimension: is_sold {
    type: yesno
    sql: ${sold_date} IS NOT NULL ;;
    label: "販売済み"
  }

  dimension: profit_margin {
    type: number
    sql: ${product_retail_price} - ${cost} ;;
    label: "利益額"
    value_format_name: usd
  }

  dimension: profit_margin_percentage {
    type: number
    sql: 100.0 * (${product_retail_price} - ${cost}) / NULLIF(${product_retail_price}, 0) ;;
    label: "利益率"
    value_format_name: percent_1
  }

  dimension: days_in_inventory {
    type: number
    sql: DATE_DIFF(COALESCE(${sold_date}, CURRENT_DATE), ${created_date}, DAY) ;;
    label: "在庫日数"
    description: "在庫として保管されている日数"
  }

  # ===== Measures =====

  measure: count {
    type: count
    label: "在庫数"
    drill_fields: [id, product_name, product_brand, cost, product_retail_price]
  }

  measure: sold_count {
    type: count
    filters: [is_sold: "yes"]
    label: "販売済み在庫数"
  }

  measure: unsold_count {
    type: count
    filters: [is_sold: "no"]
    label: "未販売在庫数"
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
    label: "総原価"
    value_format_name: usd
  }

  measure: total_retail_value {
    type: sum
    sql: ${product_retail_price} ;;
    label: "総小売価値"
    value_format_name: usd
  }

  measure: average_profit_margin {
    type: average
    sql: ${profit_margin} ;;
    label: "平均利益額"
    value_format_name: usd
  }

  measure: average_profit_margin_percentage {
    type: average
    sql: ${profit_margin_percentage} ;;
    label: "平均利益率"
    value_format_name: percent_1
  }

  measure: average_days_in_inventory {
    type: average
    sql: ${days_in_inventory} ;;
    label: "平均在庫日数"
    value_format_name: decimal_1
  }
}

