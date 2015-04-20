*Here's a start of a list of requirements that seem necessary to satisfy a FreeMVD (IFC roundtrip) workflow.  Some of these might change based on further testing. Please add/modify as seen fit.*



- Extrusions (SweptSoilds) only
- In the extrusion profiles, don't use 'arcs' and 'circles', i.e. straight lines only.
- Avoid having multiple (more than one) extrusions (IfcExtrudedAreaSolids) inside one IfcShapeRepresentation. *The testing, however, is inconsistent so far.* - Ryan  
	- For Revit, this means avoid having multiple extrusions inside a MIP family.