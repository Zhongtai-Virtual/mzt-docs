#import "Typst-checklist-template/template/template.typ": *
#import "@preview/oxifmt:1.0.0": strfmt
#set text(font: "Sarasa Fixed CL")
#show math.equation: set text(font: ("Sarasa Fixed CL", "Fira Math"), weight: "regular")

#let meta = toml("meta.toml")
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
    //stroke: 0.4mm+black,
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
      #align(center+horizon)[*Operational Reference*]
    ],
    [
      #set text(size: 16pt, weight: "bold")
      R1
    ],
    [
      #set text(size: 8pt)
      #revision
    ]
  ),
)

#set text(size: 10pt)
#set par(spacing: 1em, leading: 0.5em, justify: true)
#show link: set text(fill: blue)
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
#show "must": set text(weight: "bold")
#show: columns.with(2)

= General

$ "ISA temperature" = 15 upright(degree C) - 2 upright(degree C) times "(altitude in thousands of feet)" $

= Operations in Icing Conditions
For background, see #link("https://hotstart.net/wiki/CL650/Operations_Reference/Operations_in_Icing_Conditions")[hotstart.net].

Icing conditions exist at a Total Air Temperature (TAT) of $10 degree "C"$ ($50 degree "F"$) or below with visible moisture in any form (such as clouds, rain, snow, sleet, or ice crystals), except when Static Air Temperature (SAT) is $−40 degree "C"$ ($−40 degree "F"$) or below.

$ −40 degree "C" "SAT" <= "ICING RANGE" <= 10 degree upright(C) "TAT" $

== Icing in Flight
- *Whenever in* icing conditions:
  - Cowl Anti-Ice must be selected ON; and
  - Wing Anti-Ice must be selected NORM when
    - below 22,000ft, or
    - "ICE" is shown on the CAS.
- *Regardless of* icing conditions:
  - Wing Anti-Ice must be selected NORM prior to selecting flaps for approach when $"TAT" <= 10 degree upright(C)$. 
    - Provided the aircraft remains clear of icing conditions and no ice is detected by the ice detection system, the Wing Anti-Ice can be selected OFF after the WING L HEAT and WING R HEAT indicators is shown on the anti-ice panel and a green "WING A/ICE ON" message is shown on the CAS.

To ensure correct operation, check for a green "WING A/ICE ON" on the CAS. In some situations this requires a minimum of 78% N2. The N2 gauge will show in amber if 78% is not achieved. Note: ATS may need to be disengaged in order to maintain the 78% N2 minimum.

== Icing on the Ground
*It is absolutely vital to ensure the wing is free from contamination before take-off.*
Contamination by even small amounts of frost, ice, or snow can lead to a significant reduction in lift and a loss of control during take-off.

=== References
- Request de-icing either via the FBO or by calling the de-ice crew on VHF frequency 136.925MHz.
- Anti-icing fluid is only designed to protect the aircraft up to the point of take-off, and take-off must be carried out within the holdover time.
- Holdover time begins at the start of the second treatment, and ends depending on fluid type and precipitation intensity. 

#table(
  columns: (auto, auto, 1fr, 1fr),
  table.header([Fluid Type], [Color], [Ex. Snow], [Ex. Rain on Cold Wing]),
  [I (1)], [Red / Orange], [5 minutes], [2–5 minutes],
  [II (2)], [Straw], [20 minutes], [4–25 minutes],
  [IV (4)], [Green], [35 minutes], [9–75 minutes]
)

=== TL;DR
- Single-engine taxiing in icing conditions is not authorized.
- Any contamination on the aircraft must be removed by de-icing treatment before take-off.
- Cowl Anti-Ice must be selected ON during taxi in any icing conditions.
- When the aircraft has not been treated with anti-ice fluid, the Wing Anti-Ice must be selected NORM during the final stages of taxi when $"OAT" < 5 degree upright(C)$ *regardless* of icing conditions, until a green "WING A/ICE ON" message is shown on the CAS. If not required for take-off it can then be selected OFF.
- Wing Anti-Ice must be selected NORM for take-off when 
  - $"OAT" < 5 degree upright(C)$, and
  - there is:
    - visible moisture in any form is present below 400 ft, or
    - wet/contaminated runway, or
    - any precipitation.
  - If the aircraft has been treated with anti-ice fluid the Wing Anti-Ice system should be selected NORM immediately before setting take-off thrust.
  - If no fluid treatment has occurred the Wing Anti-Ice system should be selected NORM in the final stages of taxi.

= Noise Reduction
== NADP 1/2
Preset TO - 6 as TGT before departure. Activate TGT for thrust reduction.

== Alternative Noise Reduction Techniques
Perform initial climb as normal, then
+ Retract flaps at 800 feet AAE, then reduce thrust to CLB N1 limit; or
+ Retract flaps at 500 feet AAE, then have ATS in SPEED mode with target airspeed set to 170 KIAS or VFTO +5, whichever is greater.

= Landing Performance Assessment Using RWYCC
Use ALD for approach performance calculation and set the factor as follows.
For background, see 
#link("https://hotstart.net/wiki/CL650/Operations_Reference/Landing_Performance_Assessment_Using_RWYCC")[hotstart.net].

#box[
  #show table.cell.where(y: 0): strong
  #show table.cell.where(y: 1): strong
  #for (key, value) in ("TWO THRUST REVERSERS": two_ref, "ONE or ZERO THRUST REVERSERS": one_or_zero) {
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
  }
]

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
