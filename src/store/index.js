import router from "@/router";
import { createStore } from "vuex";

export default createStore({
  state: {
    isConnected: false,
    currentAccount: null,
  },
  getters: {},
  mutations: {
    async connect(state) {
      if (typeof window.ethereum !== "undefined") {
        try {
          await window.ethereum.enable();
          const accounts = await window.ethereum.request({
            method: "eth_accounts",
          });
          if (accounts.length > 0) {
            state.isConnected = true;
            state.currentAccount = accounts[0];
          } else {
            state.isConnected = false;
            state.currentAccount = null;
          }
        } catch (error) {
          console.error("Failed to connect:", error);
          router.push("/");
        }
      } else {
        console.error("Metamask not found.");
      }
    },
    async updateAccount(state) {
      const accounts = await window.ethereum.request({
        method: "eth_accounts",
      });
      if (accounts.length > 0) {
        state.isConnected = true;
        state.currentAccount = accounts[0];
      } else {
        state.isConnected = false;
        state.currentAccount = null;
      }
    },
  },
  actions: {},
  modules: {},
});
