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
                              User.avtURL ||
                              'https://camo.githubusercontent.com/eb6a385e0a1f0f787d72c0b0e0275bc4516a261b96a749f1cd1aa4cb8736daba/68747470733a2f2f612e736c61636b2d656467652e636f6d2f64663130642f696d672f617661746172732f6176615f303032322d3531322e706e67'
                            "
                          ></v-img>
                        </v-avatar>
                      </v-col>
                      <v-col>
                        <v-text-field
                          variant="underlined"
                          label="Name"
                        ></v-text-field>
                        <v-menu>
                          <template v-slot:activator="{ props }">
                            <v-text-field
                              variant="underlined"
                              label="Birthday"
                              append-icon="mdi-calendar"
                              readonly
                              v-bind="props"
                              v-model="newUserInfo.birth"
                            ></v-text-field>
                          </template>
                          <v-date-picker
                            v-model="cal"
                            :landscape="true"
                            :reactive="true"
                          ></v-date-picker>
                        </v-menu>
                        <v-text-area></v-text-area>
                        <v-file-input
                          append-icon="$file"
                          prepend-icon=""
                          label="File input"
                          density="compact"
                          variant="underlined"
                        ></v-file-input>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-text>
              </v-card>
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
import store from "@/store";
import { mapState } from "vuex";
export default {
  data() {
    return {
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
    ...mapState(["currentAccount"]),
    birthDate() {
      var date = new Date(this.newUserInfo.birth);

      // Lấy thông tin ngày, tháng và năm
      var day = date.getDate();
      var month = date.getMonth() + 1; // Tháng được đánh số từ 0 đến 11, nên cần cộng thêm 1
      var year = date.getFullYear();

      // Định dạng lại chuỗi ngày tháng thành "dd-mm-yyyy"
      var formattedDate =
        ("0" + day).slice(-2) + "-" + ("0" + month).slice(-2) + "-" + year;
      return formattedDate == "01-01-1970" ? "00-00-0000" : formattedDate;
    },
  },
  methods: {},
  async beforeRouteEnter() {
    await store.commit("connect");
  },
};
</script>

<style lang="scss" scoped></style>
