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
