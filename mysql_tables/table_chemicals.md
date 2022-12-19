## Table: chemicals

**Description**: Table of metadata about chemical samples reported in the ThermoML 
file `<Sample>` section (see below). When thinking about chemical samples it is useful 
to regard them as 'instances' of a chemical substance, that is the chemical substance 
is an abstract representation and the chemical instances are what are physically tested/used 
in a laboratory.

### 'Compound' section in the ThermoML Schema

![ThermoML Schema](../images/thermoml/thermoml_schema_compound.jpg)

### Example data of a 'Sample' in the 'Compound' section of a ThermoML file

![ThermoML Example](../images/thermoml/thermoml_example_compound.png)

### MySQL 'compounds' table structure

![MySQL_Structure](../images/mysql/mysql_compounds.jpg)

### MySQL Fields
* **id**: chemicals primary key (auto-generated and unique)
* **file_id**: foreign key ([files table](table_files.md)) of the file this chemical is part of
* **orgnum**: the assigned user organization number, from the original reference
* **substance_id**: foreign key ([substances table](table_substances.md)) of the compound this chemical is a sample of
* **sourcetype**: where the sample came from (see options below in the ThermoML schema)
* **updated**: datetime last updated

### Comments
Purity information for chemical samples is stored in the [`purifcationsteps` table](table_purifcationsteps.md) as the 
purification process can contain 1 to n purification steps.  Each step references an entry in the `chemicals` table.