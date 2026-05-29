import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  navigate() {
    window.location = this.urlValue
  }

  keydown(event) {
    if (event.key === "Enter") {
      event.preventDefault()
      this.navigate()
    }
  }
}
