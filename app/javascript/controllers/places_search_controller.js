import { Controller } from "stimulus";
import places from "places.js";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = ["input", "form"];

  connect() {
    const mapElement = document.getElementById('map');
    places({ container: this.inputTarget }).on('change', e => {
      console.log(e.suggestion)
      if (mapElement) {
        mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
        const map = new mapboxgl.Map({
          container: 'map',
          style: 'mapbox://styles/marcmerle/ck7abhm2303ag1iqj43fcw0pw',
          center: [e.suggestion.latlng.lng, e.suggestion.latlng.lat],
          zoom: 12
        });
      }
    });;
  }

  onKeyEnter(event) {
    if (event.keyCode == 13) {
      this.formTarget.submit();
    }
  }
}
