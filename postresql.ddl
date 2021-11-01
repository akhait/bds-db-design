CREATE TABLE IF NOT EXISTS book (
  id BIGSERIAL NOT NULL,
  title VARCHAR(100) NOT NULL,
  genre VARCHAR(100),
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS author (
  id BIGSERIAL NOT NULL,
  firstname VARCHAR(100) NOT NULL,
  lastname VARCHAR(100),
  nationality VARCHAR(100),
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS book_author (
  id BIGSERIAL NOT NULL,
  book_id BIGSERIAL NOT NULL,
  author_id BIGSERIAL NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_book_id1
    FOREIGN KEY (book_id)
    REFERENCES book (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_author_id1
    FOREIGN KEY (author_id)
    REFERENCES author (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS publisher (
  id BIGSERIAL NOT NULL,
  name VARCHAR(100) NOT NULL,
  state VARCHAR(100),
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS publication (
  id BIGSERIAL NOT NULL,
  book_id BIGSERIAL NOT NULL,
  publisher_id BIGSERIAL NOT NULL,
  ISBN VARCHAR(14) NOT NULL,
  format VARCHAR(20) NOT NULL,
  language VARCHAR(20) NOT NULL,
  price NUMERIC NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_book_id2
    FOREIGN KEY (book_id)
    REFERENCES book (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_publisher_id1
    FOREIGN KEY (publisher_id)
    REFERENCES publisher (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS location (
  id BIGSERIAL NOT NULL,
  state VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  street VARCHAR(100),
  zip VARCHAR(10) NOT NULL,
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS warehouse (
  id BIGSERIAL NOT NULL,
  location_id BIGSERIAL NOT NULL,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_location_id1
    FOREIGN KEY (location_id)
    REFERENCES location (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS warehouse_publication (
  id  BIGSERIAL NOT NULL,
  warehouse_id BIGSERIAL NOT NULL,
  publication_id BIGSERIAL NOT NULL,
  count INTEGER,
  PRIMARY KEY (id),
  CONSTRAINT fk_warehouse_id1
    FOREIGN KEY (warehouse_id)
    REFERENCES warehouse (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_publication_id1
    FOREIGN KEY (publication_id)
    REFERENCES publication (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL NOT NULL,
  location_id BIGSERIAL NOT NULL,
  username VARCHAR(16) UNIQUE NOT NULL,
  firstname VARCHAR(100) NOT NULL,
  lastname VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_location_id2
    FOREIGN KEY (location_id)
    REFERENCES location (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS role (
  id BIGSERIAL NOT NULL,
  name VARCHAR(100) NOT NULL,
PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS users_role (
  id BIGSERIAL NOT NULL,
  users_id BIGSERIAL NOT NULL,
  role_id BIGSERIAL NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_users_id1
    FOREIGN KEY (users_id)
    REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_role_id1
    FOREIGN KEY (role_id)
    REFERENCES role (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS transaction (
  id BIGSERIAL NOT NULL,
  users_id BIGSERIAL NOT NULL,
  price NUMERIC NOT NULL,
  changed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_users_id2
    FOREIGN KEY (users_id)
    REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS transaction_publication (
  id BIGSERIAL NOT NULL,
  transaction_id BIGSERIAL NOT NULL,
  publication_id BIGSERIAL NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_transaction_id1
    FOREIGN KEY (transaction_id)
    REFERENCES transaction (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_publication_id2
    FOREIGN KEY (publication_id)
    REFERENCES publication (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO book (title, genre) VALUES ('Altered Carbon', 'sci-fi');
INSERT INTO book (title, genre) VALUES ('Babel-17', 'sci-fi');
INSERT INTO book (title, genre) VALUES ('The Anubis Gates', 'fantasy');
INSERT INTO book (title, genre) VALUES ('Cats Have No Lord', 'fantasy');
INSERT INTO book (title, genre) VALUES ('The Heaven Tree Trilogy', 'history');
INSERT INTO book (title, genre) VALUES ('The Wishing Game', 'history');

INSERT INTO author (firstname, lastname, nationality) VALUES ('Richard', 'Morgan', 'British');
INSERT INTO author (firstname, lastname, nationality) VALUES ('Samuel', 'Delany', 'American');
INSERT INTO author (firstname, lastname, nationality) VALUES ('Tim', 'Powers', 'American');
INSERT INTO author (firstname, lastname, nationality) VALUES ('Will', 'Shetterly', 'American');
INSERT INTO author (firstname, lastname, nationality) VALUES ('Edith', 'Pargeter', 'English');
INSERT INTO author (firstname, lastname, nationality) VALUES ('Patrick', 'Redmond', 'English');


INSERT INTO book_author (book_id, author_id) VALUES (1, 1);
INSERT INTO book_author (book_id, author_id) VALUES (2, 2);
INSERT INTO book_author (book_id, author_id) VALUES (3, 3);
INSERT INTO book_author (book_id, author_id) VALUES (4, 4);
INSERT INTO book_author (book_id, author_id) VALUES (5, 5);
INSERT INTO book_author (book_id, author_id) VALUES (6, 6);

INSERT INTO publisher (name, state) VALUES ('Alfred A. Knopf', 'USA');
INSERT INTO publisher (name, state) VALUES ('Berkley Books', 'USA');
INSERT INTO publisher (name, state) VALUES ('Cambridge University Press', 'UK');
INSERT INTO publisher (name, state) VALUES ('Dundurn Press', 'Canada');
INSERT INTO publisher (name, state) VALUES ('Express Publishing', 'UK');

INSERT INTO publication (book_id, publisher_id, ISBN, format, language, price) VALUES (1, 1, '9783453318656', 'paperback', 'English', 11.61);
INSERT INTO publication (book_id, publisher_id, ISBN, format, language, price) VALUES (1, 3, '9780345457707', 'ebook', 'English', 10.5);
INSERT INTO publication (book_id, publisher_id, ISBN, format, language, price) VALUES (3, 2, '9780929480107', 'hardcover', 'English', 39.99);
INSERT INTO publication (book_id, publisher_id, ISBN, format, language, price) VALUES (3, 5, '9782820509635', 'ebook', 'English', 13.99);
INSERT INTO publication (book_id, publisher_id, ISBN, format, language, price) VALUES (6, 3, '9780786865529', 'hardcover', 'English', 9.56);

INSERT INTO location (state, zip, city) VALUES ('CA', 'G0J', 'Gaspésie-Ouest (Causapscal)');
INSERT INTO location (state, zip, city) VALUES ('US', '34948', 'Fort Pierce');
INSERT INTO location (state, zip, city) VALUES ('CZ', '341 42', 'Přestanice');
INSERT INTO location (state, zip, city) VALUES ('US', '87199', 'Albuquerque');
INSERT INTO location (state, zip, city) VALUES ('US', '49528', 'Grand Rapids');
INSERT INTO location (state, zip, city) VALUES ('US', '27023', 'Lewisville');
INSERT INTO location (state, zip, city) VALUES ('US', '70054', 'Gretna');
INSERT INTO location (state, zip, city) VALUES ('US', '65556', 'Richland');
INSERT INTO location (state, zip, city) VALUES ('US', '20009', 'Washington');
INSERT INTO location (state, zip, city) VALUES ('US', '38875', 'Trebloc');
INSERT INTO location (state, zip, city) VALUES ('US', '20736', 'Owings');
INSERT INTO location (state, zip, city) VALUES ('CZ', '364 01', 'Český Chloumek');
INSERT INTO location (state, zip, city) VALUES ('US', '96745', 'Kailua Kona');
INSERT INTO location (state, zip, city) VALUES ('US', '70531', 'Egan');
INSERT INTO location (state, zip, city) VALUES ('US', '95759', 'Elk Grove');
INSERT INTO location (state, zip, city) VALUES ('US', '40383', 'Versailles');
INSERT INTO location (state, zip, city) VALUES ('US', '03462', 'Spofford');
INSERT INTO location (state, zip, city) VALUES ('US', '27932', 'Edenton');
INSERT INTO location (state, zip, city) VALUES ('US', '85244', 'Chandler');
INSERT INTO location (state, zip, city) VALUES ('US', '46825', 'Fort Wayne');
INSERT INTO location (state, zip, city) VALUES ('CZ', '788 05', 'Libina');
INSERT INTO location (state, zip, city) VALUES ('CZ', '341 01', 'Nalžovské Hory-Žďár');
INSERT INTO location (state, zip, city) VALUES ('US', '18058', 'Kunkletown');
INSERT INTO location (state, zip, city) VALUES ('US', '53946', 'Markesan');
INSERT INTO location (state, zip, city) VALUES ('US', '51563', 'Persia');
INSERT INTO location (state, zip, city) VALUES ('CA', 'V7M', 'North Vancouver Southwest Central');
INSERT INTO location (state, zip, city) VALUES ('US', '71242', 'Forest');
INSERT INTO location (state, zip, city) VALUES ('US', '38475', 'Olivehill');
INSERT INTO location (state, zip, city) VALUES ('US', '52595', 'University Park');
INSERT INTO location (state, zip, city) VALUES ('US', '44606', 'Apple Creek');
INSERT INTO location (state, zip, city) VALUES ('US', '67235', 'Wichita');
INSERT INTO location (state, zip, city) VALUES ('CZ', '362 33', 'Hroznětín');
INSERT INTO location (state, zip, city) VALUES ('CZ', '273 02', 'Srby');
INSERT INTO location (state, zip, city) VALUES ('US', '30184', 'White');
INSERT INTO location (state, zip, city) VALUES ('CA', 'E6B', 'Stanley');
INSERT INTO location (state, zip, city) VALUES ('US', '84534', 'Montezuma Creek');
INSERT INTO location (state, zip, city) VALUES ('US', '28611', 'Collettsville');
INSERT INTO location (state, zip, city) VALUES ('US', '87831', 'San Acacia');
INSERT INTO location (state, zip, city) VALUES ('US', '96717', 'Hauula');
INSERT INTO location (state, zip, city) VALUES ('CZ', '417 65', 'Křemýž');
INSERT INTO location (state, zip, city) VALUES ('US', '89404', 'Denio');
INSERT INTO location (state, zip, city) VALUES ('CZ', '190 16', 'Praha 9-Koloděje');
INSERT INTO location (state, zip, city) VALUES ('US', '94606', 'Oakland');
INSERT INTO location (state, zip, city) VALUES ('CZ', '345 61', 'Nové Dvory');
INSERT INTO location (state, zip, city) VALUES ('CZ', '789 01', 'Křižanov');
INSERT INTO location (state, zip, city) VALUES ('CZ', '538 43', 'Moravany');
INSERT INTO location (state, zip, city) VALUES ('CZ', '398 43', 'Křenovice');
INSERT INTO location (state, zip, city) VALUES ('US', '46347', 'Kouts');
INSERT INTO location (state, zip, city) VALUES ('US', '83276', 'Soda Springs');
INSERT INTO location (state, zip, city) VALUES ('US', '75707', 'Tyler');
INSERT INTO location (state, zip, city) VALUES ('CZ', '357 09', 'Studenec');
INSERT INTO location (state, zip, city) VALUES ('US', '63867', 'Matthews');
INSERT INTO location (state, zip, city) VALUES ('CZ', '348 01', 'Jemnice');
INSERT INTO location (state, zip, city) VALUES ('CZ', '793 12', 'Horní Životice');
INSERT INTO location (state, zip, city) VALUES ('US', '99555', 'Aleknagik');

INSERT INTO warehouse (location_id, name) VALUES (1, 'Le Warehouse');
INSERT INTO warehouse (location_id, name) VALUES (2, 'Fort Warehouse');
INSERT INTO warehouse (location_id, name) VALUES (3, 'Přestanický sklad');
INSERT INTO warehouse (location_id, name) VALUES (4, 'Albuquerque Warehouse');
INSERT INTO warehouse (location_id, name) VALUES (5, 'Warehouse Number 5');

INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '4', '40');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '2', '31');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '1', '76');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '3', '12');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '2', '93');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '5', '72');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '3', '93');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '1', '90');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '5', '77');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '1', '53');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '2', '62');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '4', '14');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '1', '56');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '3', '62');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '3', '76');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '2', '99');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '5', '6');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '5', '7');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '2', '33');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '1', '4');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '1', '1');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '1', '78');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '3', '55');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '1', '51');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '4', '88');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '5', '85');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '3', '84');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '1', '92');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '3', '14');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '2', '27');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '5', '94');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '2', '73');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '1', '18');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '1', '77');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '2', '85');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '2', '30');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '5', '20');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '2', '18');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '3', '31');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '2', '87');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '4', '61');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '4', '57');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '1', '60');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '3', '81');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '3', '89');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '2', '30');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('5', '5', '81');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('2', '5', '68');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('1', '1', '69');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('3', '2', '2');
INSERT INTO warehouse_publication (warehouse_id, publication_id, count) VALUES ('4', '5', '43');

