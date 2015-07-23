module SubjectsHelper

  def dynamic_div(id, note)
    div = "##{id}.accordian-body.collapse\n  %b> Matéria:\n  #{note}"
    engine = Haml::Engine.new(div)
    div = engine.render
    return div
  end
end
