require_relative 'project_manager'


projects = {
  1 => {
    title: "Розробка сайту",
    team: ["Іван Петренко", "Марія Коваль"],
    tags: ["Web", "Ruby", "Rails"],
    client: "Ромашка",
    start_date: "2024-03-01",
    deadline: "2024-06-01",
    budget: 50000.00,
    status: "in_progress"
  },
  2 => {
    title: "Мобільний додаток",
    team: ["Олег Сидоренко"],
    tags: ["Mobile", "React Native"],
    client: "ФОП Іваненко",
    start_date: "2024-04-01",
    deadline: "2024-08-01",
    budget: 30000.00,
    status: "planned"
  }
}

puts "=== Початковий список ==="
list_projects(projects)

new_project = {
  title: "CRM система",
  team: ["Анна Бойко"],
  tags: ["Web", "Vue", "Node.js"],
  client: "ПрАТ Вектор",
  start_date: "2024-05-15",
  deadline: "2024-12-01",
  budget: 120000.00,
  status: "planned"
}

loaded_from_json = load_from_json("projects.json")
list_projects(loaded_from_json)
delete_project(projects, 1)

loaded_from_yaml = load_from_yaml("projects.yaml")
list_projects(loaded_from_yaml)
