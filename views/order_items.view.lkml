view: order_items {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.order_items` ;;

  # ===== 第2章で追加: フィールドセット定義 =====

  set: basic_info {
    fields: [created_date, sale_price, status, sale_price_tier]
  }

  # ===== ID関連フィールド =====

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "注文商品ID"
    description: "各注文商品のユニークな識別子"
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
    hidden: yes
    label: "在庫アイテムID"
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    hidden: yes
    label: "注文ID"
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
    hidden: yes
    label: "商品ID"
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
    label: "ユーザーID"
  }

  # ===== 日時関連フィールド =====

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
    label: "作成"
    description: "注文商品が作成された日時"
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
    label: "配達"
    description: "注文商品が配達された日時"
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.returned_at ;;
    label: "返品"
    description: "注文商品が返品された日時"
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
    label: "出荷"
    description: "注文商品が出荷された日時"
  }

  # ===== 基本情報関連フィールド =====

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    label: "販売価格"
    value_format_name: usd
    description: "注文商品の販売価格"
  }

  dimension: sale_price_tier {
    type: tier
    tiers: [0, 25, 50, 100, 200, 500]
    style: integer
    sql: ${sale_price} ;;
    label: "販売価格帯"
    description: "注文商品の販売価格を範囲に分けたもの"
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "ステータス"
    description: "注文商品のステータス（Complete、Shipped、Cancelled、Processing、Returned）"
    order_by_field: status_order
  }

  # ===== 第4章で追加: 日本語ステータス =====

  dimension: status_ja {
    type: string
    sql: CASE
      WHEN ${TABLE}.status = 'Processing' THEN '処理中'
      WHEN ${TABLE}.status = 'Shipped' THEN '発送済み'
      WHEN ${TABLE}.status = 'Cancelled' THEN 'キャンセル'
      WHEN ${TABLE}.status = 'Complete' THEN '完了'
      WHEN ${TABLE}.status = 'Returned' THEN '返品'
      ELSE 'その他'
    END ;;
    label: "注文ステータス（日本語）"
    description: "注文商品のステータスを日本語で表示"
    order_by_field: status_order
  }

  # ===== 第2章で追加: ソート順制御用dimension =====

  dimension: status_order {
    type: number
    hidden: yes
    sql: CASE
      WHEN ${TABLE}.status = 'Processing' THEN 1
      WHEN ${TABLE}.status = 'Shipped' THEN 2
      WHEN ${TABLE}.status = 'Cancelled' THEN 3
      WHEN ${TABLE}.status = 'Complete' THEN 4
      WHEN ${TABLE}.status = 'Returned' THEN 5
      ELSE 6
    END ;;
  }

  # ===== メジャー（集計）フィールド =====

  measure: count {
    type: count
    label: "注文商品数"
    drill_fields: [id, basic_info*]
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    label: "総売上"
    value_format_name: usd
    description: "すべての注文商品の総売上"
    drill_fields: [basic_info*, product_id]
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    label: "平均販売価格"
    value_format_name: usd
    description: "注文商品の平均販売価格"
  }

  measure: max_sale_price {
    type: max
    sql: ${sale_price} ;;
    label: "最高販売価格"
    value_format_name: usd
    description: "注文商品の最高販売価格"
  }

  measure: min_sale_price {
    type: min
    sql: ${sale_price} ;;
    label: "最低販売価格"
    value_format_name: usd
    description: "注文商品の最低販売価格"
  }

  # ===== 第2章で追加: フィルター付きmeasure =====

  measure: return_count {
    type: count
    label: "返品数"
    description: "ステータスが返品（Returned）の注文商品の数"
    filters: [status: "Returned"]
  }

  measure: return_rate {
    type: number
    label: "返品率"
    description: "総商品数に対する返品された商品の割合"
    sql: SAFE_DIVIDE(${return_count}, ${count}) ;;
    value_format: "0.00%"
  }
}
