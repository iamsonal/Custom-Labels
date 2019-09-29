import { LightningElement, track } from "lwc";
import { getCustomLabels } from "c/customLabelService";

export default class DisplayLabels extends LightningElement {
  @track data;

  connectedCallback() {
    getCustomLabels()
      .then(data => {
        this.data = data;
      })
      .catch(error => {
        console.log(error.message);
      });
  }
}
