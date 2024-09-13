const List<String> createTables = [
  '''
  CREATE TABLE teacher (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    cpf TEXT NOT NULL
  )
  '''
];

const List<String> insertRecords = [
  '''
  INSERT INTO teacher (id, name, email, cpf) VALUES (1, 'Professor A', 'professorA@example.com', '12345678901')
  ''',
  '''
  INSERT INTO teacher (id, name, email, cpf) VALUES (2, 'Professor B', 'professorB@example.com', '12345678902')
  ''',
  '''
  INSERT INTO teacher (id, name, email, cpf) VALUES (3, 'Professor C', 'professorC@example.com', '12345678903')
  '''
];