#let goto-routes = state("routes", ())
#let vertical-routes = state("vertical-routes", ())

#let draw-types = (
  "partial-start",
  "through",
  "partial-end",
  "same-page",
)
#let draw-type = draw-types.zip(range(draw-types.len())).to-dict()

#let arrow-directions = (
  "up",
  "down",
)
#let arrow-direction = arrow-directions.zip(range(arrow-directions.len())).to-dict()

#let assign-levels(routes) = {
  if routes.len() == 0 {
    return ()
  }

  let sorted-routes = routes.sorted(key: r => {
    let (source, target) = r
    calc.min(source.page, target.page)
  })

  // arr of (level, occupied-until-page)
  let level-pool = ()
  let result = ()

  for route in sorted-routes {
    let (source, target) = route
    let start-page = calc.min(source.page, target.page)
    let end-page = calc.max(source.page, target.page)

    // find first available level
    let assigned-level = none
    for i in range(level-pool.len()) {
      let (level, occupied-until) = level-pool.at(i)
      if occupied-until < start-page {
        assigned-level = level
        level-pool.at(i) = (level, end-page)
        break
      }
    }

    // create new if not found
    if assigned-level == none {
      assigned-level = level-pool.len()
      level-pool.push((assigned-level, end-page))
    }

    result.push((source, target, assigned-level))
  }

  result
}

#let resolve-draw(routes-leveled) = {
  let pages-dict = (:)

  for route in routes-leveled {
    let (source, target, level) = route
    let source-page = source.page
    let target-page = target.page
    let start-page = calc.min(source-page, target-page)
    let end-page = calc.max(source-page, target-page)

    let direction = if source-page < target-page {
      arrow-direction.down
    } else if source-page > target-page {
      arrow-direction.up
    } else {
      if source.y < target.y {
        arrow-direction.down
      } else {
        arrow-direction.up
      }
    }

    for page in range(start-page, end-page + 1) {
      if str(page) not in pages-dict {
        pages-dict.insert(str(page), ())
      }

      let draw-info = (
        level: level,
        direction: direction,
      )

      if source-page == target-page and page == source-page {
        draw-info.insert("type", draw-type.same-page)
        draw-info.insert("start-x", source.x)
        draw-info.insert("start-y", source.y)
        draw-info.insert("end-x", target.x)
        draw-info.insert("end-y", target.y)
      } else if page == start-page {
        draw-info.insert("type", draw-type.partial-end)
        draw-info.insert("start-x", if source-page == start-page { source.x } else { target.x })
        draw-info.insert("start-y", if source-page == start-page { source.y } else { target.y })
      } else if page == end-page {
        draw-info.insert("type", draw-type.partial-start)
        draw-info.insert("end-x", if target-page == end-page { target.x } else { source.x })
        draw-info.insert("end-y", if target-page == end-page { target.y } else { source.y })
      } else {
        draw-info.insert("type", draw-type.through)
        draw-info.insert("x", source.x)
      }

      pages-dict.at(str(page)).push(draw-info)
    }
  }

  pages-dict
}

#let route-label(label) = [
  #box(metadata("route-label")) #label
]

#let line-to(target) = context {
  let source = here().position()
  let target = query(target).first().location().position()
  vertical-routes.update(x => (
    x
      + (
        (source, target),
      )
  ))
}

#let goto(target) = context {
  let source = here().position()
  source.x = page.width - 5em
  source.y -= 2mm
  let target = query(target).first().location().position()
  target.x = page.width - 5em
  goto-routes.update(x => (
    x
      + (
        (source, target),
      )
  ))
}

#let resolve-gotos = context {
  let routes = goto-routes.get()
  let leveled = assign-levels(routes)
  let pages = resolve-draw(leveled)
  goto-routes.update(pages)
}

#let resolve-verticals = context {
  let routes = vertical-routes.get()
  let leveled = assign-levels(routes)
  let pages = resolve-draw(leveled)
  vertical-routes.update(pages)
}

