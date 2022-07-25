# Dataset: NIST TRC ThermoML Data in MySQL
This is a MySQL database populated with data from ThermoML (XML) files available at https://trc.nist.gov/ThermoML/.

As part of an [NSF project](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1835643) the set of ThermoML files created by the NIST Thermodynamics Research Center (TRC)
in Boulder, CO, USA was ingested into a MySQL database as a stepping stone to conversion of the data into
JSON-LD files in the [SciData framework](https://stuchalk.github.io/scidata/) format.  This dataset is made available as a separate citable source
because the data is distributed across different relational tables also in alignment with the SciData framework
model as shown below.  It is also used to exemplify the following tenets of good data management,  
data modeling, and best practices for findable, interoperable, accessible, and reusable ([FAIR](https://www.go-fair.org/)) data.

* The acronym "[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)" standing for "don't repeat yourself" is used as a mechanism to create the data model.
  That is, where data or metadata can be abstracted into definitive, concrete unique entities (e.g. 
  chemical compounds) it is done once (in one table), given a unique id "primary key" and referenced 
  in other tables by using the primary key in a "foreign key field".

* [Foreign key constraints](https://dev.mysql.com/doc/refman/5.7/en/create-table-foreign-keys.html) in databases are a 
  way to ensure a higher level of quality. As an example, in one table a set of unique entries for chemical substances 
  is created.  In another table, identifiers for those substances are captured and in each record of an identifier a 
  foreign key field points to the substance that identifier represents. Now, if at some point a substance entry is found
  to be a duplicate of another, it will be deleted from the table, however any entries in the identifiers table pointing
  to that substance will remain and point to a substance that no longer exists.  Creating a foreign key constraint in
  the identifiers table (see image from phpMyAdmin below), by linking the contents of the 'substance_id' field to the 'id' 
  field of the substances table, means that when we try to delete a substance that has at least one entry in the 
  identifiers table, it will not be allowed.  This ensures there are not 'orphan' entries in the identifiers table.

![eSampleSource Element](images/fkc_idents-%3Esubs.jpg)

[//]: # (### SciData data model diagram)

[//]: # (### Descriptions of fields in the database tables)

[//]: # (### Discussion of foreign key constraints)

[//]: # (### Discussion of ingestion script)

[//]: # (### Discussion of data validation scripts)

[//]: # (### Augmentation with additional metadata for compounds, systems, etc...)

[//]: # (### Representation of numeric values discussion &#40;from TRC data representation&#41;)

[//]: # (### Disclaimer)

[//]: # (### User Access)

[//]: # (The database contains one user account.  Username: admin, Password: password)
