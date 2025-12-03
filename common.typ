#import "@preview/oxifmt:1.0.0": strfmt

// modified from https://github.com/TomVer99/Typst-checklist-template
#let section(
  title,
  body,
) = table(
  stroke: none,
  table.header(
    box(width: 100%, inset: 0.2em)[
      #set text(size: 12pt)
      #align(center)[#upper(strong(title))]
    ]
  ),
  body
)

// modified from https://github.com/TomVer99/Typst-checklist-template
#let step(a, b, bold: false, capitalize: true) = {
  let ret = if ((a != none and a != "") or (b != none and b != "")) {
    if bold {
      strong(a)
    } else {
      a
    }
    " "
    box(width: 1fr, repeat[.])
    " "
    if bold {
      strong(b)
    } else {
      b
    }
  }

  if (capitalize) {
    upper(ret)
  } else {
    ret
  }
}

#let page-header(title, page) = {
  let meta = toml("meta.toml")
  let mcolor = meta.metadata.color
  let revision = meta.metadata.date

  show grid.cell: it => align(center+horizon, it)

  stack(dir: ttb,
    grid(
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
        #set text(12pt, weight: "bold")
        #title
      ],
      [
        #set text(size: 16pt, weight: "bold")
        #page
      ],
      [
        #set text(size: 8pt)
        #revision
      ]
    ),
  )
}

#let page-header-from-config(config) = page-header(config.metadata.group, config.metadata.page)

#let page-template(content) = {
  let meta = toml("meta.toml")
  let mcolor = meta.metadata.color
  let color = color.rgb(mcolor)
  let revision = meta.metadata.date

  set text(font: "Sarasa Fixed CL")
  show math.equation: set text(font: ("Sarasa Fixed CL", "Fira Math"), weight: "regular")

  set text(size: 10pt)
  set par(spacing: 1em, justify: true)

  set page(
    margin: (top: 0.2in, bottom: 0.2in, left: 0.2in, right: 0.2in),
    paper: "us-letter",
    flipped: true,
    background: rect(width: 100%, height: 100%, outset: -2mm, stroke: color+1mm)
  )

  show link: set text(fill: blue)
  show "_": box(width: 2em, repeat("_", gap: -1mm))
  show ">*<": "►☼◄"
  show "1+2": "①+②"

  content
}

#let render-checklist(config) = for checklist in config.checklists {
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
            linebreak()
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
