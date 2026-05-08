module ProjectsHelper
  def deadline_badge(project)
    # 1. Якщо дати немає взагалі
    return content_tag(:span, "без дедлайну", class: "badge bg-secondary") if project.deadline.blank?

    # 2. Якщо проєкт вже завершено або скасовано — дедлайн більше не "горить"
    if project.completed?
      return content_tag(:span, "Виконано", class: "badge bg-primary")
    elsif project.cancelled?
      return content_tag(:span, "Скасовано", class: "badge bg-dark")
    end

    # 3. Обчислюємо дні тільки для активних проєктів (planned, in_progress)
    days_left = (project.deadline - Date.current).to_i

    if days_left.negative?
      content_tag(:span, "Протерміновано", class: "badge bg-danger")
    elsif days_left <= 7
      content_tag(:span, "Скоро", class: "badge bg-warning text-dark")
    else
      content_tag(:span, "через #{days_left} днів", class: "badge bg-success")
    end
  end
end
