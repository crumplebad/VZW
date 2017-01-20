# VZW
Architecture of this app borrows from MV-VM and VIPER. Based on the Single Responsibilty and abstraction, DataManager, DatModel, DataStore and ImageDownloader play the following roles.

* DataManager - Does not store data but abstracts the various data sources from the view controllers.
* DatModel - Stores data in the memory.
* DataStore - Manages data from persistence storage.
* ImageDownloader -  Downloads images from network.
