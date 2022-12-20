# Table: mixtures

**Description**: A join table between the systems and datasets tables.  This allows the combination
of one or more components to be represented as a (real) instance of an (abstract) system.

### 'Component' section in the ThermoML Schema
![ThermoML Schema](../images/thermoml/thermoml_schema_component.jpg)

### Example data of set a 'Components' in a 'PurOrMixtureData' section of a ThermoML file
![ThermoML Example](../images/thermoml/thermoml_example_components.png)

### MySQL 'mixtures' table structure
![MySQL Structure](../images/mysql/mysql_mixtures.jpg)

### MySQL Fields
* **id**: mixtures primary key (auto-generated and unique)
* **system_id**: foreign key ([systems table](table_systems.md)) of the chemical `system` under study
* **dataset_id**: foreign key ([datasets table](table_datasets.md)) of the dataset `mixture` is part of
* **updated**: datetime last updated