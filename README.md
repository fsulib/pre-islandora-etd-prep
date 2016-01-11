#islandora processor
*scripts for preparing ETDs for ingest into Islandora*

##Usage
Clone the scripts onto your desktop and create a folder full of prepared documents
inside of this directory. "Prepared documents" are pairs of MODS records and PDFs
with corresponding names, such as "proquest-etd01.metadata_mods.xml" and "proquest-etd01.fulltext.pdf".
The filenames are vestiges of the Bepress migration process, feel free to dig into
the code and change what it expects if you like. Also note that if the XML and PDF
filenames don't match up (start with the same string like "proquest-etd-01.*") then
this script won't associate them together properly. Also, if some of the files have
alternative names like "proquest-etd01.metadata_mods_utf8.xml", the script will
get mad and not process it.

Once you have a directory full of prepared documents, run `./islandora-processor.py preppeddocs/`
where "preppeddocs/" is the directory full of prepared documents. This will start the processing,
and it is very verbose to let you know if there are errors. Pay attention to the file last printed
before an error happens, and make sure that file came out alright after the processing is over.

Once processing is done, a new directory will be created with the output of processing called
"whateveryouroriginaldirectorywasnamed_postproc". Inside you will find all of the PDFs and MODS
records living together in harmony and ready to be zipped up and fed to Islandora.

## Special Warnings
Get familiar with the coverpage template at /assets/template.fo. You will find
a few lines with strings on them that may need to change depending on where the processed
documents should go. By default it says "Electronic Theses and Dissertations" and
"The Graduate School", but you may want to change this to "Faculty Publications" and
"The Math Department" if thats who owns the content you are processing.

Also be warned that sometimes the batches of prepared documents that come from tech 
services are missing the required namespaces in <mods:mods> of the MODS record, but
sometimes they have them. Theres a section of code inside islandora-processor.py that
adds namespaces to all the records with the /assets/namespaces.sh script, and this section
can either be active to add namespaces or commented out if they already exist. If you
see a lot of XML errors when processing, it means that your prepared documents have
the opposite of whatever the script is set to do and you need to fix it.
