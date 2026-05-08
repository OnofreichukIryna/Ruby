require_relative 'project_manager'

class App
  YAML_FILE = 'projects.yaml'
  JSON_FILE = 'projects.json'

  def initialize
    @manager = ProjectManager.new
    load_initial_data
  end 

  def run
    loop do
      print_menu
      choice = gets.chomp.to_i
      
      case choice
      when 1 then list_all
      when 2 then add_new
      when 3 then edit_existing
      when 4 then remove
      when 5 then search
      when 6 then save_data
      when 0 then break
      else puts "Невірний вибір!"
      end
    end
  ensure
    @manager.save_to_yaml(YAML_FILE)
    puts "\nДані автоматично збережено у #{YAML_FILE}. До зустрічі!"
  end

  private

  def load_initial_data
    if @manager.load_from_yaml(YAML_FILE)
      puts "Дані завантажено з YAML."
    elsif @manager.load_from_json(JSON_FILE)
      puts "YAML не знайдено, дані завантажено з JSON."
    else
      puts "Файли даних відсутні. Створено порожню колекцію."
    end
  end

  def print_menu
    puts "\n--- МЕНЕДЖЕР ПРОЄКТІВ ---"
    puts "1. Список проєктів"
    puts "2. Додати проєкт"
    puts "3. Редагувати проєкт"
    puts "4. Видалити проєкт"
    puts "5. Пошук за назвою"
    puts "6. Зберегти у JSON"
    puts "0. Вихід"
    print "> "
  end

  def list_all(collection = @manager.collection)
    if collection.empty?
      puts "Список порожній."
    else
      collection.each do |id, p|
        puts "[ID: #{id}] #{p.title} | Статус: #{p.status} | Бюджет: #{p.budget}"
      end
    end
  end

  def add_new
    print "Назва: "; title = gets.chomp
    print "Клієнт: "; client = gets.chomp
    print "Бюджет: "; budget = gets.chomp.to_f
    print "Команда (через кому): "; team = gets.chomp.split(',').map(&:strip)
    print "Теги (через кому): "; tags = gets.chomp.split(',').map(&:strip)
    print "Початок (РРРР-ММ-ДД): "; start_date = gets.chomp
    print "Дедлайн (РРРР-ММ-ДД): "; deadline = gets.chomp

    project = Project.new(
      title: title, team: team, tags: tags, client: client,
      start_date: start_date, deadline: deadline, budget: budget
    )
    id = @manager.add_project(project)
    puts "Проєкт додано з ID: #{id}"
  end

  def edit_existing
    print "Введіть ID для редагування: "; id = gets.chomp.to_i
    print "Нова назва або залиште порожнім, щоб не змінювати: "; title = gets.chomp
    
    data = {}
    data[:title] = title unless title.empty?
    
    if @manager.edit_project(id, data)
      puts "Оновлено!"
    else
      puts "Проєкт не знайдено."
    end
  end

  def remove
    print "Введіть ID для видалення: "; id = gets.chomp.to_i
    if @manager.delete_project(id)
      puts "Видалено!"
    else
      puts "Проєкт не знайдено."
    end
  end

  def search
    print "Що шукаємо?: "; query = gets.chomp
    results = @manager.find_by_title(query)
    list_all(results)
  end

  def save_data
    @manager.save_to_json(JSON_FILE)
    puts "Дані збережено у JSON."
  end
end

App.new.run