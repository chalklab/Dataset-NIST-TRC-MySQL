# Dataset NIST TRC MySQL
This is a MySQL database populated with data from ThermoML (XML) files available at https://trc.nist.gov/ThermoML/.

As part of an NSF project (ref) the set of ThermoML files created by the NIST Thermodynamics Research Center (TRC)
in Boulder, CO, USA was ingested into a MySQL database as a stepping stone to conversion of the data into
JSON-LD files in the SciData framework format (ref).  This dataset is made available as a separate citable source
because the data is distributed across different relational tables also in alignment with the SciData framework
model as shown below.  It is also used to exemplify the following tenets of good data management,  
data modeling, and best practices for findable, interoperable, accessible, and reusable (FAIR) data (ref)

* The acronym "DRY" standing for "don't repeat yourself" is used as a mechanism to create the data model.
  That is, where data or metadata can be abstracted into definitive, concrete unique entities (e.g. 
  chemical compounds) it is done once (in one table), given a unique id "primary key" and referenced 
  in other tables by using the primary key in a "foreign key field".  See also "foreign key constraints" below.


SciData data model diagram
Descriptions of fields in the database tables
Discussion of foreign key constraints
Discussion of ingestion script
Discussion of data validation scripts
Augmentation with additional metadata for compounds, systems, etc...
Representation of numeric values discussion (from TRC data representation)
Disclaimer
