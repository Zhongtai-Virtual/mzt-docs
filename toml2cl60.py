import tomllib
import sys
import xml.etree.cElementTree as ET
import textwrap

metadata=[]
groups=[]
with open("./checklist.toml", "rb") as f:
    data = tomllib.load(f)
    groups.append(data)
with open("./flows.toml", "rb") as f:
    data = tomllib.load(f)
    groups.append(data)
with open("./meta.toml", "rb") as f:
    metadata = tomllib.load(f)

root = ET.Element("checklists")
ET.SubElement(root, "name").text = "Zhongtai Virtual CL650 Procedures"
ET.SubElement(root, "version").text = metadata["metadata"]["date"]

groups_elem = ET.SubElement(root, "groups")
for group in groups:
    group_elem = ET.SubElement(groups_elem, "group", name=group["metadata"]["group"], type=group["metadata"]["type"])
    checklists: list[dict] = group["checklists"]
    for checklist in checklists: 
        cl_elem = ET.SubElement(group_elem, "checklist", name=f"{checklist["name"]} {checklist["type"]}")
        items: list[dict] = checklist["items"]
        counter = 0
        for item in items:
            if "rmk" in item:
                lines: str = item["rmk"]
                # if newline not prescribed
                if '\n' in lines:
                    lines = lines.splitlines()
                else:
                    lines = textwrap.wrap(lines, width=52)
                for line in lines:
                    ET.SubElement(cl_elem, "item", name=line, color="magenta")
            if "left" in item:
                counter += 1
                item_elem = ET.SubElement(cl_elem, "item", name=f"{counter:2}. {item["left"]}", action=item["right"])


tree = ET.ElementTree(root)
tree.write(sys.stdout.fileno(), encoding="UTF-8", xml_declaration=True)
