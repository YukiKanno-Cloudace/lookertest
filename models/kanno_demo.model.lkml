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

# Order Items Explore
explore: order_items {
  label: "注文商品分析"
  description: "注文商品の売上、ステータス、価格帯を分析"
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
