#import "common.typ": *
#set text(font: "Sarasa Fixed CL", size: 8pt)
#show math.equation: set text(font: ("Sarasa Fixed CL", "Fira Math"), weight: "regular")

#let meta = toml("meta.toml")
#let mcolor = meta.metadata.color
#let revision = meta.metadata.date

#show: page-template
#page-header("BRIEFING", "N3")

#show grid.cell: it => align(center+horizon, it)

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

#signature-field()
