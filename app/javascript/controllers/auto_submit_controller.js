import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-submit"
export default class extends Controller {
  connect() {
  }

  submit() {
    this.element.requestSubmit()
  }
}
