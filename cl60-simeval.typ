#import "./common.typ": *
#show: page-template
#set par(leading: 0.5em)
#set page(flipped: false)
#page-header("Screening Profile", "T1", rev: "Jan 26 2026")

#show "[Sat]": set text(fill: green, weight: "bold")
#show "[Unsat]": set text(fill: red, weight: "bold")
#show "[Incom]": set text(fill: gray, weight: "bold")
#show "+-": sym.plus.minus

#let mv_itm = it => text(fill: blue, it)
#let can_opt = it => text(fill: rgb("bf9000"), it)
#let exam_cmd = it => text(fill: purple, it)
#let key_msg = it => text(fill: red, it)

This screening profile is designed for the initial simulator evaluations at Zhongtai Virtual. The aim for this assessment is to ensure that our candidate possesses the necessary stick and rudder skill, basic instrument scanning skills and basic IFR skills to proceed to the next crew-oriented training curriculum.

= What to Expect

The final outcome of this evaluation will be determined by the outcomes of each item:
- [Sat]: Satisfactory. 
  - No more than two items with an initial grade of [Unsat]; AND
  - No first-look item with grade [Unsat].
- [Unsat]: Unsatisfactory. 
  - Three or more items with an initial grade of [Unsat]; OR 
  - Any first-look item with grade [Unsat].
- [Incom]: Incomplete. 
  - Any of the items is [Incom].

Repeats:
Repeat attempts are allowed for all non-first-look items, without limit, until the pilot has demonstrated all items to [Sat], or the scheduled time has expired.


One of the following 3 grades will be determined for each maneuver:
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
- Any action or lack of action by the applicant that requires corrective intervention by the evaluator to maintain safe flight.
- Consistently exceeding tolerances stated in the item.
- Failure to take prompt corrective action when tolerances are exceeded.
- Failure to exercise risk management.

Color coding of the script:
- #mv_itm[Blue - Maneuver Item]
- #can_opt[Brown - Candidate Optional Item]
- #exam_cmd[Purple - Examiner Command]
- #key_msg[Red - Key Message]

= Required Profiles
#show heading.where(level: 2): mv_itm

Callsign: MZT1500

#can_opt[Candidate will choose the seat for the assessment.]

#can_opt[Candidate should use career mode in case of the need to repeat.]

== Hand-Flown Two Engine Take-Off. 

Environment Setup: ZSPD, Rwy 16R, RVR 550m, OVC 003, OAT $15 upright(degree C)$, QNH 1009

Aircraft Setup: ZSPD to ZSPD, select any departure and do not load the approach

Clearance for the candidate: Expect runway heading, climb and maintain 1500m on QNH. Candidates will utilize the ATS system in this maneuver.

When the candidate is ready, the examiner will command. #exam_cmd["Zhongtai 1500, cleared for take off runway 16R, maintain runway heading."]

Examiner will observe: 
- Aircraft power management
- Runway centerline control
- Profile call-out
- Initial rotation technical
- Aircraft pitch attitude control

When aircraft are in level flight, Examiner will command #exam_cmd["Zhongtai 1500 turn left *heading 360*, maintain 250kt."]

When aircraft were heading 090, Examiner will command #exam_cmd["Autopilot on, I have the aircraft"]

The examiner will continue climbing to 3000m

#key_msg[This is a first-look maneuver. Candidates are not allowed to perform this in the warm-up exercise.]

== Hand-Flown Steep Turn

Setup:
- 10,000ft
- 250KIAS
- Cardinal heading (360, 090, 180, 270) 
- AP, FD on with HDG, ALTS
- ATS on with SPEED

The examiner hands over the aircraft to the candidate and then commands #exam_cmd["When you are ready. FD off, ATS off, AP off. Steep turn 180 degrees, then reverse the turn back to the current heading."]

The candidate should perform the steep turn. 

#box[
  Examiner will observe: 
  - ALT +-100ft
  - IAS +-10kt
  - Rollout heading +-10#sym.degree
  - Bank angle 45-55#sym.degree during the turn, bank angle alerts are expected
]

When aircrafts roll out back on the initial heading, the examiner will command #exam_cmd["Autopilot on, I have the aircraft."]

#key_msg[This is a first-look maneuver. Candidates are not allowed to perform the warm-up exercise.]

