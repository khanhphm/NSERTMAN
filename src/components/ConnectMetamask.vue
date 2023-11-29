<template>
  <v-btn
    variant="outlined"
    color="secondary"
    @click="connect"
    v-if="!isConnected"
    @user-access="connect()"
  >
    Connect Metamask
  </v-btn>
  <div v-if="isConnected">
    <v-chip color="secondary" class="mr-3 text-caption">
      <strong>{{ shortenedAddress }}</strong>
    </v-chip>
    <v-avatar size="32" color="dark">
      <v-img :src="avatarUrl" />
    </v-avatar>
  </div>
</template>

<script>
//import Web3 from "web3";
import blockies from "ethereum-blockies";
import { mapMutations, mapState } from "vuex";

export default {
  data() {
    return {};
  },
  computed: {
    ...mapState(["currentAccount", "isConnected", "isManager"]),
    shortenedAddress() {
      if (!this.currentAccount) return "";
      return (
        this.currentAccount.slice(0, 6) + "..." + this.currentAccount.slice(-4)
      );
    },
    avatarUrl() {
      if (!this.currentAccount) return "";
      console.log(
        blockies
          .create({
            seed: this.currentAccount,
            size: 4,
            scale: 8,
          })
          .toDataURL()
      );
      return blockies
        .create({ seed: this.currentAccount, size: 8, scale: 16 })
        .toDataURL();
    },
  },
  methods: {
    ...mapMutations(["connect", "updateAccount"]),
  },
  mounted() {
    if (typeof window.ethereum !== "undefined") {
      this.connect();
      window.ethereum.on("accountsChanged", this.updateAccount);
    }
  },
};
</script>

<style scoped></style>
