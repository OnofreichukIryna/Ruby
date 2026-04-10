# 7 Варіант 
# Менеджер проєктів

require 'json'
require 'yaml'

  # CRUD операції

  def add_project(collection, project_data)
    new_id = collection.keys.empty? ? 1 : collection.keys.max + 1
    
    collection[new_id] = project_data
    puts "Проєкт '#{project_data[:title]}' успішно додано з ID: #{new_id}."
    new_id
  end

  def edit_project(collection, id, new_data)
    unless collection.key?(id)
      puts "Помилка: Проєкт з ID #{id} не знайдено."
      return false
    end
    
    collection[id].merge!(new_data)
    puts "Проєкт з ID #{id} успішно оновлено."
    true
  end

  def delete_project(collection, id)
    unless collection.key?(id)
      puts "Помилка: Проєкт з ID #{id} не знайдено."
      return false
    end
    
    collection.delete(id)
    puts "Проєкт з ID #{id} успішно видалено."
    true
  end

  def list_projects(collection)
    if collection.empty?
      puts "Колекція проєктів порожня."
      return
    end

    puts "\n--- СПИСОК ПРОЄКТІВ ---"
    collection.each do |id, project|
      puts "[ID: #{id}] #{project[:title]} (Статус: #{project[:status]})"
      puts "  Клієнт: #{project[:client]} | Бюджет: #{project[:budget]}"
      puts "  Команда: #{project[:team].join(', ')}"
      puts "  Теги: #{project[:tags].join(', ')}"
      puts "  Терміни: #{project[:start_date]} - #{project[:deadline]}"
      puts "-" * 30
    end
  end

  # пошук та фільтрація

  def find_by_title(collection, query)
    collection.select do |_id, project|
      project[:title].downcase.include?(query.downcase)
    end
  end

  def filter_by_status(collection, status)
    collection.select { |_id, project| project[:status] == status }
  end

  def filter_by_tag(collection, tag)
    collection.select { |_id, project| project[:tags].include?(tag) }
  end

  # робота з файлами

  def save_to_json(collection, filename)
    File.write(filename, JSON.pretty_generate(collection))
    puts "Дані успішно збережено у #{filename}."
  end

  def load_from_json(filename)
    data = JSON.parse(File.read(filename), symbolize_names: true)
    
    data.transform_keys(&:to_s).transform_keys(&:to_i)
  rescue Errno::ENOENT
    puts "Помилка: Файл #{filename} не існує. Створено нову порожню колекцію."
    {} 
  end

  def save_to_yaml(collection, filename)
    File.write(filename, YAML.dump(collection))
    puts "Дані успішно збережено у #{filename}."
  end

  def load_from_yaml(filename)
    YAML.safe_load_file(filename, permitted_classes: [Symbol]) || {}
  rescue Errno::ENOENT
    puts "Помилка: Файл #{filename} не існує. Створено нову порожню колекцію."
    {}
  end
