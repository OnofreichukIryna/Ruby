require 'json'
require 'yaml'
require_relative 'project'

class ProjectManager
  attr_reader :collection

  def initialize
    @collection = {} # ID => Project object
  end

  def add_project(project)
    new_id = @collection.keys.empty? ? 1 : @collection.keys.max + 1
    @collection[new_id] = project
    new_id
  end

  def edit_project(id, new_data)
    return false unless @collection.key?(id)
    
    project = @collection[id]
    new_data.each do |key, value|
      project.send("#{key}=", value) if project.respond_to?("#{key}=")
    end
    true
  end

  def delete_project(id)
    @collection.delete(id)
  end

  # Пошук та фільтрація
  def find_by_title(query)
    @collection.select { |_, p| p.title.downcase.include?(query.downcase) }
  end

  def filter_by_status(status)
    @collection.select { |_, p| p.status == status }
  end

  # YAML серіалізація (нативна)
  def save_to_yaml(filename)
    File.write(filename, YAML.dump(@collection))
  end

  def load_from_yaml(filename)
    return false unless File.exist?(filename)
    @collection = YAML.safe_load_file(filename, permitted_classes: [Symbol, Project])
    true
  end

  # JSON серіалізація (через to_h / from_h)
  def save_to_json(filename)
    json_data = @collection.transform_values(&:to_h)
    File.write(filename, JSON.pretty_generate(json_data))
  end

  def load_from_json(filename)
    return false unless File.exist?(filename)
    raw_data = JSON.parse(File.read(filename), symbolize_names: true)
    
    @collection = raw_data.each_with_object({}) do |(id, data), hash|
      hash[id.to_s.to_i] = Project.from_h(data)
    end
    true
  end
end