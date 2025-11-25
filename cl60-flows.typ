#import "Typst-checklist-template/template/template.typ": *
#import "@preview/oxifmt:1.0.0": strfmt
#set text(font: "Sarasa Fixed CL")

#let meta = toml("meta.toml")
#let config = toml("flows.toml")
#let mcolor = meta.metadata.color
#let revision = meta.metadata.date

#set page(
  margin: (top: 0.2in, bottom: 0.2in, left: 0.2in, right: 0.2in),
  paper: "us-letter",
  flipped: true,
  footer: box(width: 1fr, rect(width: 100%, fill: color.rgb(mcolor))),
  header: box(width: 1fr, rect(width: 100%, fill: color.rgb(mcolor)))
)

#show "_": "___"
#style-state.update(1)
#show grid.cell: it => align(center+horizon, it)


#stack(dir: ttb,
  grid(
    //stroke: 0.5mm+blue,
    columns: (25%, 55%, 20%),
    rows: (6mm, 6mm),
    grid.cell(rowspan: 2)[
      #box(inset: 2mm)[
        #set par(leading: 0.5em)
        #set text(size: 10pt, weight: "bold")
        Challenger 650\ 
        #set text(size: 8pt)
        Zhongtai Virtual
      ]
    ],
    grid.cell(rowspan: 2)[
      #align(center+horizon)[*FLOW PATTERN QUICK REFERENCE*]
    ],
    [
      #set text(size: 16pt, weight: "bold")
      #config.metadata.page
    ],
    [
      #set text(size: 8pt)
      #revision
    ]
  ),
)

#show ">*<": "►☼◄"
#show "1+2": "①+②"
#set text(size: 10pt)
#set par(spacing: 1em, leading: 0.5em, justify: true)
#columns(3)[
//  #box(inset: 1em)[
//    Safety is the single objective that cannot be compromised. The best judgment of our pilots is the ultimate tool in ensuring this objective.
//
//    It is a goal of Flight Operations to achieve a precise level of standardization that discourages unsafe practices, carelessness, and the development of individualized procedures, but not so high that operational flexibility, good judgment, and professionalism are discouraged.  
//  ]
  #for checklist in config.checklists {
    let wrapper = if checklist.items.len() < 20 {
      box
    } else {
      it => it
    }
    wrapper(
      section(
        [#checklist.name#sub[#checklist.type]],
        {
          let col = if "columns" in checklist { checklist.columns } else {1}
          show: columns.with(col)
          let cc = counter(checklist.name + checklist.type + "_steps")
          for item in checklist.items {
            if "raw" in item {
              eval(item.raw)
            } else if "rmk" in item {
              align(center)[
                #set text(style: "italic")
                #set par(spacing: 1em, leading: 0.5em, justify: true)
                #item.rmk
              ]
            } else {
              cc.step()
              let capitalize = if "capitalize" in item {
                item.capitalize
              } else {
                true
              }
              context {
                strfmt("{:2}. ", cc.get().at(0)) + step(item.left, item.right, capitalize: capitalize)
              }
            }
            context {
              if cc.get().at(0) == calc.ceil(checklist.items.len() / col) {
                colbreak()
              }
            }
          }
        },
      )
    )
  }

]
