# Table: data

**Description**: Table of numeric values of experimental data reported in the ThermoML files.

### 'PropertyValue' section in the ThermoML Schema
![ThermoML Schema](../images/thermoml/thermoml_schema_numvalues.jpg)

### Example data of a 'PropertyValue' in the 'PureOrMixtureData' section of a ThermoML file
![ThermoML Example](../images/thermoml/thermoml_example_numvalues.jpg)

### MySQL 'data' table structure
![MySQL Structure](../images/mysql/mysql_data.jpg)

### MySQL Fields
* **id**: data primary key (auto-generated and unique)
* **dataset_id**: foreign key ([datasets table](table_datasets.md)) of the dataset the `dataseries` is part of
* **dataseries_id**: foreign key ([dataseries table](table_dataseries.md)) of the `dataseries` the condition belongs to
* **datapoint_id**: foreign key ([datapoints table](table_datapoints.md)) of the `datapoint` the condition belongs to
* **quantity_id**: foreign key ([quantities table](table_quantities.md)) of the `quantity` measured
* **system_id**: foreign key ([systems table](table_systems.md)) of the chemical `system` under study
* **component_id**: foreign key ([components table](table_components.md)) of the `component` in the `mixture` analyzed
* **phase_id**: foreign key ([phases table](table_phases.md)) of the `phase` investigated
* **number**: numeric value in scientific format in the format '<sig>e<exp>' using +/- for the exponent (as text)
* **significand**:  value of the significand of the datum value when converted to scientific notation (as text)
* **exponent**: magnitude of the exponent of the value when converted to scientific notation (as text)
* **error**: the reported uncertainty of the measurement (as text)
* **errortype**: the type of uncertainty reported for the measurement (enum)
* **unit_id**: foreign key ([units table](table_units.md)) of the `unit` of the value
* **accuracy**: the number of significant digits in the value
* **exact**: boolean field that indicates if the datum is an exact value or not
* **text**: the value of the condition in the ThermoML file (as text)
* **issue**: temporary field to record if there is an issue with a datapoint during validation
* **updated**: datetime last updated

### Comments
The dataset_id field was added as a convenience to allow statistics generation. Formally, the link between datasets
and data is:
- `data` are linked to `datapoints` or `dataseries`
- `datapoints` are linked to `dataseries`
- `dataseries` are linked to `datasets`