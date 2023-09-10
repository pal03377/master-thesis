#let acknowledgement() = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "en"
  )

  set par(leading: 1em)

  
  // --- Acknowledgements ---
  align(left, text(font: sans-font, 2em, weight: 700,"Acknowledgements"))
  v(15mm)
  [
  My heartfelt appreciation goes to my family and friends for their steady support during my time at the Technical University of Munich.
  #v(5mm)
  I also commend the fantastic Artemis team for their tireless efforts in creating an open-source learning platform.
  #v(5mm)
  Special recognition goes to M.Sc. Maximilian Sölch, whose valuable insights have greatly enriched this thesis as my advisor.
  #v(5mm)
  Finally, my gratitude extends to Prof. Dr. Stephan Krusche, not only for his dedication to enhancing university education but also for offering me the chance to be a part of this mission.
  ]
}