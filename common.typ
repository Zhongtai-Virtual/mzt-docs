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
  show: if capitalize { upper } else { it=>it }
  if ((a != none and a != "") or (b != none and b != "")) {
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
}

#let page-header(title, page, rev: none) = {
  let meta = toml("meta.toml")
  let mcolor = meta.metadata.color
  let revision = if rev == none { meta.metadata.date } else { rev }

  show grid.cell: it => align(center+horizon, it)

  stack(dir: ttb,
    grid(
      columns: (25%, 55%, 20%),
      rows: (6mm, 6mm),
      image("zhongtai-h.png", height: 150%),
      grid.cell(rowspan: 2)[
        #set text(12pt, weight: "bold")
        #title
      ],
      [
        #set text(size: 16pt, weight: "bold")
        #page
      ],
      [
        #set text(size: 8pt, weight: "bold")
        Challenger 650
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
  set par(spacing: 1em)

  set page(
    margin: (top: 0.2in, bottom: 0.2in, left: 0.2in, right: 0.2in),
    paper: "us-letter",
    flipped: true,
    background: [
    #if sys.inputs.at("RELEASE", default: "0") == "1" {
      place(rect(width: 100%, height: 100%, outset: -2mm, stroke: color+1mm))
      context {
        let field-page = locate(<digital-signature-field>).page()
        layout(size => {
          if field-page != here().page() {
            place(dx: size.width - 13em, dy: size.height/2 - 1.2em, bottom)[{{POI/INIT}}]
            place(dx: size.width - 7em, dy: size.height/2 - 1.2em, bottom)[{{APM/INIT}}]
          }
        })
      }
    } else {
      let color = black
      set text(fill: white, weight: "bold")
      place(rect(width: 100%, height: 100%, outset: -2mm, stroke: color+4mm))
      place(top, dx: 0pt, dy: 1mm, repeat(gap: 1em, [WORK IN PROGRESS]))
      place(bottom, dx: 0pt, dy: -1mm, repeat(gap: 1em, [NOT FOR OPERATION]))
      //rotate(30deg,text(36pt, fill: color)[
      //    *WORK IN PROGRESS\ NOT FOR OPERATION*
      //])
    }
  ])

  show link: set text(fill: blue)
  show "_": box(width: 2em, repeat("_", gap: -1mm))
  show ">*<": "►☼◄"
  show "1+2": "①+②"
  show "must": set text(weight: "bold")
  show "regardless": set text(weight: "bold")
  show "whenever": set text(weight: "bold")
  set math.frac(style: "skewed")

  content
}

#let render-checklist(checklist) = section(
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

#let render-checklists(config) = for checklist in config.checklists {
  let wrapper = if checklist.items.len() < 20 {
    box
  } else {
    it => it
  }
  wrapper(
    render-checklist(checklist)
  )
}

#let signature-field() = {
  set text(size: 0.8em)
  show: it => align(center+horizon, it)
  set par(justify: false)
  if sys.inputs.at("RELEASE", default: "0") == "1" [
    #metadata("DIGITAL_SIGNATURE_FIELD") <digital-signature-field>
    #table(
      columns: (0.8fr, 1.5fr, 1.5fr),
      stroke: none,
      table.cell(colspan: 3)[This document has been digitally signed by the following authorized representatives:],
      table.cell(rowspan: 2)[Approved by:], [{{POI/SIGNATURE}}], table.cell(rowspan: 2)[{{POI/DATE-TIME}}], [Principal Operations Inspector],
      table.cell(rowspan: 2)[Reviewed by:], [{{APM/SIGNATURE}}], table.cell(rowspan: 2)[{{APM/DATE-TIME}}], [Aircrew Program Manager CL60],
    )
  ]
  else [#text(size: 2em, fill: red)[*NOT APPROVED FOR OPERATION*]]
}
