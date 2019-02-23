RSpec.describe "[B] 部署毎の人数を数える" do # rubocop:disable RSpec/DescribeClass
  let(:answer) { ["営業部 2", "人事部 2", "システム部 6", "総務部 2"].join("\n") }
  before do
    FactoryBot.create(:division, division_id: 101, division_name: "営業部")
    FactoryBot.create(:division, division_id: 102, division_name: "人事部")
    FactoryBot.create(:division, division_id: 103, division_name: "システム部")
    FactoryBot.create(:division, division_id: 104, division_name: "総務部")
    [103, 103, 103, 103, 104, 103, 102, 101, 104, 103, 102, 101].each do |division_id|
      FactoryBot.create(:member, division_id: division_id)
    end
  end

  it "ActiveRecord-1" do
    result = Division.includes(:members).order("division_id ASC").all
    answer = result.map {|d| "#{d.division_name} #{d.members.size}" }.join("\n")
    expect(answer).to eq(answer)
  end

  it "ActiveRecord-2" do
    result = Member.left_outer_joins(:division).group("divisions.division_name").order("divisions.division_id").count
    output = result.to_a.map {|r| r.join(" ") }.join("\n")
    expect(output).to eq(answer)
  end

  it "生SQL" do
    sql = File.read(File.expand_path("b_divisions_number.sql", __dir__))
    result = Division.connection.execute(sql)
    output = result.to_a.map {|r| r.join(" ")}.join("\n")
    expect(output).to eq(answer)
  end
end
