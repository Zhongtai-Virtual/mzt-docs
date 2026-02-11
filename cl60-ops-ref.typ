#import "./common.typ": *
#show: page-template
#set par(leading: 0.5em)
#page-header("Operational Reference", "R1")

#set text(size: 10pt)
#set par(spacing: 1em, leading: 0.5em, justify: true)
#let two_ref = (
  [6], [1.67], [1.88], [1.76], [1.98],
  [5], [2.23], [2.43], [2.41], [2.63],
  [4], [2.29], [2.48], [2.46], [2.67],
  [3], [2.34], [2.53], [2.50], [2.71],
  [2], [2.75], [2.96], [2.99], [3.22],
  [1], [2.95], [3.13], [3.16], [3.38],
)
#let one_or_zero = (
  [6], [1.77], [2.01], [1.87], [2.13],
  [5], [3.08], [3.36], [3.31], [3.61],
  $<= 4$, [-], [-], [-], [-],
)
#set table(align: center+horizon)
//#show table: box
#set table(rows: 2em)
#show: columns.with(2)

= General

$ "ISA temperature" = 15 upright(degree C) - 2 upright(degree C) times "(altitude in thousands of feet)" $

= Take-Off Profile
#[
  #show table.cell.where(x: 0): strong
  #show table.cell.where(y: 0): strong
  #set table(rows: 2.5em)
  #table(
    columns: 3*(1fr,),
    table.header([Condition], [PF], [PM],),
    [Advancing Thrust Levers], ["Check Thrust"], [],
    [At N#sub[1] Target], [], ["Thrust Set"\ (No later than 60KIAS)],
    table.cell(rowspan: 2)[At 80 KIAS], [], [Cross-check,\ then "80 knots"], ["Checked"], [],
    [At V#sub[1]], [], ["V#sub[1]"],
    [At V#sub[r]], [Rotate to achieve\ $"IAS" >= "V"_2 + 10"kt"$], ["Rotate"], 
    table.cell(rowspan: 3)[Positive rate of climb], [], ["Positive Rate"], ["Gear Up"], [], [], ["Gear up"],
    [$"IAS" >= "V"_"FTO" + 5"kts"$], ["Flaps up, after take-off checklist"], 
)]
  //[Before V#sub[1],\ CAPT Decides to Reject], table.cell(colspan: 2)[CAPT: "Stop, I have control"],
//== Noise Reduction
//=== NADP 1/2
//Preset TO - 6 as TGT before departure. Activate TGT for thrust reduction.
//
//=== Alternative Noise Reduction Techniques
//- Retract flaps at 800 feet AAE, then reduce thrust to CLB N1 limit; or
//- Retract flaps at 500 feet AAE, then have ATS in SPEED mode with target airspeed set to 170 KIAS or VFTO +5, whichever is greater.

= Approach Profile
#[
  #show table.cell.where(x: 0): strong
  #show table.cell.where(y: 0): strong
  #set table(rows: 2.5em)
  #table(
    columns: 3*(1fr,),
    table.header([Condition], [PF], [PM],),
    [Radio Alt Alive/2500 ft], ["QNH/Altimeter \_"], ["QNH/Altimeter \_"],
    [Indicator Movement], [], [LOC/Course Alive\ GS/GP Alive #footnote["Course" is for GNSS/VOR Appr, GS and GP can be pronounced as glideslope and glidepath.]],
    [GS/GP Active], ["Set GA Altitude"], [],
    [RA 1,000 ft], ["1000, Configured"], ["Checked"],
    [RA 500 ft], ["500, Stable"], ["Checked"],
    table.cell(rowspan: 2)[Minima + 100 ft], [], ["Approaching minimums"], ["Lights" (if ALS seen)], [],
    [Minima], ["Continue" or\ "Go-around, flaps 20"], [],
    [Touchdown], [], ["No Spoilers" and/or "No Reverse", if needed],
    [Rollout], [], ["60 knots"],
)]

= Performance
== Landing Performance Assessment Using RWYCC
Use ALD for approach performance calculation and set the factor as follows.
#footnote[For background, see 
#link("https://hotstart.net/wiki/CL650/Operations_Reference/Landing_Performance_Assessment_Using_RWYCC")[hotstart.net].]

