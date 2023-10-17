import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    Action: '',
    ActionParams: {},
    Reaction: '',
    ReactionParams: {},
    Services: {
      Spotify: {
        Name: 'Spotify',
        ImageLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
          CheckNewEpisode: {
            Name: 'check_new_episode',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              showId: '',
            },
          },
          CheckNewSavedTrack: {
            Name: 'check_new_saved_track',
            IsParams: false,
            IsBoolParams: false,
            Params: {},
          },
        },
        Reactions: {
          CreatePlaylist: {
            Name: 'CreatePlaylist',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              name: '',
              description: '',
            },
            BoolParams: {
              is_public: false,
            },
          },
        },
      },
      Discord: {
        Name: 'Discord',
        ImageLink: 'https://m1.quebecormedia.com/emp/emp/discord31fa7044-2286-4838-be61-a8fb7db67d6e_ORIGINAL.jpg?impolicy=crop-resize&x=0&y=0&w=0&h=0&width=925',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
      Gmail: {
        Name: 'Gmail',
        ImageLink: 'https://f.hellowork.com/blogdumoderateur/2019/03/gmail-logo-1200x758.jpg',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
    },


    authentificationTokens: {
      Spotify: '',
    },
    ActionsList: {
      Spotify: {
        Actions: ['check_new_episode', 'check_new_saved_track',],
        ActionParams: {},
      },
    },
    ReactionsList: {
      Spotify: {
        reactions: ['createPlaylist'],
        ActionParams: {},
      }
    }
  },
  getters: {
    getSpotifyToken(state) {
      return state.authentificationTokens.Spotify;
    },
    getSavedAction(state) {
      return state.Action;
    },
    getSavedActionParams(state) {
      return state.ActionParams;
    },
    getSavedReaction(state) {
      return state.Reaction;
    },
    getSavedReactionParams(state) {
      return state.ReactionParams;
    }
  },
  mutations: {
    setSpotifyToken(state, token) {
      state.authentificationTokens.Spotify = token;
    },
    setSavedAction(state, action) {
      state.Action = action;
    },
    setSavedActionParams(state, actionParams) {
      state.ActionParams = actionParams;
    },
    setSavedReaction(state, reaction) {
      state.Reaction = reaction;
    },
    setSavedReactionParams(state, reactionParams) {
      state.ReactionParams = reactionParams;
    },
  },
  actions: {
  },
  modules: {
  }
})
