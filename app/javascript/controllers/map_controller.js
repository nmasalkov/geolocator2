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

        const latitude = mapElement.dataset.mapLatitude;
        const longitude = mapElement.dataset.mapLongitude;

        if (!latitude || !longitude) {
            console.error("Latitude or Longitude data attribute is missing.");
            return;
        }

        if (this.map) {
            this.map.remove();
        }

        this.map = L.map(this.mapTarget).setView([latitude, longitude], 13);
        L.marker([latitude, longitude]).addTo(this.map);
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(this.map);
    }
}
