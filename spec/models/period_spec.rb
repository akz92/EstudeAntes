require 'rails_helper.rb'

describe Period do
  it { is_expected.to validate_uniqueness_of :number }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_numericality_of :number }
  it { is_expected.to have_many :subjects }
  it { is_expected.to have_many(:events).through(:subjects) }

  it 'is valid when built by FactoryGirl' do
    period = build(:period)
    expect(period).to be_valid
  end

  it 'has an end_date after start_date' do
    period = build(:period, start_date: '05-05-2015', end_date: '01-01-2015')
    expect(period).to be_invalid
  end

  it 'is current if Date.today inside dates' do
    period = build(:period, start_date: (Date.today -1), end_date: (Date.today +1))
    period = period.is_current?
    expect(period.is_current).to eq(true)
  end

  it 'has default calendar hours if events empty' do
    period = build(:period)
    expect(period.calendar_hours).to eq(['06:00', '22:00'])
  end

  it 'has event calendar hours if events not empty' do
    period = create(:period, id: 1)
    subject = create(:subject, period_id: 1, id: 1)
    event = create(:event, subject_id: 1, start_time: '10:00', end_time: '12:00')
    expect(period.calendar_hours).to eq(['10:00', '12:00'])
  end

  it 'gets every event dates' do
    period = create(:period, id: 1)
    subject = create(:subject, period_id: 1, id: 1)
    event = create(:event, subject_id: 1, start_time: '10:00', end_time: '12:00')
    event = event.by_date(period, subject)
    event.save!
    event.fullcalendar_dates = event.fullcalendar_conversion
    expect(period.get_events).to eq(event.fullcalendar_dates)
  end
end
