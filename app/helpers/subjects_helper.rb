module SubjectsHelper

  def tests_accordion(test)

    result = ".panel.panel-default
  .panel-heading
    %h4.panel-title
      %a.accordion-toggle{\"data-parent\" => \"#accordion\", \"data-toggle\" => \"collapse\", :href => \"#collapse" + test.id.to_s + "\"}
        " + formatted_date(test.date) + "
  #collapse" + test.id.to_s + ".panel-collapse.collapse.in
    .panel-body
      Nota:" + trim(test.grade).to_s + "/" + test.value.to_s + "
      %br
      Materia:" + test.note.to_s + "
      %br
      "

    bla = " \#{link_to '', edit_period_subject_test_path(@period, @subject, test), class: \"icon-pencil icon-white\"} \#{link_to '', period_subject_test_path(@period, @subject, test), method: :delete, data: { confirm: 'Are you sure?' }, class: \"icon-trash icon-white\"}"

    engine = Haml::Engine.new(result)
    result = engine.render
    return result
  end
end
