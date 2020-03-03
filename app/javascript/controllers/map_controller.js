import { Controller } from "stimulus";
import mapboxgl from "mapbox-gl";

export default class extends Controller {
  static targets = ["mapElement"];

  connect() {
    this.initMapbox();
  }

  initMapbox() {
    mapboxgl.accessToken = this.mapElementTarget.dataset.mapboxApiKey;

    this.map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/marcmerle/ck7abhm2303ag1iqj43fcw0pw",
      zoom: 4
    });

    const markers = JSON.parse(this.mapElementTarget.dataset.markers);
    markers.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      const element = document.createElement("div");
      element.className = "marker";
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = "contain";
      element.style.width = "35px";
      element.style.height = "35px";

      new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });

    this.fitMapToMarkers(markers.slice(0, 2));
  }

  fitMapToMarkers(markers) {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  update() {
    this.map.resize();
  }
}
