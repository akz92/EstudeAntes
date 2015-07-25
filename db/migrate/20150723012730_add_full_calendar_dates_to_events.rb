class AddFullCalendarDatesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fullcalendar_dates, :jsonb
  end
end
