#let project(
  title: "",
  titleGerman: "",
  degree: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: none,
  submissionDate: none,
  body,
) = {
  set document(title: title, author: author)
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "1",
    number-align: center,
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "en"
  )
  show math.equation: set text(weight: 400)
  show heading: set block(below: 0.85em, above: 1em)
  show heading: set text(font: body-font)
  show heading: it => {
    v(0.5em)
    it
    v(0.5em)
  }
  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters" - modified to also support appendices
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      let n = numbering(
        el.numbering,
        ..counter(heading).at(el.location())
      )
      // Chapter detection
      if n.starts-with("Appendix") {
        // Remove ": " from the end
        n.slice(0, n.len() - 2)
      } else {
        [Chapter #n]
      }
    } else {
      it
    }
  }
  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Figures ---
  show figure: set text(size: 0.85em)

  // Cite like this: [Kru23] instead of this: [1]
  set cite(style: "alphanumerical")

  

  // --- Table of Contents ---
  set page(numbering: "(i)")
  counter(page).update(1)
  outline(
    title: {
      text(font: body-font, 1.5em, weight: 700, "Contents")
      v(15mm)
    },
    indent: 2em
  )
  
  
  v(2.4fr)
  pagebreak()


  // Main body.
  set par(justify: true)

  set page(numbering: "1")
  counter(page).update(1)

  body

  pagebreak()
  bibliography("thesis.bib")
}
