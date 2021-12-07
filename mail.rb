require 'date'

class Content
  attr_accessor :header, :text

  def initialize(header, text)
    @header = header
    @text = text
  end

  def to_s
    puts "Header:" + header + ".Text:" + text
  end

end

class Mail
  attr_accessor :from, :to, :initial_date, :content

  def initialize(from, to, initial_date, content)
    @from = from
    @to = to
    @initial_date = initial_date
    @content = content
  end

end

class Incoming < Mail
  attr_accessor :is_spam

  def initialize(from, to, initial_date, content, is_spam)
    super(from, to, initial_date, content)
    @is_spam = is_spam
  end
end

class Outgoing < Mail
  def initialize(from, to, initial_date, content)
    super(from, to, initial_date, content)
  end
end


class MailContainer
  attr_accessor :incoming, :outgoing, :spam

  def initialize
    @incoming = Array.new()
    @outgoing = Array.new()
    @spam = Array.new()
  end

  def receive_letter(incoming_letter)
    if incoming_letter.is_spam
      spam.push(incoming_letter)
    else
      incoming.push(incoming_letter)
    end
  end

  def send_letter(to, initial_date, content)
    outgoing.push(Outgoing.new("Yurii Horobets", to, initial_date, content))
  end

  def get_all_mail()
    print("\n----------------------------\n")
    print("Incoming\n", incoming)
    print("\n----------------------------\n")
    print("Outgoing\n", outgoing)
    print("\n----------------------------\n")
  end

  def get_spam
    print("\n----------------------------\n")
    print("Spam\n", spam)
    print("\n----------------------------\n")
  end

  def sort_by_sender
    incoming.sort_by(&:from)
    outgoing.sort_by(&:from)
  end

  def sort_by_date
    incoming.sort_by(&:initial_date)
    outgoing.sort_by(&:initial_date)
  end

  def find_by_title(query)
    print("Found:\n", incoming.select { |a| a.content.header.match("/^"+query+"/") })
  end

end

mail = MailContainer.new

mail.receive_letter(Incoming.new("Enzo Alvarez", "Me", Date.new(2020, 3, 12), Content.new("Header", "Text"), false))
mail.receive_letter(Incoming.new("Thomas Johns", "Me", Date.new(2020, 5, 12), Content.new("Header2", "Text2"), false))
mail.receive_letter(Incoming.new("Spammer Spam", "Me", Date.new(2020, 5, 12), Content.new("Header2", "Text2"), true))
mail.send_letter("Nelson Anderson", Date.new(2020, 5, 16), Content.new("Header3", "Text3"))

mail.get_all_mail
mail.get_spam
mail.sort_by_sender
mail.get_all_mail
mail.sort_by_date
mail.get_all_mail
mail.find_by_title("Header3")

