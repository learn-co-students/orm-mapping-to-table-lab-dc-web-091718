class Student
  attr_reader :name, :id
  attr_accessor :grade

  def initialize(name, grade, id=nil)
    @name, @grade, @id = name, grade, id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?,?);
    SQL
    DB[:conn].execute(sql, name, grade)
    new_student
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    Student.create(name: self.name, grade: self.grade)
    id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    @id = id
  end

end
