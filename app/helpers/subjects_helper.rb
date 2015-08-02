module SubjectsHelper
  def formatted_date(date)
    return date.strftime("%d de %B, %Y")
  end

  def dynamic_div(id, note)
    div = "##{id}.accordian-body.collapse\n  %b> Matéria:\n  #{note}"
    engine = Haml::Engine.new(div)
    div = engine.render
    return div
  end
end
