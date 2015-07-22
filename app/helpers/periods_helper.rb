module PeriodsHelper

  #def calendar_events(tests, event, n)
  #  x = 0
  #  y = 0
  #  result = []
  #  if event.start_date.wday == n
  #    tests.each do |test|
  #      if (test.subject_id == event.subject_id) && (test.date.strftime("%w").to_i == event.start_date.wday) && (test.is_project == false)
  #       x += 1

  #      elsif (test.subject_id == event.subject_id) && (test.date.strftime("%w").to_i == event.start_date.wday) && (test.is_project == true)
  #       y += 1
  #      end
  #    end

  #    if x == 1 && y == 0 then result =  "%td.table-align.table-font.azul #{event.title}"

  #    elsif x == 1 && y == 1 then result = "%td.table-align.table-font.verde #{event.title}"

  #    elsif x == 0 && y == 1 then result = "%td.table-align.table-font.amarelo #{event.title}"

  #    else result = "%td.table-align.table-font #{event.title}" end

  #  else result = "%td" end
  #  engine = Haml::Engine.new(result)
  #  result = engine.render
  #  return result
  #end

  def trim num
    i, f = num.to_i, num.to_f
    i == f ? i : f
  end
end
