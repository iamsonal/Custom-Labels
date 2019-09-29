import retrieveCustomLabels from "@salesforce/apex/CustomLabelController.retrieveCustomLabels";

const getCustomLabels = (resourcePath = null) => {
  return new Promise(resolve => {
    retrieveCustomLabels(resourcePath)
      .then(data => {
        let response = JSON.parse(data);
        resolve(response);
      })
      .catch(error => {
        resolve(error);
      });
  });
};

export { getCustomLabels };
