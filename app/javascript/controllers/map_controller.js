import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'

export default class extends Controller {
    static targets = ["map"]

    connect() {
        this.initializeMap();
        document.addEventListener("turbo:frame-load", this.initializeMap.bind(this));
    }

    disconnect() {
        document.removeEventListener("turbo:frame-load", this.initializeMap.bind(this));
    }

    initializeMap() {
        const mapElement = this.mapTarget;
        if (!mapElement) return;

        // Check if the map is already initialized to prevent reinitialization
        if (this.map) {
            this.map.remove();
        }

        this.map = L.map(this.mapTarget).setView([51.505, -0.09], 13);
        L.marker([51.5, -0.09]).addTo(this.map);
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(this.map);
    }
}
