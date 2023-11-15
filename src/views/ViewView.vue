<template>
  <v-container>
    <v-row>
      <v-col cols="4">
        <v-card variant="outlined" rounded="lg">
          <v-card-text class="text-center">
            <v-avatar size="200" class="my-5">
              <v-img
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
            <p class="text-button">Address: {{ User.address }}</p>
            <p class="text-button">Birthday: {{ User.birth }}</p>
            <v-chip class="text-button"> 32 CERTIFICATES </v-chip>
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
export default {
  data() {
    return {
      User: {
        name: "",
        address: "",
        birth: "",
        numOfCert: 0,
        avtURL: "",
      },
      searchAddress: "",
      certificates: [
        {
          name: "Dynamic Brand Specialist",
          description:
            "Eligendi sunt alias fugit. Enim omnis sed repellendus. Praesentium quia et consequuntur. Cupiditate dolore expedita asperiores. Ut corrupti voluptatum error numquam quo dolores est reiciendis. Mollitia voluptates magni voluptas eveniet.",
          image: "http://placeimg.com/300/300/certificate",
        },
      ],
    };
  },
  methods: {
    Search(address) {
      console.log(address);
      this.User = {
        name: "Nguyen Thi Dieu Ly",
        address: "0xa6...b10F",
        birth: "15-09-2005",
        numOfCert: 43,
        avtURL:
          "https://scontent.fhan14-2.fna.fbcdn.net/v/t1.15752-9/399864892_288484504170170_7342525013531525164_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=8cd0a2&_nc_eui2=AeEPQEXNkDFoqLe7KhjpNkhH594Hvc1tU-jn3ge9zW1T6KG7QW2tu1nRhQy8btAZhydUvQXxdpT2TGXtClc9qu2Z&_nc_ohc=ZEWLac0OD5QAX9-3nkl&_nc_ht=scontent.fhan14-2.fna&oh=03_AdSz9Xz0n1GauDKN4m-t6W6NyxDSdCsyDVnbq4c30mPg4g&oe=657BFF84",
      };
      this.searchAddress = "";
    },
  },
};
</script>

<style lang="scss" scoped></style>
