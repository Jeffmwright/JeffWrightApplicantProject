import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]
  static values = {
    url: String,
    field: String,
    type: { type: String, default: "text" },
    multiline: { type: Boolean, default: false },
    options: Array,
    raw: String
  }

  connect() {
    this.editing = false
    this.element.classList.add("editable-field--enabled")
  }

  startEdit(event) {
    if (this.editing) return
    if (event.target.closest("input, select, textarea, button")) return

    this.editing = true
    this.element.classList.add("editable-field--editing")

    const input = this.buildInput()
    this.displayTarget.hidden = true
    this.element.appendChild(input)
    input.focus()

    if (input.select) {
      input.select()
    }
  }

  buildInput() {
    let input

    if (this.typeValue === "select") {
      input = document.createElement("select")
      input.className = "editable-field__input"

      this.optionsValue.forEach((option) => {
        const el = document.createElement("option")
        el.value = option
        el.textContent = option
        el.selected = option === this.rawValue
        input.appendChild(el)
      })
    } else if (this.multilineValue) {
      input = document.createElement("textarea")
      input.className = "editable-field__input editable-field__input--multiline"
      input.rows = 4
      input.value = this.rawValue
    } else {
      input = document.createElement("input")
      input.className = "editable-field__input"
      input.type = this.typeValue === "number" ? "number" : "text"
      if (this.typeValue === "number") {
        input.min = this.fieldValue === "grade" ? "0" : "1"
        input.max = this.fieldValue === "grade" ? "100" : ""
      }
      input.value = this.rawValue
    }

    input.addEventListener("keydown", (event) => this.handleKeydown(event, input))
    input.addEventListener("blur", () => this.save(input))

    return input
  }

  handleKeydown(event, input) {
    if (event.key === "Escape") {
      event.preventDefault()
      this.cancel(input)
      return
    }

    if (event.key === "Enter" && (!this.multilineValue || !event.shiftKey)) {
      event.preventDefault()
      input.blur()
    }
  }

  async save(input) {
    if (!this.editing) return

    const formData = new FormData()
    formData.append(`report[${this.fieldValue}]`, input.value)
    formData.append("_method", "put")
    formData.append("authenticity_token", this.csrfToken)

    try {
      const response = await fetch(this.urlValue, {
        method: "POST",
        body: formData,
        headers: { Accept: "application/json" }
      })

      const data = await response.json()

      if (response.ok) {
        this.rawValue = data.raw
        this.displayTarget.innerHTML = data.display
        this.clearError()
        this.finishEditing(input)
      } else {
        this.showError(data.errors?.join(", ") || "Could not save.")
        input.focus()
      }
    } catch {
      this.showError("Could not save. Please try again.")
      input.focus()
    }
  }

  cancel(input) {
    this.clearError()
    this.finishEditing(input)
  }

  finishEditing(input) {
    input.remove()
    this.displayTarget.hidden = false
    this.element.classList.remove("editable-field--editing")
    this.editing = false
  }

  showError(message) {
    let error = this.element.querySelector(".editable-field__error")
    if (!error) {
      error = document.createElement("p")
      error.className = "editable-field__error"
      this.element.appendChild(error)
    }
    error.textContent = message
  }

  clearError() {
    this.element.querySelector(".editable-field__error")?.remove()
  }

  get csrfToken() {
    return document.querySelector("meta[name='csrf-token']")?.content
  }
}
