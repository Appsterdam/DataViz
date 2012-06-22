## Welcome to Open Innovation DB web application

Open Innovation DB web app is being developed in order to host the data that is going to be collected during the lifecycle of the Data Visualization project.

### Usage

To start the application first clone it from `Github` and start it with:

	foreman start

This will start the `Thin` server, the `Resque` QUEUEs and the `Redis` server

### Collections

The idea is that the raw data retrieved from meetup should reside in a seperate collection (playing a proxy role) and they are then cloned to colelctions which are going to be the source for the Data Analysis.
Here is the mapping:

Meetup attribute | Proxy collection | Usable collection
-----------------|------------------|------------------
members|Member|Membersa
groups|Groupraw|Groupsa


### WORKFLOW for Importing Meetup data (Members, Groups) to the InnoViz DB:
 Order | Model invoked | Action
:-------:|:---------------:|:--------:
1|Importer|Retrieve meetup members to Member
2|Membersa|Clone Member to Membersa
3|Groupraw|Retrieve meetups each member belongs to (requires 2) and save to Groupraw. This takes extremelly long time and returns meetup ID and a groups hash
4|Groupsa|Copy groups hash only, to Groupsa (requires 3)
5|| Build member<->group (N-N) ralation:
	5.1|Membersa| Create groups in members (requires 2 and 3)
	5.2|Groupsa| Create members in groups (requires 2 and 3)