require 'spec_helper'

module Registrar
  describe Registration do
    it 'registers a user' do
      student = {
        first_name: "Steven",
        last_name: "Nunez",
        email: "steven@flatironschool.com",
        phone: '702.386.5397',
        details: 'ruby:paid:immediately'
      }

      registration = Registration.new(student)
      expect(registration.acceptable?).to be_true
      expect(registration.student_name).to eq "Steven Nunez"
      expect(registration.student_email).to eq "steven@flatironschool.com"
      expect(registration.student_phone).to eq "(702) 386-5397"
      expect(registration.subject).to eq 'ruby'
      expect(registration.payment_status).to eq 'paid'
      expect(registration.availability).to eq 'immediately'
    end

    it "does not register a student if they haven't paid"
    it "sends prework notification for their respective class"
    it "rejects invalid numbers"
    it "formats phone numbers"
    it "normalizes email address"
    it "doesn't know how to deal with poorly formatted details"
  end
end
