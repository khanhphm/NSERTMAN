<template>
  <v-container>
    <v-row>
      <v-col cols="4">
        <v-card variant="outlined" rounded="lg">
          <v-card-text class="text-center">
            <v-avatar size="200" class="my-5">
              <v-img
                height="100%"
                cover
                :src="
                  User.avtURL ||
                  'https://camo.githubusercontent.com/eb6a385e0a1f0f787d72c0b0e0275bc4516a261b96a749f1cd1aa4cb8736daba/68747470733a2f2f612e736c61636b2d656467652e636f6d2f64663130642f696d672f617661746172732f6176615f303032322d3531322e706e67'
                "
              ></v-img>
            </v-avatar>

            <p class="text-h4">
              <strong>{{ User.name }}</strong>
            </p>
            <p class="text-button">Birthday:</p>
            <p class="text-caption">
              {{ User.birth }}
            </p>
            <p class="text-button">Address:</p>
            <p class="text-caption">{{ User.address }}</p>

            <p class="text-button">Introduce:</p>
            <p class="text-justify text-caption mx-3 mb-8">
              {{ User.introduce }}
            </p>
            <v-chip class="text-button">
              {{ certificates.length }} CERTIFICATES
            </v-chip>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="8">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Search Profile"
              placeholder="Address"
              v-model="searchAddress"
              append-inner-icon="mdi-magnify"
              @click:append-inner="Search(searchAddress)"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-carousel>
              <v-carousel-item
                v-for="(token, id) in certificates"
                :src="token.image"
                :key="id"
              >
              </v-carousel-item>
            </v-carousel>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import contract from "../contracts/Web3";

export default {
  data() {
    return {
      User: {
        name: "No Name",
        address: "0x00...000",
        birth: "00-00-0000",
        numOfCert: 0,
        avtURL: "",
      },
      searchAddress: "",
      certificates: [
        {
          name: "Dynamic Brand Specialist",
          description:
            "Eligendi sunt alias fugit. Enim omnis sed repellendus. Praesentium quia et consequuntur. Cupiditate dolore expedita asperiores. Ut corrupti voluptatum error numquam quo dolores est reiciendis. Mollitia voluptates magni voluptas eveniet.",
          image:
            "https://upload.wikimedia.org/wikipedia/commons/6/6b/Icecat1-300x300.svg",
        },
      ],
    };
  },
  methods: {
    async Search(address) {
      if (address == "") {
        alert("Để trống ô tìm kiếm");
        return;
      }
      const data = await contract.methods.userInfors(address).call();
      const res = await fetch(data);
      this.User = await res.json();
      this.User.address = address;
      const tokenData = await contract.methods
        .getTokensByAddress(address)
        .call();
      let tokens = [];

      for (const item in tokenData) {
        const id = Number(item);
        const tokenURI = await contract.methods.tokenURI(id).call();
        const res = await fetch(tokenURI);
        const token = await res.json();
        tokens.push(token);
      }
      this.certificates = tokens;
      console.log(this.certificates);
      this.searchAddress = "";
    },
  },
};
</script>

<style lang="scss" scoped></style>
