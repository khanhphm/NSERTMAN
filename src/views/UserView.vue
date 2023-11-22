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
            <p class="text-caption">{{ currentAccount }}</p>

            <p class="text-button">Introduce:</p>
            <p class="text-justify text-caption mx-3 mb-8">
              {{ User.introduce }}
            </p>
            <v-chip class="text-button">
              {{ User.numOfCert }} CERTIFICATES
            </v-chip>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-dialog width="600">
              <template v-slot:activator="{ props }">
                <v-btn v-bind="props"> Update Profile </v-btn>
              </template>
              <template v-slot:default="{ isActive }">
                <v-card>
                  <v-card-title>
                    Update Profile |
                    <span class="text-caption">{{
                      currentAccount
                    }}</span></v-card-title
                  >

                  <v-card-text class="text-center">
                    <v-container>
                      <v-row>
                        <v-col cols="auto">
                          <v-avatar size="200">
                            <v-img
                              height="100%"
                              cover
                              :src="
                                newUserInfo.avtURL ||
                                'https://camo.githubusercontent.com/eb6a385e0a1f0f787d72c0b0e0275bc4516a261b96a749f1cd1aa4cb8736daba/68747470733a2f2f612e736c61636b2d656467652e636f6d2f64663130642f696d672f617661746172732f6176615f303032322d3531322e706e67'
                              "
                            ></v-img>
                          </v-avatar>
                        </v-col>
                        <v-col>
                          <v-text-field
                            variant="underlined"
                            label="Name"
                            v-model="newUserInfo.name"
                          ></v-text-field>

                          <v-text-field
                            variant="underlined"
                            label="Birthday"
                            append-icon="mdi-calendar"
                            v-model="newUserInfo.birth"
                            placeholder="dd-mm-yyyy"
                          ></v-text-field>

                          <v-textarea
                            label="Introduce:"
                            variant="underlined"
                            v-model="newUserInfo.introduce"
                            rows="1"
                            auto-grow
                          ></v-textarea>
                          <v-text-field
                            label="Avatar Url:"
                            variant="underlined"
                            v-model="newUserInfo.avtURL"
                          ></v-text-field>
                        </v-col>
                      </v-row>
                    </v-container>
                  </v-card-text>
                  <v-card-actions>
                    <v-btn
                      block
                      variant="outlined"
                      @click="uploadProfile(newUserInfo, isActive)"
                    >
                      Upload
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </template>
            </v-dialog>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-col>
      <v-col cols="8">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Search Certificate"
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
              <v-carousel-item src="https://picsum.photos/2000/1500" cover>
              </v-carousel-item>
              <v-carousel-item src="https://picsum.photos/2000/1500" cover>
              </v-carousel-item>
              <v-carousel-item src="https://picsum.photos/2000/1500" cover>
              </v-carousel-item>
              <v-carousel-item src="https://picsum.photos/2000/1500" cover>
              </v-carousel-item>
              <v-carousel-item src="https://picsum.photos/2000/1500" cover>
              </v-carousel-item>
              <v-carousel-item src="https://picsum.photos/2000/1500" cover>
              </v-carousel-item>
            </v-carousel>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState } from "vuex";
import contract from "../contracts/Web3";

export default {
  data() {
    return {
      updateForm: false,
      User: {
        name: "No Name",
        birth: "00-00-0000",
        numOfCert: 0,
        avtURL: "",
        introduce: "",
      },

      newUserInfo: {
        name: "",
        birth: "",
        avtURL: "",
        introduce: "",
      },
    };
  },
  computed: {
    ...mapState(["currentAccount", "isConnected"]),
  },
  methods: {
    async uploadProfile(user, isActive) {
      const hash = await this.uploadJSONToPinata(user);
      console.log(`${hash.IpfsHash}`);
      contract.methods
        .setInfo(`${process.env.VUE_APP_GATEWAY}${hash.IpfsHash}`)
        .send({ from: this.currentAccount, value: 10000000000000000 });
      isActive.value = false;
    },
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
    async getUserInfo() {
      const userURI = await contract.methods
        .userInfors(this.currentAccount)
        .call();
      console.log(userURI);
      const res = await fetch(userURI);
      this.User = await res.json();
      this.newUserInfo = this.User;
    },
  },
  beforeMount() {
    if (!this.isConnected) {
      alert("Bạn cần connect với Metamask");
      this.$router.push("/");
    } else {
      this.getUserInfo();
    }
  },
  mounted() {},
};
</script>

<style lang="scss" scoped></style>