INSERT INTO users (location_id, username, firstname, lastname) VALUES (1, 'Berty_Dasi_68', 'Berty', 'Dasi');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (2, 'Janna_Bam_67', 'Janna', 'Bam');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (3, 'Leeuwen_Brana_15', 'Leeuwen', 'Brana');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (4, 'Winny_Nertie_19', 'Winny', 'Nertie');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (5, 'Maudie_Evaleen_4', 'Maudie', 'Evaleen');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (6, 'Aristides_Kollen', 'Aristides', 'Kollen');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (7, 'Yousef_Wandis_29', 'Yousef', 'Wandis');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (8, 'Dot_Derin_45', 'Dot', 'Derin');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (9, 'Aybars_Anne-mari', 'Aybars', 'Anne-marie');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (10, 'Ziad_Kippie_98', 'Ziad', 'Kippie');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (11, 'Carran_Christie-', 'Carran', 'Christie-Anne');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (12, 'Kerri_Tatsman_58', 'Kerri', 'Tatsman');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (13, 'Doroteya_Saumitr', 'Doroteya', 'Saumitra');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (14, 'Yosuf_Jonelle_72', 'Yosuf', 'Jonelle');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (15, 'Maighdiln_Xylina', 'Maighdiln', 'Xylina');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (16, 'Antoine_Ammamari', 'Antoine', 'Ammamaria');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (17, 'Berni_Abra_43', 'Berni', 'Abra');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (18, 'Noslab_Carlotta_', 'Noslab', 'Carlotta');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (19, 'Josefa_Ranea_38', 'Josefa', 'Ranea');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (20, 'Cherry_Rochella_', 'Cherry', 'Rochella');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (21, 'Mollee_Arun_88', 'Mollee', 'Arun');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (22, 'Ana_Joaquin_65', 'Ana', 'Joaquin');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (23, 'Kalila_Lorettalo', 'Kalila', 'Lorettalorna');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (24, 'Cosette_Alexine_', 'Cosette', 'Alexine');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (25, 'Kinman_Inderjit_', 'Kinman', 'Inderjit');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (26, 'Torie_Phillie_28', 'Torie', 'Phillie');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (27, 'Sydney_Morgana_7', 'Sydney', 'Morgana');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (28, 'Verena_Terra_61', 'Verena', 'Terra');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (29, 'Bakoury_Melvin_3', 'Bakoury', 'Melvin');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (30, 'Roch_Gordy_65', 'Roch', 'Gordy');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (31, 'Angelica_Emmalyn', 'Angelica', 'Emmalynne');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (32, 'Alejandrina_Sean', 'Alejandrina', 'Seang');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (33, 'Maia_Jane_95', 'Maia', 'Jane');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (34, 'Reeva_Shamim_58', 'Reeva', 'Shamim');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (35, 'Didier_Celestia_', 'Didier', 'Celestia');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (36, 'Noellyn_Muhammad', 'Noellyn', 'Muhammad');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (37, 'Hang-Tong_Susann', 'Hang-Tong', 'Susanne');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (38, 'Fenelia_Carmenci', 'Fenelia', 'Carmencita');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (39, 'Konstanze_Mansuk', 'Konstanze', 'Mansukha');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (40, 'Lalit_Maidlab_70', 'Lalit', 'Maidlab');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (41, 'Val_Jeni_97', 'Val', 'Jeni');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (42, 'Hanja_Larisa_58', 'Hanja', 'Larisa');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (43, 'Sam_Kaushik_83', 'Sam', 'Kaushik');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (44, 'Chi_Lowietje_36', 'Chi', 'Lowietje');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (45, 'Arvind_Pieter_30', 'Arvind', 'Pieter');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (46, 'Fima_Rio_27', 'Fima', 'Rio');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (47, 'Olwen_Cristina_3', 'Olwen', 'Cristina');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (48, 'Utilla_Jerrie_81', 'Utilla', 'Jerrie');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (49, 'Illa_Drieka_39', 'Illa', 'Drieka');
INSERT INTO users (location_id, username, firstname, lastname) VALUES (50, 'Guillemette_Gian', 'Guillemette', 'Giana');

