#!/usr/bin/env python3

import os
import sys
import shutil
from xml.etree import ElementTree as ET


# targetdir is a CLI argument with the location of the dir to be processed
# get relevant full paths from targetdir and build array with all its files
# build subarrays by file type, count them up and display to user
targetdir = os.path.realpath(sys.argv[1])
targetenv = os.path.dirname(targetdir)
batchid = "migr"
files = os.listdir(targetdir)
if os.path.exists(targetdir + "/.DS_Store"):
  files.remove('.DS_Store')
xmlfiles = []
pdffiles = []
supfiles = []

for i in files:
  if i.endswith('.xml'):
    xmlfiles.append(i)
  elif i.endswith('.pdf'):
    pdffiles.append(i)
  else:
    supfiles.append(i)

print("\nTotal files in {0}:     {1}".format(targetdir, len(files)))
print("Total XML files in {0}: {1}".format(targetdir, len(xmlfiles)))
print("Total PDF files in {0}: {1}".format(targetdir, len(pdffiles)))
print("Total sup files in {0}: {1}".format(targetdir, len(supfiles)))


# Pre-validate targetdir's metadata files (we don't want to copy junk)
print("\nTesting XML files for well formedness")
for x in xmlfiles:
  try:
    ET.parse(targetdir + "/" + x)
  except:
    print("\n{} is not wellformed. Please fix.".format(x))
    sys.exit()
  print(x)
  #print('.',end="",flush=True)

# Make new directory to copy files into before processing (nondestructive!) 
# If new directory already exists, clobber it and tell user
# Make subdirectories by file type and copy over contents of earlier subarrays 
postprocdir = targetdir + "_postproc"
if os.path.exists(postprocdir):
  shutil.rmtree(postprocdir) 
os.mkdir(postprocdir)

print("\n\nCopying XML files from {0} to {1}/xml".format(targetdir, postprocdir))
os.mkdir(postprocdir + "/xml")
for i in xmlfiles:
  print(i)
  #print('.',end="",flush=True)
  shutil.copy(targetdir + "/" + i, postprocdir + "/xml/" + i)

print("\n\nCopying PDF files from {0} to {1}/pdf".format(targetdir, postprocdir))
os.mkdir(postprocdir + "/pdf")
for i in pdffiles:
  print(i)
  #print('.',end="",flush=True)
  shutil.copy(targetdir + "/" + i, postprocdir + "/pdf/" + i)

if len(supfiles) > 0:
  print("\n\nCopying sup files from {0} to {1}/sup".format(targetdir, postprocdir))
  os.mkdir(postprocdir + "/sup")
  for i in supfiles:
    print(i)
    #print('.',end="",flush=True)
    shutil.copy(targetdir + "/" + i, postprocdir + "/sup/" + i)


# Process XML files
xmlpath = postprocdir + "/xml/"

print("\n\nRenaming XML files")
for x in os.listdir(xmlpath):
  print(x)
  #print('.',end="",flush=True)
  x = xmlpath + x
  os.rename(x, x.replace(".metadata_mods", ""))

print("\n\nAdding FLVC specific info")
for x in os.listdir(xmlpath):
  print(x)
  #print('.',end="",flush=True)
  x = xmlpath + x
  os.system('./assets/flvc.sh {0} {1}'.format(x, batchid))

print("\n\nGenerating coverpages")
coverpath = postprocdir + "/covers/"
os.mkdir(coverpath)
for x in os.listdir(xmlpath):
  os.system('./assets/coverpage.sh {0} {1}'.format(xmlpath + x, coverpath))
  print(x)
  #print('.',end="",flush=True)

print("\n\nTesting XML files for well formedness again")
for x in os.listdir(xmlpath):
  try:
    ET.parse(xmlpath + x)
  except:
    print("\n{} is not wellformed. Please fix.".format(x))
    sys.exit()
  print(x)
  #print('.',end="",flush=True)

print("\n\nMerging XML files into final batch")
os.mkdir(postprocdir + "/batch")
for x in os.listdir(xmlpath):
  print(x)
  #print('.',end="",flush=True)
  shutil.copy(xmlpath + x, postprocdir + "/batch/" + x)
shutil.rmtree(xmlpath) 

# Process PDF files
pdfpath = postprocdir + "/pdf/"

print("\n\nRenaming PDF files")
for p in os.listdir(pdfpath):
  print(p)
  #print('.',end="",flush=True)
  p = pdfpath + p
  os.rename(p, p.replace(".fulltext", "")) 

print("\n\nMerging PDFs with coverpages")
for p in os.listdir(pdfpath):
  print(p)
  #print('.',end="",flush=True)
  os.system('./assets/merge.sh {0} {1} {2}'.format(postprocdir + "/covers/coverpage." + p, postprocdir + "/pdf/" + p, postprocdir + "/batch/" + p))
shutil.rmtree(pdfpath) 
shutil.rmtree(coverpath) 


# Process sup files
# Wait until you need to
if os.path.exists(postprocdir + "/sup"):
  print("\n = Processing sup files = \n\n")
  suppath = postprocdir + "/sup/"
  shutil.rmtree(suppath) 

print("\n\nDone!")
