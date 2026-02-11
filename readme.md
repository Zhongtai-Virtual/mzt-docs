# Intro
This repository consists of the (mainly aircraft) documentations of Zhongtai Virtual.

# Build
To export the checklists/flows to HotStart CL650, run
```sh
python toml2cl60.py >/output/path/checklists.xml
```
It is recommended to back up the original `checklists.xml` file.

To render the `.typ` documents to PDF, run the following command. Note that you need to have [Typst](https://typst.app/) installed.
```sh
typst compile --input RELEASE=1 <filename.typ>
```
`--input RELEASE=1` removes the "WORK IN PROGRESS" notes.
