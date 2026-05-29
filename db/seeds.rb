# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

sample_reports = [
  {
    playerName: "Caleb Brooks",
    position: "QB",
    grade: 92,
    team: "Chicago",
    height: "6'1\"",
    weight: 215,
    age: 21,
    strengths: "Elite arm talent, excellent accuracy, strong decision making under pressure.",
    weaknesses: "Can hold the ball too long; needs to improve touch on short intermediate throws."
  },
  {
    playerName: "Marcus Hill",
    position: "RB",
    grade: 84,
    team: "Dallas",
    height: "5'11\"",
    weight: 208,
    age: 22,
    strengths: "Excellent vision, explosive burst, finishes runs with power.",
    weaknesses: "Pass protection needs work; not elite in short-yardage stacked boxes."
  },
  {
    playerName: "Eli Johnson",
    position: "WR",
    grade: 88,
    team: "Miami",
    height: "6'2\"",
    weight: 195,
    age: 20,
    strengths: "Clean release, reliable hands, creates separation with route nuance.",
    weaknesses: "Limited top-end speed; can struggle against physical press corners."
  },
  {
    playerName: "Noah Carter",
    position: "TE",
    grade: 79,
    team: "Seattle",
    height: "6'5\"",
    weight: 252,
    age: 21,
    strengths: "Reliable hands, competitive blocker, wins contested catches.",
    weaknesses: "Lacks consistent separation against linebackers; route tempo can lag."
  },
  {
    playerName: "Darius King",
    position: "CB",
    grade: 90,
    team: "New York",
    height: "6'0\"",
    weight: 190,
    age: 22,
    strengths: "Sticky man coverage, strong ball skills, physical tackler in run support.",
    weaknesses: "Occasionally bites on double moves; can be grabby downfield."
  }
]

sample_reports.each do |attrs|
  Report.find_or_initialize_by(playerName: attrs[:playerName], position: attrs[:position]).tap do |report|
    report.assign_attributes(attrs)
    report.save!
  end
end
