import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    if (this.openValue) {
      this.open()
    }
  }

  open() {
    this.overlayTarget.classList.add("modal--open")
    document.body.classList.add("modal-open")
  }

  close() {
    this.overlayTarget.classList.remove("modal--open")
    document.body.classList.remove("modal-open")
  }
}
