view: products {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.products` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "商品ID"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    label: "商品名"
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    label: "ブランド"
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "カテゴリ"
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
    label: "部門"
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
    label: "小売価格"
    value_format_name: usd
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    label: "原価"
    value_format_name: usd
  }

  measure: count {
    type: count
    label: "商品数"
    drill_fields: [id, name, brand, category]
  }

  measure: average_retail_price {
    type: average
    sql: ${retail_price} ;;
    label: "平均小売価格"
    value_format_name: usd
  }
}
