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
Während Bildungsplattformen sich stetig an moderne Lernparadigmen anpassen, gewinnen Learning-Management-Systeme (LMS) wie Artemis zunehmend an Bedeutung in der Organisation von Programmierkursen. Trotzdem sind Tutoren nach wie vor mit der zeitaufwendigen Herausforderung konfrontiert, detailliertes Feedback zu geben. Das kürzlich eingeführte Athena-System hat zwar den Prozess für Textübungen teilweise automatisiert, jedoch bleibt eine Lücke bei den Programmierübungen bestehen. Die vorliegende Masterarbeit zielt darauf ab, diese Lücke zu schließen, indem Athena so modifiziert wird, dass es sowohl Text- als auch Programmierübungen auf integrierte Weise behandeln kann.

Ein modulares Design wird implementiert, das die Integration und Austauschbarkeit von Komponenten zur Feedbackgenerierung erleichtert. In dieser neuen Architektur sind sowohl CoFee, das aktuelle Modul für Feedback bei Textübungen aus Athena, als auch "ThemisML," ein Machine-Learning-Modul speziell für Programmierübungen, enthalten. Dieses überarbeitete Athena-System wird im Anschluss in die bestehende Artemis-Plattform integriert.

Unsere Methodik beginnt mit der Analyse des bestehenden Athena-Frameworks, um Verbesserungsmöglichkeiten zu identifizieren. Anschließend wird eine modulare Struktur entworfen und implementiert, die darauf abzielt, verschiedene Übungstypen zu unterstützen und den leichten Austausch von Feedback-Modulen zu ermöglichen. Nach der Integration des erneuerten Athena-Systems in die Artemis-Plattform wird eine kurze Evaluation durchgeführt, um die Qualität des automatisierten Feedbacks zu beurteilen.

Indem der Funktionsumfang von Athena erweitert wird, um eine größere Bandbreite an Übungen abzudecken, hat diese Masterarbeit das Ziel, den "Feedback Loop" in der Programmierausbildung zu optimieren und so sowohl für Tutoren als auch für Studierende Vorteile zu generieren.
  ]
  
  v(1fr)
}