#let show-routes(x) = {
  import "@preview/tiptoe:0.3.2": *

  set page(background: context {
    let current-page = here().page()
    let pages-draw = goto-routes.final()

    let level-offset(level) = {
      page.width - 10pt * (level + 1)
    }

    let tip-toe = (tip: stealth, toe: stealth.with(rev: true))
    let tip-toe-rev = (tip: stealth.with(rev: true), toe: stealth)


    let h-line(level, x, dy, dir) = place(
      dy: dy,
      dx: x,
      line(
        length: level-offset(level) - x,
        angle: 0deg,
        ..if dir == arrow-direction.up {
          tip-toe-rev
        } else {
          tip-toe
        },
      ),
    )

    if str(current-page) in pages-draw {
      let arrows = pages-draw.at(str(current-page))
      for arrow in arrows {
        if arrow.type == draw-type.same-page {
          let (level, direction, start-x, start-y, end-x, end-y) = arrow
          place(
            dx: level-offset(level),
            dy: calc.min(start-y.pt(), end-y.pt()) * 1pt,
            line(
              angle: 90deg,
              length: calc.abs((start-y - end-y).pt()) * 1pt,
              ..if direction == arrow-direction.up {
                tip-toe-rev
              } else {
                tip-toe
              },
            ),
          )
          h-line(level, start-x, start-y, 1)
          h-line(level, end-x, end-y, 0)
        } else if arrow.type == draw-type.through {
          let (level, direction) = arrow
          place(
            dx: level-offset(level),
            line(angle: 90deg, length: page.height, ..if direction == arrow-direction.up {
              tip-toe-rev
            } else {
              tip-toe
            }),
          )
        } else if arrow.type == draw-type.partial-end {
          let (level, direction, start-x, start-y) = arrow
          place(
            dx: level-offset(level),
            dy: start-y,
            line(angle: 90deg, length: page.height - start-y, ..if direction == arrow-direction.up {
              tip-toe-rev
            } else {
              tip-toe
            }),
          )
          h-line(level, start-x, start-y, direction)
        } else if arrow.type == draw-type.partial-start {
          let (level, direction, end-x, end-y) = arrow
          place(
            dx: level-offset(level),
            line(angle: 90deg, length: end-y, ..if direction == arrow-direction.up {
              tip-toe-rev
            } else {
              tip-toe
            }),
          )
          h-line(level, end-x, end-y, 1 - direction)
        }
      }
    }

    let pages-draw = vertical-routes.final()

    let level-offset(level) = {
      page.width - 10pt * (level + 1)
    }

    if str(current-page) in pages-draw {
      let arrows = pages-draw.at(str(current-page))
      for arrow in arrows {
        if arrow.type == draw-type.same-page {
          let (level, direction, start-x, start-y, end-x, end-y) = arrow
          place(
            dx: start-x - 0.75em,
            dy: calc.min(start-y.pt(), end-y.pt()) * 1pt - 0.5em,
            line(
              angle: 90deg,
              length: calc.abs((start-y - end-y).pt()) * 1pt - 0.75em,
            ),
          )
        } else if arrow.type == draw-type.through {
          let (level, direction, x) = arrow
          place(
            dx: x - 0.75em,
            line(angle: 90deg, length: page.height)
          )
        } else if arrow.type == draw-type.partial-end {
          let (level, direction, start-x, start-y) = arrow
          place(
            dx: start-x - 0.75em,
            // FIX: current workaround: hard code to remove gap
            dy: start-y -2pt,
            line(angle: 90deg, length: page.height),
          )
        } else if arrow.type == draw-type.partial-start {
          let (level, direction, end-x, end-y) = arrow
          place(
            dx: end-x - 1.25em,
            line(angle: 90deg, length: end-y - 1.25em)
          )
        }
      }
    }
  })
  x
}
