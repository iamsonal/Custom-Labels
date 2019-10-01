import retrieveCustomLabels from "@salesforce/apex/CustomLabelController.retrieveCustomLabels";

let _data = {};

const getCustomLabels = (resourcePath = null) => {
  return new Promise(resolve => {
    if (Object.entries(_data).length === 0) {
      retrieveCustomLabels(resourcePath)
        .then(data => {
          let response = JSON.parse(data);
          _data = response;
          resolve(_data);
        })
        .catch(error => {
          resolve(error);
        });
    } else {
      resolve(_data);
    }
  });
};

export { getCustomLabels };
