import { Application } from "@hotwired/stimulus"
import "leaflet"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
