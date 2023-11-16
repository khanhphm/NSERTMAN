<template>
  <div>
    <input type="file" @change="handleFileUpload" />
    <v-btn @click="uploadJSONToPinata">Upload</v-btn>
  </div>
</template>

<script>
export default {
  methods: {
    handleFileUpload(event) {
      this.file = event.target.files[0];
    },
    async uploadJSONToPinata() {
      const options = {
        method: "POST",
        headers: {
          accept: "application/json",
          "content-type": "application/json",
          authorization: `Bearer ${process.env.VUE_APP_JWT}`,
        },
        body: JSON.stringify({
          pinataContent: { name: "Nguyen Thi Dieu Ly" },
          pinataOptions: { cidVersion: 1 },
        }),
      };

      fetch("https://api.pinata.cloud/pinning/pinJSONToIPFS", options)
        .then((response) => response.json())
        .then((response) => console.log(response))
        .catch((err) => console.error(err));
    },
  },
  data() {
    return {
      file: null,
    };
  },
};
</script>
