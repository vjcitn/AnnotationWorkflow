
# allt3: R code to create basicGO.sql with tables
# term, term2term, term_definition, term_synonym, graph_path
library(RSQLite)

con = dbConnect(SQLite(), "basicGO.sqlite")

dbExecute(con, "DROP TABLE IF EXISTS term;")
dbExecute(con, "CREATE TABLE term (
  id int(11) NOT NULL,
  name varchar(255) NOT NULL default '',
  term_type varchar(55) NOT NULL default '',
  acc varchar(255) NOT NULL default '',
  is_obsolete int(11) NOT NULL default '0',
  is_root int(11) NOT NULL default '0',
  is_relation int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
) ;")

dbExecute(con, "CREATE INDEX t2 on term(term_type);")

dbExecute(con, "DROP TABLE IF EXISTS term2term;")
dbExecute(con, "CREATE TABLE term2term (
  id int(11) NOT NULL,
  relationship_type_id int(11) NOT NULL default '0',
  term1_id int(11) NOT NULL default '0',
  term2_id int(11) NOT NULL default '0',
  complete int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
); ")
dbExecute(con, "CREATE INDEX tt3 on term2term(term1_id, term2_id);")

dbExecute(con, "DROP TABLE IF EXISTS term_definition;")
dbExecute(con, "CREATE TABLE term_definition (
  term_id int(11) NOT NULL default '0',
  term_definition text NOT NULL,
  dbxref_id int(11) default NULL,
  term_comment mediumtext,
  reference varchar(255) default NULL
) ;")
dbExecute(con, "CREATE INDEX td1 on term_definition(term_id);")

dbExecute(con, "DROP TABLE IF EXISTS term_synonym;")
dbExecute(con, "CREATE TABLE term_synonym (
  term_id int(11) NOT NULL default '0',
  term_synonym varchar(255) default NULL,
  acc_synonym varchar(255) default NULL,
  synonym_type_id int(11) NOT NULL default '0',
  synonym_category_id int(11) default NULL
);")
dbExecute(con, "CREATE INDEX ts1 on term_synonym(term_id);")

dbExecute(con, "DROP TABLE IF EXISTS graph_path;")
dbExecute(con, "CREATE TABLE graph_path (
  id int(11) NOT NULL,
  term1_id int(11) NOT NULL default '0',
  term2_id int(11) NOT NULL default '0',
  relationship_type_id int(11) NOT NULL default '0',
  distance int(11) NOT NULL default '0',
  relation_distance int(11) default NULL,
  PRIMARY KEY  (id)
);")
dbExecute(con, "CREATE INDEX g3 on graph_path(term1_id, term2_id);")
dbDisconnect(con)


