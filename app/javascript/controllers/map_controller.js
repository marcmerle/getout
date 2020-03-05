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
      style: "mapbox://styles/marcmerle/ck7euepq32ock1iob3cv5bpqz",
      center: [
        this.mapElementTarget.dataset.longitude,
        this.mapElementTarget.dataset.latitude
      ],
      zoom: 13
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
  }

  update() {
    this.map.resize();
  }
}
