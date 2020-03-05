import { Controller } from "stimulus";
import places from "places.js";

export default class extends Controller {
  static targets = ["input", "form"];

  connect() {
    if (!document.querySelector(".ap-icon-pin"))
      places({ container: this.inputTarget });

    const geoloc = document.querySelector(".ap-icon-pin");
    geoloc.addEventListener("click", this.getGeoloc.bind(this));
  }

  getGeoloc(event) {
    event.preventDefault();

    navigator.geolocation.getCurrentPosition(success.bind(this), error);

    function success(pos) {
      var crd = pos.coords;

      fetch(
        "/location.html?query_location=" + crd.latitude + " " + crd.longitude
      )
        .then(response => {
          return response.json();
        })
        .then(json => {
          this.inputTarget.value = json.address;
          this.formTarget.submit();
        });
    }

    function error(err) {
      console.warn(`ERREUR (${err.code}): ${err.message}`);
    }
  }

  onKeyEnter(event) {
    if (event.keyCode == 13) {
      this.formTarget.submit();
    }
  }

  highlight() {
    this.inputTarget.select();
  }
}
