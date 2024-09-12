final List<String> createTables = [
  '''
  CREATE TABLE teacher (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    cpf TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    photo TEXT
  )
  ''',
];

final List<String> insertRecords = [
  '''
  INSERT INTO teacher (name, description, cpf, email, phone, photo) VALUES
  ('John Doe', 'Math Teacher', '12345678909', 'john.doe@example.com', '1234567890', 'photo_url')
  ''',
];