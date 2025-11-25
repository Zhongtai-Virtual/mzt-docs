#import "@preview/pro-letter:0.1.1": pro-letter
#import "@preview/tiaoma:0.3.0"

#show: pro-letter.with(
  sender: (
    name: "Weiqi Yu",
    company: "Zhongtai Virtual",
    street: "505 Gayley Ave Apt 305",
    city: "LOS ANGELES",
    state: "CA",
    zip: "90024\nUNITED STATES",
    phone: "+1-310-696-3048",
    email: "weiqiyu@pm.me",
  ),

  recipient: (
    name: if "name" in sys.inputs {sys.inputs.at("name")} else {"NAME"},
  ),

  date: datetime.today().display("[month]/[day]/[year]"),
  subject: "Invitation Letter",
  signer: "Weiqi Yu",
  font: "Sarasa Fixed CL",
  closing: "Warm regards,",
  attachments: tiaoma.qrcode("https://discord.gg/dV9zjKNj", options: (scale: 2.0))
)

We are writing to you on behalf of Zhongtai Virtual to sincerely invite you to join our team as a pilot for HotStart Challenger 650.

Zhongtai Virtual is a growing virtual airline (ICAO MZT, callsign ZHONGTAI/中太) simulating operations of the real-world ZYB Lily Jet. We are committed to delivering professional, efficient, and safe virtual aviation experiences and have been greatly impressed with your exceptional skills and extensive experience in flight simulation, as well as your profound passion for aviation -- a quality that aligns perfectly with our company’s values. We believe that your expertise and enthusiasm will bring valuable energy to our team and further enhance the quality of our services.

The Challenger 650 is a high-performance, technologically advanced business aircraft. Starting from that, the excellent HotStart Challenger 650 plugin further elevates career realism at Zhongtai Virtual through unparalleled systems depth and authentic operational experience, by featuring detailed modeling of aircraft systems that is not only built from first principles of physics but also interactively viewable from designated study panels, and comprehensive FBO integration with persistent aircraft states between sessions; this immersion is further enhanced by our exclusive aircraft state syncing solution which enables seamless shared operations by maintaining synchronization of aircraft buttons and FMS settings across pilots. Together with the native shared cockpit functionality provided by the plugin, they provide our pilots with the most realistic multi-crew flying experience so far in flight simulation.

We are confident that your talent and dedication will find full expression here at Zhongtai Virtual, and we look forward to growing together. We truly hope you will accept this invitation and join us in creating a brilliant future.

Should you have any questions or require further information, please feel free to contact us through our Discord by scanning the QR code attached at the end of this letter.

Thank you once again for your interest in our company. We look forward to hearing from you and sincerely hope you will become part of our team.
