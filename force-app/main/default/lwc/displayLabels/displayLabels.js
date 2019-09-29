import { LightningElement, track } from "lwc";
import { getCustomLabels } from "c/customLabelService";

const columns = [
  { label: "Name", fieldName: "Name" },
  { label: "Value", fieldName: "Value" }
];

export default class DisplayLabels extends LightningElement {
  @track data;
  @track columns = columns;

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
