class Project
  attr_accessor :title, :team, :tags, :client, :start_date, :deadline, :budget, :status

  def initialize(title:, team:, tags:, client:, start_date:, deadline:, budget:, status: "planned")
    @title = title
    @team = team
    @tags = tags
    @client = client
    @start_date = start_date
    @deadline = deadline
    @budget = budget
    @status = status
  end

  # Конвертація об'єкта у хеш для JSON
  def to_h
    {
      title: @title,
      team: @team,
      tags: @tags,
      client: @client,
      start_date: @start_date,
      deadline: @deadline,
      budget: @budget,
      status: @status
    }
  end

  # Створення об'єкта з хешу (статичний метод)
  def self.from_h(hash)
    new(
      title: hash[:title],
      team: hash[:team],
      tags: hash[:tags],
      client: hash[:client],
      start_date: hash[:start_date],
      deadline: hash[:deadline],
      budget: hash[:budget],
      status: hash[:status]
    )
  end
end