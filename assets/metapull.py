#!/usr/bin/env python3

import sys
import bs4

xmlfile = sys.argv[1]
soup = bs4.BeautifulSoup(open(xmlfile, 'r'), "html.parser")



# Author string handling
author_name_array = []

for name in soup.find_all('name'):
  if name.find_all('roleterm', string="author"):
    author = {}
    author['first'] = name.select('namepart[type|=given]')
    author['last'] = name.select('namepart[type|=family]')
    author['suffix'] = name.select('namepart[type|=termsOfAddress]')
    if author['suffix']:
      author_name = "{} {} {}".format(author['first'][0].string, author['last'][0].string, author['suffix'][0].string)
    else:
      author_name = "{} {}".format(author['first'][0].string, author['last'][0].string)
    author_name_array.append(author_name)

author_count = len(author_name_array)
author_string = ""

for index, author in enumerate(author_name_array):
  index += 1

  # 1 author
  if author_count == 1:
    author_string += author

  # 2 authors
  elif author_count == 2:
    if index < 2:
      author_string += "{} and ".format(author)
    else:
      author_string += "{}".format(author)

  # 3-10 authors
  elif author_count < 10:
    if index < author_count:
      author_string += "{}, ".format(author)
    else:
      author_string += "and {}".format(author)

  # More than 10 authors
  else:
    if index < 11:
      author_string += "{}, ".format(author)
    else:
      others = author_count - 10
      author_string += "and {} others".format(others)
      break



# Title string handling
title_soup = soup.find('titleinfo')
title = title_soup.find('title')
subtitle = title_soup.find('subtitle')
nonsort = title_soup.find('nonsort')
title_string = ""

if nonsort:
  title_string += "{} {}".format(nonsort.string, title.string)
else:
  title_string += title.string

if subtitle:
  title_string += ": {}".format(subtitle.string)



# Date string handling
date = soup.find('dateissued').string



template = open("assets/template.fo", "r").read()
procfo = template.replace("%TITLE-STRING%", title_string).replace("%AUTHOR-STRING%", author_string).replace("%DATE-STRING%", date)
out = open("{}{}.fo".format(sys.argv[2], sys.argv[3]), 'w')
out.write(procfo)
out.close()

#print(procfo)
#print("save to {}{}".format(sys.argv[2], sys.argv[3]))
