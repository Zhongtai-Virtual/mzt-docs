#import "/common.typ": *
#show: page-template
#set par(leading: 0.5em)
#set page(flipped: false)
#page-header("Screening Profile B", "T1b")

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


== Briefing
=== Adverse Weather
Consider icing. Refer to company and manufacturer documentation on adverse weather operations for:
- Icing Condition
- Aircraft de-ice and anti-ice procedures
=== ATS
For this evaluation, candidate must bind the ATS disconnect button.

For ATS Operation During Landing, consider the following excerpt from FCOM Vol. 2, 04−10−76:

The SPEED message begins to flash while descending through 100 feet radio altitude to indicate that retard mode is set. If the flashing SPEED message is not present, the ATS must be disengaged, and the throttle levers manually controlled.

NOTE: The ATS must be disengaged if flap settings other than 45 degrees
are used for landing. The “retard” function is not active with flap settings other than 45 degrees.

At 50 feet radio altitude the ATS RETARD message replaces the flashing SPEED message and
the ATS retards the throttle levers at a scheduled fixed rate.

At main landing gear weight-on-wheels the ATS will fully retard the throttle levers, then disengage three seconds after touchdown. The green ATS control annunciators extinguish, and the MSD goes blank.

After landing, when the airspeed falls below 40 S KIAS, the ATS may display a flashing amber FAIL message in the MSD. This condition is the result of FMS data no longer being valid, and pressing either ATS DISC switch cancels the FAIL message.

== Hand-Flown Two Engine Take-Off. 

Environment Setup: ZSWX, Rwy 21, RVR 550m, OVC 003, OAT $15 upright(degree C)$, QNH 1009

Aircraft Setup: ZSWX to ZSWX, select any departure and do not load the approach

Clearance for the candidate: Expect runway heading, climb and maintain 1500m on QNH. Candidates will utilize the ATS system in this maneuver.

When the candidate is ready, the examiner will command. #exam_cmd["Zhongtai 1500, cleared for take off runway 21, maintain runway heading."]

Examiner will observe: 
- Aircraft power management
- Runway centerline control
- Profile call-out
- Initial rotation technical
- Aircraft pitch attitude control

When aircraft is in level flight, Examiner will command #exam_cmd["Zhongtai 1500 turn left *heading 270*, maintain 250kt."]

When aircraft were heading 270, Examiner will command #exam_cmd["Autopilot on, I have the aircraft"]

#key_msg[This is a first-look maneuver. Candidates are not allowed to perform any warm-up exercise.]

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

#key_msg[This is a first-look maneuver. Candidates are not allowed to perform any warm-up exercise.]

After the Steep turn, the examiner will instruct the candidate to 
- Descend to 900m; and 
- Return to ZSWX for landing; and
- Load up the FMC for radar vectors (Radar vectors start during downwind when abeam the threshold of landing runway.)

== ILS Instrument Approach

Instructor will then hand over the aircraft to the candidate with command #exam_cmd["You have the aircraft; You have the radios."]

#exam_cmd["Zhongtai 1500, expect vectors to WX205 and then ILS z approach runway 03."]

// TODO: HDG?? do we still do steep turn?
#exam_cmd["Zhongtai 1500, continue heading 030, radar vector to final."]

#exam_cmd["Zhongtai 1500, turn left heading 050, maintain 1500ft until established, cleared for ILS approach runway 03."]

The examiner will vector the candidate to intercept the LOC without crossing WX205. 

Examiner will observe: 
Energy, configuration, flight plan sequencing, and radio management

When glide slope intercept. The examiner will command #exam_cmd["Autopilot off, you are cleared to land Runway 03, full stop on the runway."] 

When aircraft pass 100ft RA, the examiner will announce: #exam_cmd["Zhongtai 1500 go-around, climb and maintain 900m, fly published miss."]

#key_msg[This is a first-look maneuver. Candidates are not allowed to perform any warm-up exercise.]

== Go-Around
- Candidates #key_msg[WILL] manage the Flight Path First (#key_msg[Fly the airplane!]) 
- Candidates #key_msg[SHALL] press the TOGA and ATS disconnect buttons to bring up the proper FD mode
- Candidates #key_msg[SHOULD] make the call-out in timely manner
- Candidates are #key_msg[RECOMMENDED] to use/command the autopilot and/or FD mode at appropriate time
  - Specifically, candidates are expected to use LNAV to fly the published missed approach procedure. For an ILS approach, this almost always requires changing the nav source manually.

Examiner will ensure the safe outcome of this manuever.

// at WX205 direct IF WX204, join left hold inbound 115, not published, 1min leg, rpt established on the hold
At WX205, #exam_cmd["Zhongtai 1500, proceed direct WX204. Hold east of WX204 on 115 degree course, 1 minute leg, expect further clearance zzzz, report established on the hold."]
// During the hold, reset wx, after one holding completed, on outbound leg clear visual approach 03
// dual RA failure trigger at 1000ft (not written on profile)
Instructor resets weather during the hold. After one holding completed, on outbound leg: #exam_cmd["Cleared visual approach 03"]

== Visual Approach

Aircraft setup:
- 03 left downwind 
- 900m on QNH
- IAS 210kts

Examiner will observe: 
Energy, configuration, and flight plan sequencing

#exam_cmd["Zhongtai 1500, runway 03 cleared to land."]

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
Environment Setup: RJTT, IFR Non-Precesion Weather Preset, except 
- airport temperature $0 degree"C"$
- OVC Stratus Cloud Top 10,000ft, Base 6,000ft

// 1,2000 ft, inform wx (icing cond.) w/o emphasizing icing cond. , 
// icing cond. requires wing and cowl a/ice, which requires N2 78 -- observe ATS use and energy management
#exam_cmd["Set weather to IFR Non-Precesion, except with airport temperature zero degrees celcius, OVC Stratus Cloud Top 10,000ft Base 6,000ft.]

Aircraft Setup: 
- On XAC1K to RNP 23 (AR) at RJTT
- 12,000ft
- PACKs Transition complete
- Reversers armed
- NWS armed
- V#sub[APP] selected
- Minima set

The examiner will load up the STAR and RNP-AR Approach for Runway 23, and demonstrate how to set up the RNP-AR approach on CL60.

Specifically, the examiner will emphasize that:
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
  - If unable to set TDEZ+100ft, the minimum allowed altitude selection is the altitude at VIP or FAF (e.g., when cleared for the approach outside of IAF.) 
  - If radar vectored off the approach procedure when the selected altitude is TDEZ+100ft or VIP/FAF altitude, pilots shall press *ALT* to hold current altitude, and confirm altitude target with ATC immediately. 
- Arm APPR prior to FDP/VIP
- At VGP, preselect missed approach altitude

After setup, the examiner will command #exam_cmd["You have the aircraft, Direct to KAIHO, Cleared for RNP AR Rwy 23, Cleared to land. Full stop on the runway."]

The examiner will observe if the candidate demonstrates proper FMA setup and awareness on this maneuver. 

Candidate should perform a full-stop landing and stop on the runway. Evaluation criteria are the same as above.

#key_msg[Maneuver terminated]

= Evaluation Outcome
The examiner will announce the simulator screen result after all maneuvers are completed, or when the examiner determines that an [Sat] outcome is no longer possible for the candidate’s performance.
The examiner should collect all the notes and debrief the candidate after the result has been announced. 

#signature-field()
