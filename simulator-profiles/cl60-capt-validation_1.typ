#import "./common.typ": *
#show: page-template
#set par(leading: 0.5em)
#set page(flipped: false)
#page-header("Captain Maneuver Validation Profile", "T2")

#show "[Sat]": set text(fill: green, weight: "bold")
#show "[Unsat]": set text(fill: red, weight: "bold")
#show "[Incom]": set text(fill: gray, weight: "bold")
#show "+-": sym.plus.minus

#let mv_itm = it => text(fill: blue, it)
#let can_opt = it => text(fill: rgb("bf9000"), it)
#let exam_cmd = it => text(fill: purple, it)
#let key_msg = it => text(fill: red, it)

This Maneuver Validation Profile is designed for the Captain Upgrade and Annual Proficiency check at Zhongtai Virtual. The aim for this assessment is to ensure that our flight crew retained the necessary CRM/TEM skill, stick and rudder skill, basic instrument scanning skills, and basic IFR skills.

= What to Expect
The design of this Validation is _not_ to “weed out” our flight crew. Though some of the maneuver might seems to be challenging, the the purpose of the session is to “_train_ to proficient” 

The final outcome of this evaluation will be determined by the outcomes of each item:
- [Sat]: Satisfactory
  - No more than two items with an initial grade of [Unsat]
- [Unsat]: Unsatisfactory
  - Three or more items with an initial grade of [Unsat]
- [Incom]: Incomplete
  - Any of the items is [Incom]

Repeats:
Repeat attempts are allowed for all non-first-look items, without limit, until the pilot has demonstrated all items to [Sat], or the scheduled time has expired.

One of the following 3 grades will be determined for each maneuver and the entire validation:
- [Sat]: Satisfactory.
  - Individual or crew performance meets expectations and provides sustained safe flight operations.
  - Proficiency in this item meets all evaluation standards.
  - CRM/TEM is clearly effective.
  - Threats are identified and preparations are effective.
  - Errors are identified and repaired so that safety of flight is not diminished.
- [Unsat]: Unsatisfactory.
  - Individual or crew performance does not provide an adequate margin of safety.
  - Proficiency in this item falls below evaluation standards.
  - CRM/TEM is not effective.
  - Threats are not identified and/or preparations are not effective.
  - Errors are not identified and/or repaired.
- [Incom]: Incomplete. The grade only be given if technical difficulties present itself during the assessment. and remaining time is not sufficient for second screening. Candidates who received this grade should schedule with the examiner ASAP for a second screening appointment.

Typical areas of unsatisfactory performance and grounds for an [Unsat] grade include:
- Failure to demonstrate basic CRM/TEM skills resulting loss of situational awareness
- Any action or lack of action by the applicant that requires corrective intervention by the evaluator to maintain safe flight
- Consistently exceeding tolerances stated in the item
- Failure to take prompt corrective action when tolerances are exceeded
- Failure to exercise risk management

Color coding of the script:
- #mv_itm[Blue - Maneuver Item]
- #can_opt[Brown - Candidate Optional Item]
- #exam_cmd[Purple - Examiner Command]
- #key_msg[Red - Key Message]


The following items will be validated:
#context {
  for h in query(heading.where(level: 2)) [
    - #h.body
  ]
}
- Debrief

// - Crosswind takeoff
// - Non-ILS approach RNP-AR with RF leg, Interrupted approach.
// - 2 RNP AR needed to validated. 1 with Holding at IAF, 1 by Radar Vector
// - Go-around
// - Visual approach
// - V1 cut
// - EO Missed Approach
// - EO ILS Approach to land. 
// - Debrief. 
//   - Have the pilot conduct a debriefing. 

= Required Profiles
#show heading.where(level: 2): mv_itm
Callsign: MZT1500

#can_opt[Candidate will choose the seat for the assessment.]

#can_opt[Candidate should use career mode in case of the need to repeat.]

== Hand-Flown Crosswind Take-Off
Candidates will utilize the ATS/HUD/FD system in this maneuver.

Environment setup: VHHH25L, Wind 165 \@20kt, RVR 500ft, QNH 1013, No clouds

Start up on the runway 25L, Load up BEKOL3B RNAV DEP, preselected altitude 5000ft

Clearance for the candidate: #exam_cmd[Cleared for Take-Off Runway 25L, climb via the SID Except maintain 5000.]

Examiner will observe: 
- Aircraft FD setup
- Basic Call-Out
- Runway centerline control
- Initial rotation technique
- Aircraft pitch attitude control
- FD mode management
- Guidance tracking

// #key_msg[Maneuver terminates at HH413]

== RNAV RNP WITH RF Leg, Holding
- Medical emergency, Examiner will instruct 
- #exam_cmd[Zhongtai 1500, proceed direct LUDLA, expect RNP AR Y approach 25L] 
- #exam_cmd[Zhongtai 1500, descend and maintain 4500ft, hold at LUDLA as published, report ready for approach]

