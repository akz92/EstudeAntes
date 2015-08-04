module SubjectsHelper
  # Creates a hidden div containing the Test's/Project's note
  def dynamic_div(id, note)
    div = "##{id}.accordian-body.collapse\n  %b> Matéria:\n  #{note}"
    engine = Haml::Engine.new(div)
    div = engine.render
    return div
  end
end
