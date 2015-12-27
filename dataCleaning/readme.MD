---
title: "readme"
author: "Nikodem Lacki"
date: "27 December 2015"
output: html_document
---

The solution contains one srcipt only.
The script downloads the file from the designated location and unzips it into the current folder. Then it changes the working directory and performes all the operations there.
The scripts assumes certain structure of the zip archive:
* it expects to contain a folder called 'UCI HAR Datase'
* it expects in this folder to be two subfolders 'test' and 'train' containing test and training data sets

