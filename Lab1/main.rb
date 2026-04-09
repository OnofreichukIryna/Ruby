require_relative 'project_manager'


projects = {
  1 => {
    title: "Розробка сайту",
    team: ["Іван Петренко", "Марія Коваль"],
    tags: ["Web", "Ruby", "Rails"],
    client: "ТОВ Ромашка",
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
ProjectManager.list_projects(projects)

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
ProjectManager.add_project(projects, new_project)

ProjectManager.edit_project(projects, 2, { status: "in_progress", budget: 35000.00 })

puts "\n=== Пошук за назвою 'сайт' ==="
puts ProjectManager.find_by_title(projects, "сайт").inspect

puts "\n=== Фільтрація за статусом 'in_progress' ==="
puts ProjectManager.filter_by_status(projects, "in_progress").inspect

puts "\n=== Фільтрація за тегом 'Web' ==="
puts ProjectManager.filter_by_tag(projects, "Web").inspect

ProjectManager.save_to_json(projects, "projects.json")
loaded_from_json = ProjectManager.load_from_json("projects.json")

ProjectManager.delete_project(projects, 1)

ProjectManager.edit_project(projects, 999, { status: "cancelled" }) 
ProjectManager.load_from_yaml("missing_file.yml")