import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js"

// Connects to data-controller="auto-submit"
export default class extends Controller {
  static targets = [
    "completedField",
    "actionField",
    "label",
    "container",
    "referenceField"
  ]

  static values = {
    url: { type: String, default: "" }
  }

  async submit() {
    const completed = this.completedFieldTarget.checked

    if (completed) {
      this.containerTarget.classList.add("ml-4")
      this.labelTarget.classList.add("line-through-", "opacity-50")
    } else {
      this.labelTarget.classList.remove("line-through-", "opacity-50")
    }

    const body = {
      week: {
        completed,
        reference: this.hasReferenceFieldTarget ? this.referenceFieldTarget.value : null
      }
    }

    const response = await patch(this.urlValue, {
      contentType: "application/json",
      responseKind: "json",
      body: JSON.stringify(body)
    })

    if (response.ok) {
      const data = await response.json
      if (data?.completed) {
        if (typeof jsConfetti !== "undefined") {
          this.containerTarget.classList.remove("ml-4")
          jsConfetti.addConfetti()
        }
      }
    } else {
      alert("Failed to update, try again.")
    }
    setTimeout(() => {
      this.containerTarget.classList.remove("ml-4")
    }, 120)
  }
}