INSERT INTO role (name) VALUES ('admin');
INSERT INTO role (name) VALUES ('staff');
INSERT INTO role (name) VALUES ('vip_user');
INSERT INTO role (name) VALUES ('user');

INSERT INTO users_role (users_id, role_id) VALUES (1, 1);
INSERT INTO users_role (users_id, role_id) VALUES (2, 3);
INSERT INTO users_role (users_id, role_id) VALUES (3, 3);
INSERT INTO users_role (users_id, role_id) VALUES (4, 2);
INSERT INTO users_role (users_id, role_id) VALUES (5, 4);
INSERT INTO users_role (users_id, role_id) VALUES (6, 2);
INSERT INTO users_role (users_id, role_id) VALUES (7, 3);
INSERT INTO users_role (users_id, role_id) VALUES (8, 3);
INSERT INTO users_role (users_id, role_id) VALUES (9, 4);
INSERT INTO users_role (users_id, role_id) VALUES (10, 2);
INSERT INTO users_role (users_id, role_id) VALUES (11, 3);
INSERT INTO users_role (users_id, role_id) VALUES (12, 4);
INSERT INTO users_role (users_id, role_id) VALUES (13, 3);
INSERT INTO users_role (users_id, role_id) VALUES (14, 2);
INSERT INTO users_role (users_id, role_id) VALUES (15, 4);
INSERT INTO users_role (users_id, role_id) VALUES (16, 3);
INSERT INTO users_role (users_id, role_id) VALUES (17, 2);
INSERT INTO users_role (users_id, role_id) VALUES (18, 3);
INSERT INTO users_role (users_id, role_id) VALUES (19, 4);
INSERT INTO users_role (users_id, role_id) VALUES (20, 3);
INSERT INTO users_role (users_id, role_id) VALUES (21, 2);
INSERT INTO users_role (users_id, role_id) VALUES (22, 4);
INSERT INTO users_role (users_id, role_id) VALUES (23, 3);
INSERT INTO users_role (users_id, role_id) VALUES (24, 3);
INSERT INTO users_role (users_id, role_id) VALUES (25, 2);
INSERT INTO users_role (users_id, role_id) VALUES (26, 2);
INSERT INTO users_role (users_id, role_id) VALUES (27, 3);
INSERT INTO users_role (users_id, role_id) VALUES (28, 4);
INSERT INTO users_role (users_id, role_id) VALUES (29, 3);
INSERT INTO users_role (users_id, role_id) VALUES (30, 4);
INSERT INTO users_role (users_id, role_id) VALUES (31, 3);
INSERT INTO users_role (users_id, role_id) VALUES (32, 4);
INSERT INTO users_role (users_id, role_id) VALUES (33, 2);
INSERT INTO users_role (users_id, role_id) VALUES (34, 2);
INSERT INTO users_role (users_id, role_id) VALUES (35, 2);
INSERT INTO users_role (users_id, role_id) VALUES (36, 2);
INSERT INTO users_role (users_id, role_id) VALUES (37, 2);
INSERT INTO users_role (users_id, role_id) VALUES (38, 3);
INSERT INTO users_role (users_id, role_id) VALUES (39, 4);
INSERT INTO users_role (users_id, role_id) VALUES (40, 2);
INSERT INTO users_role (users_id, role_id) VALUES (41, 3);
INSERT INTO users_role (users_id, role_id) VALUES (42, 4);
INSERT INTO users_role (users_id, role_id) VALUES (43, 4);
INSERT INTO users_role (users_id, role_id) VALUES (44, 4);
INSERT INTO users_role (users_id, role_id) VALUES (45, 2);
INSERT INTO users_role (users_id, role_id) VALUES (46, 4);
INSERT INTO users_role (users_id, role_id) VALUES (47, 4);
INSERT INTO users_role (users_id, role_id) VALUES (48, 3);
INSERT INTO users_role (users_id, role_id) VALUES (49, 3);
INSERT INTO users_role (users_id, role_id) VALUES (50, 3);

INSERT INTO transaction (users_id, price) VALUES (2, 19.5);
INSERT INTO transaction (users_id, price) VALUES (3, 9.45);
INSERT INTO transaction (users_id, price) VALUES (11, 36);
INSERT INTO transaction (users_id, price) VALUES (42, 11.61);
INSERT INTO transaction (users_id, price) VALUES (46, 10.5);

INSERT INTO transaction_publication (transaction_id, publication_id) VALUES (1, 1);
INSERT INTO transaction_publication (transaction_id, publication_id) VALUES (1, 2);
INSERT INTO transaction_publication (transaction_id, publication_id) VALUES (2, 2);
INSERT INTO transaction_publication (transaction_id, publication_id) VALUES (3, 3);
INSERT INTO transaction_publication (transaction_id, publication_id) VALUES (4, 1);
INSERT INTO transaction_publication (transaction_id, publication_id) VALUES (4, 2);