After the Steep turn, the examiner will instruct the candidate to 
- Descend to 900m; and 
- Return to ZSPD for landing; and
- Load up the FMC for radar vectors (Radar vectors start during downwind when abeam the threshold of landing runway.)

== ILS Instrument Approach

Aircraft setup:
- Setup for ILS approach. The examiner should verify the ILS frequency.
- V#sub[APP]
- Minima properly set up

Instructor will then hand over the aircraft to the candidate with command #exam_cmd["You have the aircraft; You have the radios."]
The examiner will vector the candidate to intercept the LOC outside of PD033. 

Examiner will observe: 
Energy, configuration, flight plan sequencing, and radio management

When glide slope intercept. The examiner will command #exam_cmd["Autopilot off, you are cleared to land Runway 16, full stop on the runway."] When aircraft pass 100ft RA, the examiner will announce: #exam_cmd["Zhongtai 1500 go-around, climb and maintain 600m, fly published miss."]

#key_msg[This is a first-look maneuver. Candidates are not allowed to perform this in the warm-up exercise.]

== Go-Around
- Candidates #key_msg[WILL] manage the Flight Path First (#key_msg[Fly the airplane!]) 
- Candidates #key_msg[SHALL] press the TOGA and ATS disconnect buttons to bring up the proper FD mode
- Candidates #key_msg[SHOULD] make the call-out in timely manner
- Candidates are #key_msg[RECOMMENDED] to use/command the autopilot and/or FD mode at appropriate time

Examiner will ensure the safe outcome of this manuever.

When aircraft level off at 600m. The examiner will command #exam_cmd["I have the aircraft."]

== Visual Approach

Aircraft setup:
- 16L left downwind 
- 600m on QNH
- IAS 210kts

Examiner will observe: 
Energy, configuration, and flight plan sequencing

Candidate should refer to the VATPRC visual approach #link("https://community.vatprc.net/t/topic/10728")[NOTAM and chart (login required for access)].

#exam_cmd["Zhongtai 1500, cleared visual approach 16L."]
#exam_cmd["Zhongtai 1500, runway 16L cleared to land."]

== Landing

The examiner will observe candidates: Energy and configuration management. FMA Awareness, Aircraft attitude. Flare high awareness. Touchdown Zone control. 
Centerline awareness. Directional control. 

Examiner will observe: 
- Aircraft touchdown within the first 3000ft of the runway or touchdown zone
- Airspeed +-5 kt after landing configuration selected
- Touchdown G less than 1.6
- Touchdown vertical speed less than 300fpm
- Candidate demonstrated positive aircraft control at all times after AP disconnect

When aircraft stop on the runway, the examiner will announced #exam_cmd["I have the aircraft"]

#key_msg[Maneuver terminated]

== RNP-AR Approach 
Environment Setup: ZYTL, CAVOK, wind calm, QNH 1009

Aircraft Setup: 
- North of TL106
- PACKs Transition complete
- Reversers armed
- NWS armed
- V#sub[APP] selected
- Minima set

The examiner will load up the RNP-AR Zulu Approach for Runway 10, and demonstrate how to set up the RNP-AR approach on CL60.
Specifically, the examiner will emphasize that:
- Beyond the IAF, PF should use 10nm Scale ND and PM should be on the Progress page
- Maximum deviation requirements beyond FDP/VIP
  - Vertical: 50ft callout, 75ft (1 dot) go-around
  - Lateral: 1/2 RNP or 1 dot call-out, 1 RNP or 2 dots go-around
- Altitude window to TDEZ+100ft
- Arm APPR prior to FDP/VIP
- At VGP, preselect missed approach altitude

After setup, the examiner will command #exam_cmd["You have the aircraft, Direct to TL106, Cleared for RNP Zulu Rwy 10, Cleared to land. Full stop on the runway."]

The examiner will observe if the candidate demonstrates proper FMA setup and awareness on this maneuver. 

Candidate should perform a full-stop landing and stop on the runway. Evaluation criteria are the same as above.

#key_msg[Maneuver terminated]

= Evaluation Outcome
The examiner will announce the simulator screen result after all maneuvers are completed.
The examiner should collect all the notes and debrief the candidate after the result has been announced. 

#signature-field()
