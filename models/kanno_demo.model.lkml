connection: "kanno-test"

# Viewファイルを読み込む
include: "/views/**/*.view.lkml"

# Products Explore
explore: products {
  label: "商品分析"
  description: "商品情報を分析"
}

# Users Explore
explore: users {
  label: "ユーザー分析"
  description: "ユーザー情報を分析"
}

# Order Items Explore（第3章: JOINを追加、第4章: フィルターパラメータを追加）
explore: order_items {
  label: "ECデータ"
  view_label: "注文アイテム"
  description: "注文されたアイテムの詳細分析用"

  # ===== 第4章で追加: フィルターパラメータ =====

  # 常に適用されるWHERE句（2020年1月1日以降のデータのみを取得）
  sql_always_where: ${order_items.created_date} >= DATE("2020-01-01") ;;

  # 条件付きフィルター（商品カテゴリのフィルターを推奨、ブランドを指定すれば削除可能）
  conditionally_filter: {
    filters: [products.category: ""]
    unless: [products.brand]
  }

  # 必須フィルター（常に表示され削除不可、デフォルトで「完了」ステータスのみ）
  always_filter: {
    filters: [order_items.status_ja: "完了"]
  }

  # Users View との結合
  join: users {
    view_label: "ユーザー"
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  # Products View との結合
  join: products {
    view_label: "商品"
    type: left_outer
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  # Events View との結合
  join: events {
    view_label: "イベント"
    type: left_outer
    sql_on: ${order_items.user_id} = ${events.user_id} ;;
    relationship: many_to_many
  }
}

# Orders Explore
explore: orders {
  label: "注文分析"
  description: "注文の状況、配送日数、返品率を分析"
}

# Inventory Items Explore
explore: inventory_items {
  label: "在庫分析"
  description: "在庫の状況、利益率、在庫日数を分析"
}

# Distribution Centers Explore
explore: distribution_centers {
  label: "配送センター分析"
  description: "配送センターの情報を分析"
}

# Events Explore
explore: events {
  label: "イベント分析"
  description: "ユーザー行動、セッション、流入元を分析"
}
