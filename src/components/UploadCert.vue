<template>
  <v-expansion-panel title="Upload Certiticate">
    <v-expansion-panel-text>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              variant="underlined"
              label="Recipient"
              v-model="recipient"
            ></v-text-field>
            <v-text-field
              variant="underlined"
              label="Certificate's Name"
              v-model="name"
            ></v-text-field>
            <v-textarea
              variant="underlined"
              label="Description"
              rows="1"
              auto-grow
              v-model="description"
            ></v-textarea>
            <v-text-field
              variant="underlined"
              label="Certificate Image URL"
              v-model="imgURL"
            ></v-text-field>
            <v-btn @click="uploadNFT()" block variant="outlined">Upload</v-btn>
          </v-col>
          <v-col>
            <v-img
              :src="
                imgURL ||
                'https://flowbite.com/docs/images/examples/image-1@2x.jpg'
              "
            ></v-img>
          </v-col>
        </v-row>
      </v-container>
    </v-expansion-panel-text>
  </v-expansion-panel>
</template>

<script>
import contract from "@/contracts/Web3";
import { mapState } from "vuex";
export default {
  data() {
    return {
      recipient: "",
      description: "",
      name: "",
      imgURL: "",
    };
  },
  computed: {
    ...mapState(["currentAccount"]),
  },
  methods: {
    async uploadJSONToPinata(data) {
      const options = {
        method: "POST",
        headers: {
          accept: "application/json",
          "content-type": "application/json",
          authorization: `Bearer ${process.env.VUE_APP_JWT}`,
        },
        body: JSON.stringify({
          pinataContent: data,
          pinataOptions: { cidVersion: 1 },
        }),
      };

      const response = await fetch(
        "https://api.pinata.cloud/pinning/pinJSONToIPFS",
        options
      );
      return response.json();
    },
    async uploadNFT() {
      const data = {
        name: this.name,
        description: this.description,
        image: this.imgURL,
      };
      const hash = await this.uploadJSONToPinata(data);
      const tokenUri = `${process.env.VUE_APP_GATEWAY}${hash.IpfsHash}`;

      contract.methods
        .mint(this.recipient, tokenUri)
        .send({ from: this.currentAccount })
        .then((data) => {
          this.name = "";
          this.description = "";
          this.imgURL = "";
          this.recipient = "";
          console.log(data);
          alert("Success!");
        })
        .catch((err) => {
          console.log(err);
          alert("Error!");
        });
    },
  },
};
</script>

<style lang="scss" scoped></style>
