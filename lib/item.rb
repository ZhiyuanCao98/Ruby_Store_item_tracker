class Item
  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = path
  end

  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.create_file
    f = File.open(@@filepath, 'w')
    f.write(0)
    f.close
    return file_usable?
  end

  # Count the times you log in the system
  def self.get_acc_count
    lines = File.open(@@filepath).to_a
    count = lines.first.to_i + 1
    File.open(@@filepath, 'w') {|f| f.write(count)}
    return count
  end
end
