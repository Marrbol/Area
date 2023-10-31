const axios = require('axios');
const { callReactionTwitch } = require('./reactions');
require('dotenv').config();

var counter = 0;
var counter_twitch = 0;
var recup_Total;
var broadcast_id;
var broadcast_id_schedule;
var recup_Total_twitch;

async function callActionTwitch(area) {
    const action_Name = area.action_Name;
    if (action_Name == "check_new_follow") {
        if (check_new_follow(area.action_Param))
            await callReactionTwitch(area);
    }
    if (action_Name == "check_new_followers") {
        if (check_new_followers(area.action_Param))
            await callReactionTwitch(area);
    }
    if (action_Name == "get_schedule") {
        if (get_schedule(area.action_Param))
            await callReactionTwitch(area);
    }
}

async function getFollowedChannel(access_token_twitch) {
    try {
      var user_id_twitch;
      const userURL = 'https://api.twitch.tv/helix/users';
      const headers = {
        'Client-ID': process.env.TWITCH_CLIENT,
        'Authorization': `Bearer ${access_token_twitch}`,
      };
      const response = await axios.get(userURL, { headers });

      if (response.status === 200) {
        user_id_twitch = response.data.data[0].id;
      } else {
        console.log("FAILED");
      }

      const reponse = await axios.create({
        baseURL: 'https://api.twitch.tv/helix',
        headers: {
          'Client-ID': process.env.TWITCH_CLIENT,
          'Authorization': `Bearer ${access_token_twitch}`,
        },
      }).get('/channels/followed', {
        params: {
          user_id: user_id_twitch,
        },
      });
      counter = counter + 1;
      return reponse.data;
    } catch(error) {
      console.log("ERROR GETTING FOLLOWED CHANNELS");
      console.log(error);
    }
}

async function check_new_follow(areaContent) {
    const test = await getFollowedChannel(areaContent.access_token);
    if (counter === 1) {
        recup_Total = test.total;
    } else {
        if (recup_Total < test.total) {
            console.log("NOUVEAU FOLLOW");
            recup_Total = test.total;
        } else if (recup_Total > test.total) {
            console.log("UNFOLLOW");
            recup_Total = test.total;
        } else
            console.log("PAS DE NOUVEAU FOLLOW");
    }
}

async function checkNewFollow(access_token_twitch) {
  try {
    const response = await axios.get(`https://api.twitch.tv/helix/users?login=ferius19`, {
      headers: {
        'Client-ID': process.env.TWITCH_CLIENT,
        'Authorization': `Bearer ${access_token_twitch}`,
      },
    });

    if (response.status === 200) {
      broadcast_id = response.data.data[0].id;
    } else
      console.log("FAILED");

    const reponse = await axios.create({
      baseURL: 'https://api.twitch.tv/helix',
      headers: {
        'Client-ID': process.env.TWITCH_CLIENT,
        'Authorization': `Bearer ${access_token_twitch}`,
      },
    }).get('/channels/followers', {
      params: {
        broadcaster_id: broadcast_id,
      },
    });
    counter_twitch = counter_twitch + 1;
    return reponse.data;
  } catch (error) {
    console.log("ERROR GETTING FOLLOWERS CHANNELS");
    console.log(error);
  }
}

async function check_new_followers(areaContent) {
  const test = await checkNewFollow(areaContent.access_token);
    if (counter === 1)
      recup_Total_twitch = test.total;
    else {
      if (recup_Total_twitch < test.total) {
        console.log("NOUVEAU FOLLOWING");
        recup_Total_twitch = test.total;
      } else if (recup_Total_twitch > test.total) {
          console.log("PERDU UN FOLLOWING");
          recup_Total_twitch = test.total;
      } else
        console.log("PAS DE NOUVEAU FOLLOWING");
    }
}

async function getStreamerSchedule(access_token_twitch) {
  try {
    const response = await axios.get(`https://api.twitch.tv/helix/users?login=squeezie`, {
      headers: {
        'Client-ID': process.env.TWITCH_CLIENT,
        'Authorization': `Bearer ${access_token_twitch}`,
      },
    });

    if (response.status === 200) {
      broadcast_id_schedule = response.data.data[0].id;
    } else
      console.log("FAILED");

    const reponse = await axios.create({
      baseURL: 'https://api.twitch.tv/helix',
      headers: {
        'Client-ID': process.env.TWITCH_CLIENT,
        'Authorization': `Bearer ${access_token_twitch}`,
      },
    }).get('/schedule', {
      params: {
        broadcaster_id: broadcast_id_schedule,
      },
    });
    return response.data.data.segments;
  } catch (error) {
    console.log("ERROR GETTING SCHEDULE");
    console.log(error);
  }
}

async function get_schedule(areaContent) {
  const test = await getStreamerSchedule(areaContent.access_token);
  console.log("RESULT: " + test);
}

module.exports = { callActionTwitch };