require "rails_helper"

RSpec.describe "各グループの中でFIFAランクが最も高い国と低い国のランキング番号" do # rubocop:disable RSpec/DescribeClass
  let(:answer) {
    [
      ["グループ", "ランキング最上位", "ランキング最下位"],
      ["A", 3, 56],
      ["B", 1, 62],
      ["C", 8, 46],
      ["D", 7, 28],
      ["E", 6, 33],
      ["F", 5, 44],
      ["G", 2, 37],
      ["H", 11, 57]
    ]
  }
  it "ActiveRecord-1" do
    grouped = Worldcup2014::Country.group(:group_name)
    high_ranks = grouped.minimum(:ranking)
    low_ranks  = grouped.maximum(:ranking)
    output = high_ranks.merge(low_ranks) { |key, high_rank, low_rank| [key, high_rank, low_rank] }.values
    output.unshift(["グループ", "ランキング最上位", "ランキング最下位"])
    expect(output).to eq(answer)
  end

  it "ActiveRecord-2" do
    result = Worldcup2014::Country.group(:group_name).select("group_name as 'グループ'", "min(ranking) as 'ランキング最上位'", "max(ranking) as 'ランキング最下位'")
    output = result.to_a.map {|r| r.attributes.except("id").values }
    output.unshift(["グループ", "ランキング最上位", "ランキング最下位"])
    expect(output).to eq(answer)
  end

  it "生SQL" do
    file = File.basename(__FILE__).match(/\A(.*)_spec\.rb\z/) { |matched| "#{matched[1]}.sql" }
    sql  = File.read(File.expand_path(file, __dir__))
    result = Worldcup2014::Country.connection.execute(sql)
    output = [result.fields].concat(result.each)
    expect(output).to eq(answer)
  end
end
