#set text(font: "Sarasa Fixed CL", size: 8pt)
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

#show grid.cell: it => align(center+horizon, it)

#stack(dir: ttb,
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
      #set text(weight: "bold")
      BRIEFING
    ],
    [
      #set text(size: 16pt, weight: "bold")
      N3
    ],
    [
      #set text(size: 8pt)
      #revision
    ]
  ),
)

#show: columns.with(2)
#{  
  set table(align: center+horizon)
  show table: box
  table(
    columns: 3*(1fr,),
    table.cell(colspan: 3)[Discuss *THREATS* First],
    table.cell(colspan: 1)[Personal],
    table.cell(colspan: 1)[Environmental],
    table.cell(colspan: 1)[Technical],
    table.cell(colspan: 1)[Dep CAPT],
    table.cell(colspan: 1)[Dep PF],
    table.cell(colspan: 1)[Arr PF],
    table.cell(colspan: 1)[
      #show: align.with(left+top)
      - Pilot Duties
      - OFP Release
      - Fuel Plan
      - Mx Status
      - NOTAMs/Ops Alerts
      - Taxi Plan/Hot Spots
      - RTO & Evacuation
      - Air Return/TO Alt
    ],
    table.cell(colspan: 1)[
      #show: align.with(left+top)
      - Departure Clearance
      - Wx/Windshear
      - Planned TO Data
      - TO Profile
      - EO Profile
      - Departure Review
      - Terrain/Obstacles
      - Display/Automation
      - Transition Altitude
      - Upset:
        - Push/Roll/Thrust/Stabilize
    ],
    table.cell(colspan: 1)[
      #show: align.with(left+top)
      - ATIS/NOTAM/MEL
      - FMC Programming
      - Arrival Review
      - Transition Level
      - Terrain/Obstacles
      - Approach Briefing
      - Stabilized Appr Plan
      - Windshear/PWS
      - Landing Performance
      - Runway Condition
      - RWY Exit/Taxi Plan/Hot Spots
      - Go-Around Profile
    ],
  )

  table(
    columns: 2*(1fr,),
    table.cell(colspan: 2)[Crew Debrief],
    [What went well?],
    [What could have gone better?],
    [Why?], [Why?],
    table.cell(colspan: 2)[
      *CRM/TEM Skills*\
      #box[
        #show: align.with(left+top)
        - Planning and Decision Making
        - Leadership Effectiveness
        - Situational Awareness
        - Communication
        - Monitor/Cross-Check
        - Workload Management
        - Automation Management
      ]
    ],
    table.cell(colspan: 2)[
      What will we do next time?
    ]
  )
}
