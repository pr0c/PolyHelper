class User
  attr_accessor :subs

  def initialize(fname, lname)
    @@fname = fname
    @@lname = lname
  end

  def create()
    $db.insert("users", {"fname" => @@fname, "lname" => @@lname})
  end

  def setSubsCount()

  end

  def thisExists?()
    return $db.getCount("users", {"fname" => @@fname, "lname" => @@lname})
  end

  def self.exists?(values)
    return $db.getCount("users", values)
  end
end
