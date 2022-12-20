# Table: phasetypes

**Description**: Table of the different phase types defined in the ThermoML schema.

### 'ePhaseName' field in the ThermoML Schema
![ThermoML Schema](../images/thermoml/thermoml_schema_ephasename.jpg)

### Example data of a '?' in the '?' section of a ThermoML file
![ThermoML Example](../images/thermoml/thermoml_example_phase.jpg)

### MySQL 'phasetypes' table structure
![MySQL Structure](../images/mysql/mysql_phasetypes.jpg)

### MySQL Fields
* **id**: phase primary key (auto-generated and unique)
* **name**: name of the phase under study from the ThermoML PhaseID field
* **type**: general phase types (enumerated list)
* **updated**: datetime last updated

### Comments
The phasetypes were abstracted into a separate table to include the general phasetype as well as the specific
one reported in the ThermoML file.