Examiner Will observe:
- Direct to fix and building the hold
- Basic Bingo fuel calculation (if needed)
- Report to ATC established on the holding, time
- Brief the approach
- Setting the minimum and Approach speed
- Discussing about the RNP approach setup and method

Examiner will later instruct: #exam_cmd[Zhongtai 1500, cleared for RNP AR Y approach 25L.]

Refresher:
- Beyond the IAF, PF should use 10nm Scale ND and PM should be on the Progress page
- Maximum deviation requirements beyond FDP/VIP
  - Vertical: 50ft callout, 75ft (1 dot) go-around
  - Lateral: 1/2 RNP or 1 dot call-out, 1 RNP or 2 dots go-around
- Set preselected altitude
  - Set TDEZ+100ft when and only when all of the following conditions are met:
    - *Cleared*: Cleared for approach; and
    - *Established*: Established on public portion of the instrument approach procedure; and
      - You are considered to be on public portion of the approach starting from 2 nautical miles within the TO-waypoint in the procedure.
    - *Protected*: Altitudes of all waypoints up to (including) the vertical interception point (VIP) or final approach fix (FAF) are protected.
  - If unable to set TDEZ+100ft, the minimum allowed altitude selection is the altitude at VIP or FAF (whichever is lower) (e.g., when cleared for the approach outside of IAF.) 
  - If radar vectored off the approach procedure when the selected altitude is TDEZ+100ft or VIP/FAF altitude, pilots shall press *ALT* to hold current altitude, and confirm altitude target with ATC immediately. 
- Arm APPR prior to FDP/VIP
- At VGP, preselect missed approach altitude

Examiner will observe:
- Exit holding
- Setting TDZE+100ft (C.E.P)
- Energy management
- Configuration change 
- Crew coordination

Examiner will instruct: #exam_cmd[Zhongtai 1500, go around, follow standard missed approach procedure.]

== Normal Go-Around

Examiner will observe:
- The missed approach maneuver
- Automation management
- Clean up

//#key_msg[Maneuver terminates after approriate checklist(s) are completed.]

== RNAV RNP WITH RF Leg, Radar Vector Interrupt
Examiner will clear the WX to CAVOK, 10 kt of X-wind at landing.

No need to brief this time. 

After setup, Examiner will instruct crew: #exam_cmd[Zhongtai 1500, cleared RNP AR Y approach 25L.]

When the crew preselects VIP or FAF Altitude and past HH865, the examiner will instruct: #exam_cmd[Zhongtai 1500 turn right heading 170. Cancel approach clearance.] This has to happen before the LUDLA intersection.

Examiner will observe the crew:
- Stop descent immediately 
- Crew will maintain current altitude
- Crew will asking ATC to clarify Altitude

If the crew does not clarify the altitude with ATC, Examiner will intervene before 4000ft and the item will be marked as failed.  Debrief will have to be carried-out before the next try. 

// #key_msg[Maneuver terminates after the crew set TDZE+100ft at appropriate time.]

== Visual Approach
Before aircraft crossing HH873, Examiner will instruct crew #exam_cmd[Zhongtai 1500, 25L closed for possible FOD; Sidestep to runway 25C, runway 25C cleared to land.]

Full stop landing.

#key_msg[Maneuver terminates after full stop.]

== V1 Cut
Examiner will reposition aircraft to runway and will inform the crew that the next item will be a single engine maneuver.

Environment setup: VHHH 25L, Calm wind, RVR 75m (set RVR 170ft in simulator)

The examiner will instruct the crew #exam_cmd[Zhongtai 1500 Runway 25L clear for takeoff, maintain runway heading, initial altitude 5000.]

Examiner will observe the crew:
- Perform V1 cut climb out. Maintain runway Heading
- Examiner will observe the crew
- Maintain Runway heading during takeoff roll
- Coordinated rudder and aileron input during rotation
- Proper call out and CRM/TEM usage
- Clean up
- Appropriate level of automation

// #key_msg[Maneuver terminates after approriate checklist(s) are completed.]

== Single Engine Go-Around
Examiner will give a box vector to crew and instruct the crew to setup ILS 25R.

The examiner will act as a helpful crew member, helping the crew member to set up the ILS approach. 

Examiner will observe the crew:
- Brief the approach
- Calculate the performance
- Discuss about the single engine landing procedure
- Go-around consideration

After GS intercept, the crew will disconnect AP and hand-fly the approach to minimum.

At Minimum, the Examiner will command a go-around. #exam_cmd[Zhongtai 1500 go-around.]

Examiner will observe the crew:
- Maintain positive control of the aircraft
- Adjust pitch, and power appropriately
- Clean up the aircraft
- ATC radio call
 
//#key_msg[Maneuver terminates after clean-up and level-off at 3000ft.]

== Single Engine ILS to land

Repeat the last setup for full stop landing. 

Examiner will provide the box vector for ILS into same runway. 

#key_msg[Maneuver terminates.]

= Evaluation Outcome
The examiner will announce the simulator screen result after all maneuvers are completed.
The examiner should collect all the notes and debrief the candidate after the result has been announced. 

#signature-field()
