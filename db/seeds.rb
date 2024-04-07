# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Grade.find_or_create_by!(name: "1年")
Grade.find_or_create_by!(name: "2年")
Grade.find_or_create_by!(name: "3年")

UserClass.find_or_create_by!(name: "1組")
UserClass.find_or_create_by!(name: "2組")
UserClass.find_or_create_by!(name: "3組")
UserClass.find_or_create_by!(name: "4組")
UserClass.find_or_create_by!(name: "5組")
UserClass.find_or_create_by!(name: "6組")
UserClass.find_or_create_by!(name: "7組")
UserClass.find_or_create_by!(name: "8組")
UserClass.find_or_create_by!(name: "9組")
UserClass.find_or_create_by!(name: "10組")
UserClass.find_or_create_by!(name: "A組")
UserClass.find_or_create_by!(name: "B組")
UserClass.find_or_create_by!(name: "C組")
UserClass.find_or_create_by!(name: "D組")
UserClass.find_or_create_by!(name: "E組")
UserClass.find_or_create_by!(name: "F組")
UserClass.find_or_create_by!(name: "G組")
UserClass.find_or_create_by!(name: "H組")
UserClass.find_or_create_by!(name: "I組")
UserClass.find_or_create_by!(name: "J組")

#教科名
Subject.find_or_create_by!(subject_name: "国語")
Subject.find_or_create_by!(subject_name: "数学")
Subject.find_or_create_by!(subject_name: "理科")
Subject.find_or_create_by!(subject_name: "社会")
Subject.find_or_create_by!(subject_name: "英語")

#テストの種類
TestName.find_or_create_by(test_name: '中間テスト')
TestName.find_or_create_by(test_name: '期末テスト')
TestName.find_or_create_by(test_name: '実力テスト')
TestName.find_or_create_by(test_name: '小テスト')

#満点
MaxScore.find_or_create_by(max_score: '100')
MaxScore.find_or_create_by(max_score: '50')
MaxScore.find_or_create_by(max_score: '20')
MaxScore.find_or_create_by(max_score: '10')









