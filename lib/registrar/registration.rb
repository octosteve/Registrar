module Registrar
  class Registration
    attr_reader :student_name, 
      :student_email, 
      :student_phone, 
      :subject,
      :payment_status,
      :availability

    def initialize(student)
      @student_name = "#{student[:first_name]} #{student[:last_name]}"
      @student_email = student[:email]
      @student_phone = process_phone(student[:phone])
      @subject, @payment_status, @availability = student[:details].split(':')
    end

    def process_phone(raw_phone)
      s = raw_phone.scan(/\d/)
      "(#{s[0]+s[1]+s[2]}) #{s[3]+s[4]+s[5]}-#{s[6]+s[7]+s[8]+s[9]}"
    end

    def acceptable?
      @payment_status == 'paid' && @availability == 'immediately'
    end
  end
end
