
view: users {
  derived_table: {
    sql: SELECT 
        id,
        first_name,
        last_name,
        email,
        age,
        gender,
        state,
        city,
        country,
        created_at
      FROM `bigquery-public-data.thelook_ecommerce.users`
      LIMIT 10 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  set: detail {
    fields: [
        id,
	first_name,
	last_name,
	email,
	age,
	gender,
	state,
	city,
	country,
	created_at_time
    ]
  }
}
