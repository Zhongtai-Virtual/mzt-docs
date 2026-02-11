#import "route.typ": *
#import "common.typ": *
#set text(font: "Sarasa Fixed CL")

#let uuid = state("uuid", 0)

#set heading(numbering: "1.")
#show: show-routes

#let immediate_action(content) = {
  block(stroke: red+0.5mm, inset: 2mm, width: 100%, content)
}

#let condition(content) = [
  #set text(weight: "bold")
  #content
  #linebreak()
]

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

#let branch(cond, if-branch, else-branch, start-label: [], yes-for-both: true) = context[
  #uuid.update(it => it + 1)
  #let if-end = str(uuid.get()) + "_if_end_branch_label"
  #let line-end = str(uuid.get()) + "_line_end_branch_label"
  #condition(cond) #route-label(start-label)
  #sym.suit.diamond.filled #line-to(label(line-end))YES
  #block(
    inset: (left: 2em),
    [
    #if-branch 
    #goto(label(if-end)) 
  ])
  #box(stroke: black+0.2mm, inset: 1mm)[NO]
  #route-label(label(line-end))
  #place(dy: 0.5em, route-label(label(if-end)))
  #else-branch
]


#branch("During take-off after achieving V1:", [
  + #step("Take-off", "Continue")
  + #step("Airplane", "Rotate")
  #condition("When positive rate of climb is achieved:")
  + #step("Landing gear", "Retract")
  + #step("Airspeed", "Maintain")
  NOTE: If engine failure occurs above V#sub[2], maintain airspeed at current value (not more than V#sub[2]+10 KIAS.
], [
  #immediate_action[
    #condition[After take-off and at a safe altitude:]
    #condition[Affected engine:]
    + #step("ATS DISC switch", "Depress")
    + #step("Thrust lever", "Confirm and IDLE")
    + #step("Thrust lever", "Confirm and SHUT OFF")
    + #step("ENG FIRE PUSH switch/light", "Press in")
    + #step("FUEL, L(R) BOOST PUMP switch/light", "Press out")
  ]

  #condition[If warning persists (after 10 sec)]
  + #step("BOTTLE ARMED PUSH TO DISCH switch/light", "Press in")
  #condition[If warning persists (after an additional 30 sec)]
  + #step("Other BOTTLE ARMED PUSH TO DISCH switch/light", "Press in")
  #condition[After take-off (if applicable)]
  #branch("Wing anti-ice system selected on:",[
    + #step("BLEED AIR, 14TH STAGE ISOL switch/light", "Press in")
  ],[
    + #step("THRUST REVERSER, L and R switches", "Select")
  ])
])
#resolve-gotos
#resolve-verticals

