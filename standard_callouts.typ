#import "./common.typ": *
#show: page-template
#set par(leading: 0.5em)
#set page(flipped: false)
#page-header("STANDARD CALLOUTS", "R2")
 
Both crewmembers should be continuously aware of current airplane altitude, position, 
energy state, configuration, and maintain situational awareness appropriate for the phase 
of flight. 
 
Both pilots should check the flight instruments and Flight Mode Annunciations (FMAs) 
at regular intervals to verify the selections made are correct for the phase of flight. Both 
pilots should crosscheck their MCP selections with the FMAs to ensure the airplane is 
responding as expected. Unexpected FMAs should be announced, evaluated, and 
addressed appropriately. 
 
The Pilot Monitoring (PM) makes callouts based on instrument indications, 
observations for the appropriate condition. The Pilot Flying (PF) should make all airborne 
FMA callouts, verify the system condition/location from the flight instruments and 
acknowledge. If the PM does not make the callout, the PF should make it. Vise versa.  
 
 
The PM calls out significant deviations from command airspeed or flight path. Either pilot 
should call out any abnormal indications of the flight instruments (flags, loss of deviation 
pointers, etc.). 
 
One of the fundamentals of Crew Resource Management is that each crewmember must 
be able to supplement or act as a back-up for the other crewmember. Proper adherence 
to standard callouts is an essential element of a well-managed flight deck. These callouts 
provide both crewmembers required information about airplane systems and about the 
participation of the other crewmember. The absence of a standard callout at the 
appropriate time may indicate a malfunction of an airplane system or indication, or 
indicate the possibility of incapacitation of the other pilot. 
 
Note: If automatic callouts are not available, the PM may call out radio altitude at 
100 feet, 50 feet and 30 feet (or other values as required) to aid in developing an 
awareness of eye height at touchdown. 
 
Note: If the EGPWS is inoperative, the PM will make the altitude calls. 
 
Note: “Airspeed ±\_” (deviations in excess of 5 knots). 

#show table.cell.where(x: 0): align.with(center+horizon)
#show table.cell.where(x: 0): set text(weight: "bold")
#show table.cell.where(x: 1): align.with(left+horizon)
#show table.cell.where(x: 2): align.with(center+horizon)
#show table.cell.where(x: 2): set text(weight: "bold")
#show table.cell.where(x: 3): align.with(left+horizon)

#let r(it, content) = table.cell(rowspan: it, content)

#table(columns: (1fr,1fr,1fr,2fr), 
  table.header(table.cell(colspan: 2)[Condition], table.cell(colspan: 2)[Callout]),

  r(2)[Transferring Control], r(2)[To assume PF responsibilities], [Request], ["I have control"], [Response], ["You have control"],

  r(3)[MCP (Manual Flight)], 
  [To preselect HDG], [PF], ["Preselect \_" (HDG)],
  [To select HDG/SPD], [PF], ["Select \_" (HDG/SPD)],
  [To set VNAV SPD], [PF], ["Set VNAV speed"],

  [Altitude Warning], [Reaching altitude target], [PM], 
  [1,000 feet/300 meters above/below the assigned altitude, e.g.
  - "Flight level 230 for Flight Level 240"
  - "One four thousand for one three thousand"
  - "One one thousand three hundred meters for one one thousand six hundred meters"
  - "Two thousand seven hundred meters for two thousand four hundred meters"],

  r(8)[Takeoff], 
  [Advancing throttles], [PF], ["Set thrust"],
  [Reaching N1 setting], [PM], ["Thrust set"],
  r(2)[At 80 KIAS], [PM], ["80 knots"], [PF], ["Checked"],
  [V#sub[1]], [PM], ["V#sub[1]" (If not called out by automation)],
  [V#sub[r]], [PM], ["Rotate"],
  r(2)[Positive rate of climb], [PM], ["Positive rate"], [PF], ["Gear up"],


  r(6)[Go-Around], 
  r(2)[Go-Around decision], [PF], ["Go around, flaps 20"#footnote[Either pilot may announce "go-around"]], [PM], ["Thrust set"],
  r(2)[Positive rate of climb], [PM], ["Positive rate"], [PF], ["Gear up"], 
  r(2)[Climb out], [PF], ["Check missed approach altitude"], [PM], ["\_ set"#footnote[PM will verbally announce the specific value in the MCP altitude window (e.g., “5,000 set”) to be sure the correct altitude is set.]]
  
)
