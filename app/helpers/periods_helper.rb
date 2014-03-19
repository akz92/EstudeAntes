module PeriodsHelper

  def calendar_events(tests, event, n)
    x = 0
    y = 0
    result = []
    if event.weekday == n
      tests.each do |test|
        if (test.subject_id == event.subject_id) && (test.date.strftime("%w").to_i == event.weekday) && (test.is_project == false)
         x += 1

        elsif (test.subject_id == event.subject_id) && (test.date.strftime("%w").to_i == event.weekday) && (test.is_project == true)
         y += 1
        end
      end

      if x == 1 && y == 0 then result =  "%td.table-align.table-font.azul #{event.subject_name}"

      elsif x == 1 && y == 1 then result = "%td.table-align.table-font.verde #{event.subject_name}"

      elsif x == 0 && y == 1 then result = "%td.table-align.table-font.amarelo #{event.subject_name}"

      else result = "%td.table-align.table-font #{event.subject_name}" end

    else result = "%td" end
    engine = Haml::Engine.new(result)
    result = engine.render
    return result
  end
end
