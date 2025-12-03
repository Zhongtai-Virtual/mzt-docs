#import "./common.typ": *
#show: page-template
#set par(leading: 0.5em)
#page-header("Operational Reference", "R1")

#set text(size: 10pt)
#set par(spacing: 1em, leading: 0.5em, justify: true)
#let two_ref = (
  [6], [1.48], [1.67], [1.88], [1.56], [1.76], [1.98],
  [5], [2.03], [2.23], [2.43], [2.19], [2.41], [2.63],
  [4], [2.09], [2.29], [2.48], [2.24], [2.46], [2.67],
  [3], [2.15], [2.34], [2.53], [2.29], [2.50], [2.71],
  [2], [2.56], [2.75], [2.96], [2.77], [2.99], [3.22],
  [1], [2.78], [2.95], [3.13], [2.97], [3.16], [3.38],
)
#let one_or_zero = (
  [6], [1.55], [1.77], [2.01], [1.64], [1.87], [2.13],
  [5], [2.79], [3.08], [3.36], [3.00], [3.31], [3.61],
  $<= 4$, [-], [-], [-], [-], [-], [-],
)
#set table(align: center+horizon)
#show table: box
#set table(rows: 2em)
#show: columns.with(2)

= General

$ "ISA temperature" = 15 upright(degree C) - 2 upright(degree C) times "(altitude in thousands of feet)" $

= Landing Performance Assessment Using RWYCC
Use ALD for approach performance calculation and set the factor as follows.
For background, see 
#link("https://hotstart.net/wiki/CL650/Operations_Reference/Landing_Performance_Assessment_Using_RWYCC")[hotstart.net].

#for (key, value) in ("TWO THRUST REVERSERS": two_ref, "ONE or ZERO THRUST REVERSERS": one_or_zero) {
  show table.cell.where(y: 0): strong
  show table.cell.where(y: 1): strong
  box({
    heading(depth: 2, key)
    table(
      columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      table.header(
        table.cell(rowspan: 2, [RWYCC]),
        table.cell(colspan: 3, [ISA +15$upright(degree C)$ OR BELOW]),
        table.cell(colspan: 3, [ISA +15$upright(degree C)$ TO +35$upright(degree C)$ ]),
        table.cell[V#sub[ref]], table.cell[V#sub[ref]+10], table.cell[V#sub[ref]+20],
        table.cell[V#sub[ref]], table.cell[V#sub[ref]+10], table.cell[V#sub[ref]+20],
      ),
      ..value
    )
  })
}

= V-Speeds
#table(
  columns: (auto, 1fr, 1fr),
  table.cell(rowspan: 2, [V#sub[MO]]),
  [< 8,000 ft], [300 KIAS],
  [8,000–22,150 ft], [348 KIAS],
  table.cell(rowspan: 2, [M#sub[MO]]),
  [Non-RVSM],
  [Mach 0.85], 
  [RVSM],
  [Mach 0.83],
  [V#sub[LE] (gear extended)], table.cell(colspan: 2, [250 KIAS]),
  [V#sub[LO] (gear operation)], table.cell(colspan: 2, [197 KIAS]),
  table.cell(rowspan: 3, [V#sub[FE]]),
  [Flaps 20°], [231 KIAS],
  [Flaps 30°], [197 KIAS],
  [Flaps 45°], [189 KIAS],
)

= Approach, Take-off, and Landing

#table(
  columns: (auto, 1fr, 1fr),
  [Max Demonstrated Crosswind Component], table.cell(colspan: 2, [24 kts]),
  [Max Tailwind Component], table.cell(colspan: 2, [10 kts]),
  [Max Normal Runway Altitude], table.cell(colspan: 2, [10,000 ft press alt]),
  [Max Reduced Weight Runway Altitude], table.cell(colspan: 2, [14,000 ft press alt]),
  [Max Air Temperature for Take-off and Landing], table.cell(colspan: 2, [ISA+35 °C]),
  [Min Air Temperature for Take-off], table.cell(colspan: 2, [−40 °C / −40 °F]),
  [Max Runway Slope], table.cell(colspan: 2, [2% uphill / 2% downhill]),
  [Min Autopilot Disconnect Height], table.cell(colspan: 2, [80 ft]),
  [Demonstrated Min GA Alt w/o Touching], table.cell(colspan: 2, [50 feet / 100 feet (EO)]),
  table.cell(colspan: 3, [VNAV use during missed approach is *not authorized*.]),
  table.cell(rowspan: 3, [Glidepath Angle Limit\ See #link("https://hotstart.net/wiki/CL650/Operations_Reference/Special_Approach")[Special Approach]]),
  [Normal], [3.5°],
  [Special], [4.5°],
  [Steep], [5.5°],
  table.cell(colspan: 3, rowspan: 2)[
    $V_"APP" &= V_"ref"+ Delta V_"APP" "where" 5"KIAS" <= Delta V_"APP" <= 20"KIAS"\
    "Recommended" Delta V_"APP" &= 1/2 "steady-state x-wind component" + "all gust wind"$
  ]
)

= Cruise Altitudes

#box({
  set text(size: 9pt)
  show selector.or(..(0,1).map(x => table.cell.where(x: x))): strong
  table(
    columns: 13,
    table.cell(
      colspan: 13,
      [Mach 0.72],
    ),
    table.cell(
      rowspan: 2,
      rotate(-90deg, reflow: true)[ISA],
    ),
    [KG], [12,700], [13,600], [14,500], [15,500], [16,400], [17,300], [18,200], [19,100], [20,000], [20,900], [21,800],
    [FL], 
    table.cell(colspan: 6)[410], [390], table.cell(colspan: 2)[370], table.cell(colspan: 2)[350],
    table.cell(
      rowspan: 2,
      rotate(-90deg, reflow: true)[ISA+10],
    ),
    [KG], [12,700], [13,600], [14,500], [15,500], [16,400], [17,300], [18,200], [19,100], [20,000], [20,900], [21,800],
    [FL],
    table.cell(colspan: 5)[410], table.cell(colspan: 2)[390], table.cell(colspan: 2)[370], table.cell(colspan: 2)[350],
    table.cell(
      colspan: 13,
      [Mach 0.80],
    ),
    table.cell(
      rowspan: 2,
      rotate(-90deg, reflow: true)[ISA],
    ),
    [KG], [12,700], [13,600], [14,500], [15,500], [16,400], [17,300], [18,200], [19,100], [20,000], [20,900], [21,800],
    [FL],
    table.cell(colspan: 5)[410], table.cell(colspan: 2)[390], table.cell(colspan: 2)[370], table.cell(colspan: 2)[350],
    table.cell(
      rowspan: 2,
      rotate(-90deg, reflow: true)[ISA+10],
    ),
    [KG], [12,700], [13,600], [14,500], [15,500], [16,400], [17,300], [18,200], [19,100], [20,000], [20,900], [21,800],
    [FL],
    table.cell(colspan: 3)[410], table.cell(colspan: 2)[390], table.cell(colspan: 3)[370], table.cell(colspan: 2)[350], [330],
  )
})

= Approach Profile
// TODO:
// 1. callout
// 2. stablized approach plan
= Take-off Profile
// TODO: 

= Noise Reduction
== NADP 1/2
Preset TO - 6 as TGT before departure. Activate TGT for thrust reduction.

== Alternative Noise Reduction Techniques
Perform initial climb as normal, then
+ Retract flaps at 800 feet AAE, then reduce thrust to CLB N1 limit; or
+ Retract flaps at 500 feet AAE, then have ATS in SPEED mode with target airspeed set to 170 KIAS or VFTO +5, whichever is greater.

