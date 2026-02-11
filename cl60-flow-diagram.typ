#import "@preview/cetz:0.4.2"
#import "common.typ": *
#show: page-template
#set page(paper: "us-letter")
#set text(font: "Sarasa Fixed CL")

#let l = 0.6em

#let config = toml("flows.toml")

#let get-pos(checklist) = {
  checklist
    .items
    .filter(it => "rmk" not in it)
    .map(it => if "diag-pos" in it { it.at("diag-pos") } else {()})
    .enumerate(start: 1)
}
#let get-lines(checklist) = {
  checklist
    .filter(it => it.at(1).len() == 2)
    .map(it => it.at(0))
    .windows(2)
}

#show: it => align(center+horizon, it)

#let draw-flow-diag(left-list, right-list) = cetz.canvas(length: l, {
  import cetz.draw: *
  content((50, 40), image("cl60-cockpit.png", width: 100 * l))

  if left-list != none {
    let left-pos = get-pos(left-list)
    for (i, c) in left-pos {
      if c.len() == 2 {
        circle(c, radius: 0.8, ..(fill: white, stroke: 0.8pt + black), name: "left"+str(i))
        content("left"+str(i), text(weight: "bold")[#str(i)])
      }
    }

    for (x, y) in get-lines(left-pos) {
      line("left"+str(x), "left"+str(y), stroke: black + 1pt)
    }
    content(left-list.diag-pos, box(fill: white, stroke: black, render-checklist(left-list), width: 22em))
  }

  if right-list != none {
    let right-pos = get-pos(right-list)
    for (i, c) in right-pos {
      if c.len() == 2 {
        circle(c, radius: 0.8, ..(fill: white, stroke: (dash: "dashed")), name: "right"+str(i))
        content("right"+str(i), text(weight: "bold")[#str(i)])
      }
    }
    for (x, y) in get-lines(right-pos) {
      line("right"+str(x), "right"+str(y), stroke: (dash: "dashed"))
    }
    content(right-list.diag-pos, box(fill: white, stroke: (dash: "dashed"), render-checklist(right-list), width: 22em))
  }

  if sys.inputs.at("RELEASE", default: "0") != "1" {
    for x in range(0, 100, step: 5) {
     for y in range(0, 80, step: 5) {
       content(
         (x + 0.5, y + 0.5), 
         text(size: 3pt, fill: white)[#x,#y]
       )
     }
    }
    grid((0,0), (100,80), step: 1, stroke: gray + 0.2pt)
  }
})

= Cockpit Safety Check Flow
#draw-flow-diag(config.checklists.at(0), none)

= Engine Start Flow
#draw-flow-diag(none, config.checklists.at(3))

= After Start Flow
#draw-flow-diag(config.checklists.at(4), config.checklists.at(5))

= Anti-Ice Test Flow
#draw-flow-diag(none, config.checklists.at(6))

= Taxi Flow
#draw-flow-diag(config.checklists.at(7), none)

= Before Take-Off Flow
#draw-flow-diag(config.checklists.at(8), config.checklists.at(9))