#for (key, value) in ("TWO THRUST REVERSERS": two_ref, "ONE or ZERO THRUST REVERSERS": one_or_zero) {
  show table.cell.where(x: 0): strong
  show table.cell.where(y: 0): strong
  show table.cell.where(y: 1): strong
    heading(depth: 2, key)
    table(
      columns: (auto, 1fr, 1fr, 1fr, 1fr),
      table.header(
        table.cell(rowspan: 2, [RWYCC]),
        table.cell(colspan: 2, [ISA $+15upright(degree C)$ OR BELOW]),
        table.cell(colspan: 2, [ISA $+15upright(degree C)$ TO $+35upright(degree C)$ ]),
        table.cell[V#sub[ref]+10], table.cell[V#sub[ref]+20],
        table.cell[V#sub[ref]+10], table.cell[V#sub[ref]+20],
      ),
      ..value
    )
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
  [Turbulence Penetration Speed], table.cell(colspan: 2)[Max. 280 KIAS/Mach 0.75 (whichever lower)],
  table.cell(colspan: 3, rowspan: 2, align: center + horizon)[
    #set par(leading: 0em)
    $
    "Mandatory " V_"APP" &= V_"ref"+ Delta V_"APP" "where" 10"KIAS" <= Delta V_"APP" <= 20"KIAS"\
    "Recommended" Delta V_"APP" &= 1/2 "steady-state x-wind component" + "all gust wind"\
    "Ensure " V_"APP" &>= V_"ac" + 10"KIAS" "for go-around performance"
    $
  ],
)

= Approach, Take-off, and Landing Limitations

#table(
  columns: (auto, 1fr, 1fr),
  rows: (2.3em,),
  align: (col, row) => (left, center, center).at(col) + horizon,
  [Max. Demonstrated Crosswind Component], table.cell(colspan: 2, [24 kts]),
  [Max. Tailwind Component], table.cell(colspan: 2, [10 kts]),
  [Max. Tire Speed], table.cell(colspan: 2)[182 kts],
  [Max. Normal Runway Altitude], table.cell(colspan: 2, [10,000 ft press alt]),
  [Max. Reduced Weight Runway Altitude], table.cell(colspan: 2, [14,000 ft press alt]),
  [Min. Autopilot Engage Height], table.cell(colspan: 2)[320 ft],
  [Max. Air Temperature for Take-off and Landing], table.cell(colspan: 2, [ISA $+35 upright(degree C)$]),
  [Min. Air Temperature for Take-off], table.cell(colspan: 2, [$−40 upright(degree C)$ / $−40 upright(degree F)$]),
  [Max. Runway Slope], table.cell(colspan: 2, [2% uphill / 2% downhill]),
  table.cell(rowspan: 2)[Max. APU Operation Altitude], [In-Flight Start ], [ 20,000 ft], [Bleed Air], [15,000 ft],
  [Max. Gear Extended Altitude], table.cell(colspan: 2)[20,000 ft],
  table.cell(rowspan: 2)[Lift/Drag Devices], [Flaps], [Max.\ 15,500 ft], [Spoilers], [Min.\ 300 ft AGL],
  table.cell(rowspan: 3, [Glidepath Angle Limit\ See #link("https://hotstart.net/wiki/CL650/Operations_Reference/Special_Approach")[Special Approach]]),
  [Normal], $[0.0degree, 3.5degree]$,
  [Special], $(3.5degree, 4.5degree]$,
  [Steep], $(4.5degree, 5.5degree]$,
  table.cell(rowspan: 2)[Min. Autopilot Disconnect Height], [ILS/LPV\ AND $<= 3.5 degree$], [80 ft], [Otherwise], [320 ft],
  [Min. Demonstrated GA Alt w/o Touching], table.cell(colspan: 2, [50 feet / 100 feet (EO)]),
  table.cell(colspan: 3, align(center)[VNAV use during missed approach is *not authorized*]),
)

// TODO:
// 1. callout
// 2. stablized approach plan

//#let r(it, content) = table.cell(rowspan: it, content)
//#table(
//r(8)[Takeoff], 
//[Advancing throttles], [PF], ["Set/Check thrust"],
//[Reaching N1 setting], [PM], ["Thrust set"],
//r(2)[At 80 KIAS], [PM], ["80 knots"], [PF], ["Checked"],
//[V#sub[1]], [PM], ["V#sub[1]" (If not called out by automation)],
//[V#sub[r]], [PM], ["Rotate"],
//r(2)[Positive rate of climb], [PM], ["Positive rate"], [PF], ["Gear up"],
//
//
//r(6)[Go-Around], 
//r(2)[Go-Around decision], [PF], ["Go around, flaps 20"#footnote[Either pilot may announce "go-around"]], [PM], ["Thrust set"],
//r(2)[Positive rate of climb], [PM], ["Positive rate"], [PF], ["Gear up"], 
//r(2)[Climb out], [PF], ["Check missed approach altitude"], [PM], ["\_ set"#footnote[PM will verbally announce the specific value in the MCP altitude window (e.g., “5,000 set”) to be sure the correct altitude is set.]]
//)
//
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

