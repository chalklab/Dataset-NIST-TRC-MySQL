# Table: substances

Description: Table of metadata about the (chemical) substances under study.  This table contains only the
general descriptive metadata about a substance that is found in the `<Compound>` section
of a ThermoML file (see below).  Data about the sample of chemical substance is found in the samples table.

Additionally, chemical identifiers for substances are stored in a separate, identifiers table which is more efficient for
storing data as adding fields for each different descriptor type often leads to a significant overhead of empty fields.

![Compound Section](../images/compound.png)

