class DBUtils
  @@db_name = 'polyhelper.db'

  def initialize()
    createDB()
  end

  def createDB()
    if existsDB?()
      return false
    end
    puts "INSTALLING".green
    db = SQLite3::Database.new(@@db_name)
    puts "[INSTALLING]".green + "database was created ("+@@db_name+")"
    shemas = Dir.entries("schemas")
    shemas.each do |scheme|
      if scheme.split(".")[1] == "schm"
        sqlquery = File.open("schemas/"+scheme) { |file| file.read }
        rows = db.execute(sqlquery)
        puts "[SCHEME loaded]".yellow + " " + scheme
        puts rows
        puts rows.inspect
      else
        puts "Illegal file in schemas directory:".red + " " + scheme
      end
    end
  end

  def existsDB?()
    puts "[INSTALLING]".green + " database already exists ("+@@db_name+")"
    return File.exists?(@@db_name)
  end

  def insert(table, row)
    db = SQLite3::Database.open(@@db_name)
    db.execute("INSERT INTO #{table}(#{row.keys.join(',')}) VALUES('#{row.values.join("','")}')")
    puts "[QUERY]".color(:green) + " INSERT INTO #{table}(#{row.keys.join(',')}) VALUES('#{row.values.join("','")}')"
  end

  def self.update(table, set, where)
    set_statement = ""
    where_statement = ""
    set.each_pair { |key, value| set_statement = set_statement + key + "='" + value.to_s + "',"}
    where.each_pair { |key, value| where_statement = where_statement + key + "='" + value.to_s + "' and "}
    db = SQLite3::Database.open(@@db_name)
    db.execute("UPDATE #{table} SET #{set_statement[0...-1]} WHERE #{where_statement[0...-5]}")
    puts "[QUERY]".green + " UPDATE #{table} SET #{set_statement[0...-1]} WHERE #{where_statement[0...-5]}"
  end

  def getCount(table, values)
    db = SQLite3::Database.open(@@db_name)
    where_statement = ""
    values.each_pair { |key, value|  where_statement = where_statement + key + "='" + value.to_s + "' and "}

    result = db.execute("SELECT COUNT(*) FROM #{table} WHERE #{where_statement[0...-5]}")
    puts "[QUERY]".green + " SELECT COUNT(*) FROM #{table} WHERE #{where_statement[0...-5]}"
    return result[0][0]
  end
end
