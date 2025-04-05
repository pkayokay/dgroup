import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js";
// Connects to data-controller="auto-submit"
export default class extends Controller {
  static targets = [
    "completedField",
    "actionField",
    "label",
    "container",
    "referenceField"
  ]
  static values = { url: { type: String, default: "" } }

  connect() {
  }

  submit() {
    if (this.completedFieldTarget.checked) {
      this.containerTarget.classList.add("ml-4")
      this.labelTarget.classList.add("line-through-")
      this.labelTarget.classList.add("opacity-50")
    } else {
      this.labelTarget.classList.remove("line-through-")
      this.labelTarget.classList.remove("opacity-50")
    }

    patch(this.urlValue, {
      body: JSON.stringify({
        week: {
          completed: this.completedFieldTarget.checked,
          reference: this.hasReferenceFieldTarget ? this.referenceFieldTarget.value : null
        }
      })
    }).then((response) => {
      if (response.ok) {
        setTimeout(() => {
          this.containerTarget.classList.remove("ml-4")
        }, 120)
      } else {
        alert("Failed to update, try again.")
      }
    })
  }
}
