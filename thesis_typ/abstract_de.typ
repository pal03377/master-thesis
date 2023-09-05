#let abstract_de() = {
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

  
  // --- Abstract (EN) ---
  v(1fr)
  align(center, text(font: body-font, 1em, weight: "semibold", "Zusammenfassung"))
  
  par(justify: true)[
Während sich Bildungsplattformen weiterentwickeln, um modernen Lernansätzen gerecht zu werden, spielen Learning-Management-Systeme wie Artemis eine entscheidende Rolle in der Organisation von Programmierkursen. Trotzdem stehen Dozenten und Tutoren vor der zeitaufwendigen Herausforderung, detailliertes Feedback zu liefern. Obwohl das kürzlich eingeführte Athena-System bereits einen semi-automatisierten Ansatz für Textaufgaben bietet, existiert eine noch ungeschlossene Lücke im Bereich der Programmieraufgaben. Die in dieser Masterarbeit durchgeführte Forschung zielt darauf ab, diese Lücke zu schließen, indem Athena so modifiziert wird, dass es sowohl Text- als auch Programmieraufgaben in einer einheitlichen Weise behandeln kann.

Wir setzen ein modulares Design um, das die Hinzufügung und Austauschbarkeit von Komponenten zur Feedbackgenerierung vereinfacht. In dieser neuen Architektur sind sowohl CoFee, Athenas aktuelles Modul für Feedback zu Textaufgaben, als auch ein für Programmieraufgaben spezialisiertes Modul auf Basis von maschinellem Lernen integriert. Dieses erweiterte Athena-System integrieren wir in Artemis.

Wir analysieren die bestehende Struktur von Athena, um Verbesserungspotenziale zu identifizieren. Daraufhin entwerfen und implementieren wir eine modulare Architektur, die speziell darauf zugeschnitten ist, verschiedene Arten von Übungsaufgaben zu unterstützen und das System durch das Hinzufügen neuer Feedback-Module erweitern zu können. Außerdem führen wir eine kurze Evaluierung durch, um die Qualität des automatisierten Feedbacks zu beurteilen.

Indem wir die Fähigkeiten von Athena ausbauen, verfolgt diese Masterarbeit das Ziel, die Feedback-Loop in der Programmierausbildung zu verkürzen, was sowohl für Dozenten als auch für Studierende deutliche Vorteile bietet.
]
  
  v(1fr)
}