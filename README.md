## Dataset: NIST TRC ThermoML Data in MySQL
This repository provides a MySQL database populated with data from ThermoML (XML) files 
documented at https://trc.nist.gov/ThermoML/ and available at https://doi.org/10.18434/mds2-2422.

As part of an [NSF project](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1835643) the set 
of ThermoML files created by the NIST Thermodynamics Research Center (TRC) in Boulder, CO, USA 
was ingested into a MySQL database as a stepping stone to subsequent conversion of the data 
into JSON-LD files in the [SciData framework](https://stuchalk.github.io/scidata/) format. This 
dataset is made available as an example of translating an XML data model into a relational 
database model, in this case implemented according to the SciData framework model.  It is 
also used to exemplify the following tenets of good data management: data modeling, unique 
identifiers (foreign keys in database tables) and best practices for findable, interoperable, 
accessible, and reusable ([FAIR](https://www.go-fair.org/)) data.

### About ThermoML
ThermoML is an [International Union of Pure and Applied Chemistry (IUPAC) standard](https://iupac.org/what-we-do/digital-standards/thermoml/),
(list of references included) for thermophysical property data.  The schema file for ThermoML 
is available at https://trc.nist.gov/ThermoML.xsd and parts of the schema and how they relate
to the MySQL data model can be seen on the pages for the different database tables [here](mysql%20table%20descriptions).


### Important Features
* The acronym "[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)", standing for
  "don't repeat yourself", is used as a mechanism to create the data model. That is, where 
  data or metadata can be abstracted into definitive, concrete unique entities (e.g., 
  chemical substances) it is done once (in one table), given a unique id, a "primary key", 
  and referenced in other tables by using the primary key in a "foreign key" field.

* [Foreign key constraints](https://dev.mysql.com/doc/refman/5.7/en/create-table-foreign-keys.html) 
  in relational databases are a way to ensure a higher level of integrity in the stored data. 
  As an example, in a table a set of unique entries for chemical `substances` is created.
  In another table, `identifiers` for those substances are captured, and in each record of an 
  identifier a foreign key field points to the substance that identifier represents. Now, if 
  at some point a substance entry is found to be a duplicate of another, it will be deleted 
  from the `substances` table. However, any entries in the `identifiers` table pointing to that
  substance will remain, and point to a substance that no longer exists. This data is now 
  considered to be 'orphaned data', i.e., data that is not part of the data model. Creating a 
  foreign key constraint in the `identifiers` table (see image from phpMyAdmin below)
  by linking the 'substance_id' field in the `identifiers` table to the 'id' field of the 
  `substances` table, means that when we try to delete a row in the `substances` table with at
  least one entry in the `identifiers` table, it will not be permitted.  This ensures there 
  are no 'orphaned' entries in the `identifiers` table.

![foreign_key_example](images/mysql/mysql_fkeys.jpg)

### SciData Data Model
![mysql_schema.jpg](images%2Fmysql%2Fmysql_schema.jpg)
The SciData data model for the TRC data is based off of the ThermoML schema and adds the 
idea that data in each dataset can be general thought of as a (data)series of (data)points.
where each datapoint connects experimental conditions to an experimental datum. In the SciData
framework there is also the concept that a dataset is a set of data about a chemical 
system (a pure substance or mixture of substances, akin to the `PureOrMixtureData` 
element in ThermoML) published in a research paper (`Citation` section in ThermoML). 
Finally, in SciData there is also a section for methodology, how the research was 


### List of Database Tables

- chemicals: 
- chemicals_datasets 
- components 
- conditions 
- data 
- datapoints 
- dataseries 
- datasets 
- files 
- identifiers 
- journals 
- keywords 
- mixtures 
- phases 
- phasetypes 
- purificationsteps 
- quantities 
- quantitykinds 
- references 
- reports 
- sampleprops 
- substances 
- substances_systems 
- systems 
- units

[//]: # (### Discussion of ingestion script)

[//]: # (### Discussion of data validation scripts)

[//]: # (### Augmentation with additional metadata for compounds, systems, etc...)

[//]: # (### Representation of numeric values discussion &#40;from TRC data representation&#41;)

[//]: # (### Disclaimer)

[//]: # (### User Access)

[//]: # (The database contains one user account.  Username: admin, Password: password)
