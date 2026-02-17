#import "./common.typ": *
#show: page-template
#set par(leading: 0.5em)
#page-header("Adverse Weather Ops", "R2")
#show: columns.with(2)
= Operations in Icing Conditions
For background, see #link("https://hotstart.net/wiki/CL650/Operations_Reference/Operations_in_Icing_Conditions")[hotstart.net].

Icing conditions exist at a Total Air Temperature (TAT) of $10 degree "C"$ ($50 degree "F"$) or below with visible moisture in any form (such as clouds, rain, snow, sleet, or ice crystals), except when Static Air Temperature (SAT) is $−40 degree "C"$ ($−40 degree "F"$) or below.

$ −40 degree "C" "SAT" <= "ICING RANGE" <= 10 degree upright(C) "TAT" $

== Icing in Flight
- whenever in icing conditions:
  - Cowl Anti-Ice must be selected ON; and
  - Wing Anti-Ice must be selected NORM when
    - below 22,000ft, or
    - "ICE" is shown on the CAS.
- regardless of icing conditions:
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
- When the aircraft has not been treated with anti-ice fluid, the Wing Anti-Ice must be selected NORM during the final stages of taxi when $"OAT" <= 5 degree upright(C)$ *regardless* of icing conditions, until a green "WING A/ICE ON" message is shown on the CAS. If not required for take-off it can then be selected OFF.
- Wing Anti-Ice must be selected NORM for take-off when 
  - $"OAT" <= 5 degree upright(C)$, and
  - there is:
    - visible moisture in any form is present below 400 ft, or
    - wet/contaminated runway, or
    - any precipitation.
  - If the aircraft has been treated with anti-ice fluid the Wing Anti-Ice system should be selected NORM immediately before setting take-off thrust.
  - If no fluid treatment has occurred the Wing Anti-Ice system should be selected NORM in the final stages of taxi.

#signature-field()
