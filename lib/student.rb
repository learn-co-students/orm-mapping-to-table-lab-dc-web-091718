class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_accessor :name, :grade

  attr_reader :id

  def initialize(name,grade, id=nil)
  	@name, @grade = name,grade
  	@id = id
  end

  def save

  	Student.create_table
  	DB[:conn].execute("INSERT INTO students(name, grade ) VALUES (?, ?);", name,grade)
  	@id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create_table
  		DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT , grade TEXT);")
  end

  def self.create(name: , grade:)
  	stuud = Student.new(name, grade)
  	stuud.save
  	stuud
  end

  def self.drop_table
  	DB[:conn].execute("DROP TABLE IF EXISTS students")
  end
  
end
