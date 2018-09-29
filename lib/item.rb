class Item
  @@filepath = nil
  @@countpath = 'count.txt'

  attr_accessor :name, :category, :price

  def initialize(args = {})
    @name = args[:name] || ""
    @category = args[:category] || ""
    @price = args[:price] || ""
  end

  def self.filepath=(path=nil)
    @@filepath = path
  end

  def self.file_usable?
    return false unless @@filepath && @@countpath
    return false unless File.exists?(@@filepath) && File.exists?(@@countpath)
    return false unless File.readable?(@@filepath) && File.readable?(@@countpath)
    return false unless File.writable?(@@filepath) && File.writable?(@@countpath)
    return true
  end

# Initial count time as 0
  def self.create_file
    File.open(@@filepath, 'w')
    File.open(@@countpath, 'w') {|f| f.write(0)}
    return file_usable?
  end

  # Count the times you log in the system
  def self.get_acc_count
    puts @@countpath
    lines = File.open(@@countpath).to_a
    count = lines.first.to_i + 1
    File.open(@@countpath, 'w') {|f| f.write(count)}
    return count
  end

  def self.add_new_item
    args = {}
    print "\nItem name >>>"
    args[:name] = gets.chomp.strip
    print "Item category >>>"
    args[:category] = gets.chomp.strip
    print "Item price >>>"
    args[:price] = gets.chomp.strip

    return Item.new(args)
  end

  def save_item
    return false unless Item.file_usable?
    File.open(@@filepath, 'a') {
      |f| f.puts  "#{[@name, @category, @price].join("\t")}\n"}
    puts "The name: #{@name}, category: #{@category}, price: #{@price} Add Succesful!\n"
  end

  def self.list
    File.foreach(@@filepath) {|line| puts line}
  end

  def import_line(line)
    line_array = line.split("\t")
    @name, @category, @price = line_array
    return self
  end

  def self.item_array
    arr = []
    File.foreach(@@filepath) {|line| arr << Item.new.import_line(line.chomp)}
    return arr
  end

  def self.find(keyword = "")
#     if keyword
#       items = item_array
#       found = items.select do |i|
#         i.name.downcase.include?(keyword.downcase) ||
#         i.category.downcase.include?(keyword.downcase) ||
#         i.price.to_i <= keyword.to_i
#       end
#       print found.each do |item|
#         line = item.name + "\t" + item.categoty + "\t" + item.price + "\n"
#         print line
#     else
#       puts "Can not find it."
#     end
#   end
# end
  File.foreach(@@filepath) {|line| lineString = line.to_s
         if lineString.include? keyword
            puts lineString
          end
        }
  end
end
