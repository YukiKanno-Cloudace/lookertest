
view: products {
  derived_table: {
    sql: SELECT 
        id,
        name,
        brand,
        category,
        retail_price
      FROM `bigquery-public-data.thelook_ecommerce.products`
      LIMIT 5 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  set: detail {
    fields: [
        id,
	name,
	brand,
	category,
	retail_price
    ]
  }
}
