require 'spec_helper'

module Registrar
  describe Registration do
    let(:student) do 
      {
        first_name: "Steven",
        last_name: "Nunez",
        email: "steven@flatironschool.com",
        phone: '702.386.5397',
        details: 'ruby:paid:immediately'
      }
    end

    it 'sets up user information' do
      registration = Registration.new(student)
      expect(registration.acceptable?).to be_true
      expect(registration.student_name).to eq "Steven Nunez"
      expect(registration.student_email).to eq "steven@flatironschool.com"
      expect(registration.student_phone).to eq "(702) 386-5397"
      expect(registration.subject).to eq 'ruby'
      expect(registration.payment_status).to eq 'paid'
      expect(registration.availability).to eq 'immediately'
    end

    context "unacceptable registration" do
      it "does not register a student if they haven't paid" do
        student[:details] = 'ruby:due:immediately'
        registration = Registration.new(student)
        expect(registration.acceptable?).to be_false
      end

      it "sends no notification" do
        student[:details] = 'ruby:due:immediately'
        registration = Registration.new(student)
        registration.execute!
        expect(registration.messages.count).to eq 0
      end
    end

    context "acceptable registration" do
      it "sends prework notification for their respective class" do
        registration = Registration.new(student)
        registration.execute!
        expect(registration.messages.count).to eq 1
      end
    end

    it "rejects invalid numbers" do 
      student[:phone] =  '123'
      expect {Registration.new(student)}.to raise_error(Registrar::InvalidPhoneError)

      student[:phone] =  'invalid'
      expect {Registration.new(student)}.to raise_error(Registrar::InvalidPhoneError)
    end

    it "formats phone numbers" do
      student[:phone] =  '7023-86-5397'
      registration = Registration.new(student)
      expect(registration.student_phone).to eq "(702) 386-5397"
    end

    it "normalizes email address" do 
      student[:email] =  "STEVEN@FlaTironsCHool.com"
      registration = Registration.new(student)
      expect(registration.student_email).to eq "steven@flatironschool.com"
    end
  end
end
