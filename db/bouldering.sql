DROP TABLE climbs;
DROP TABLE climbers;
DROP TABLE routes;

CREATE TABLE climbers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  profile TEXT
);

CREATE TABLE routes(
    id SERIAL4 PRIMARY KEY,
    description VARCHAR(255),
    difficulty INT,
    hint TEXT,
    img_link VARCHAR(255)
);

CREATE TABLE climbs(
  id SERIAL4 PRIMARY KEY,
  route_id INT4 REFERENCES routes(id) ON DELETE CASCADE,
  climber_id INT4 REFERENCES climbers(id) ON DELETE CASCADE,
  attempts_taken INT,
  review TEXT
);
