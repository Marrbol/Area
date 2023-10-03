const { Client, GatewayIntentBits } = require('discord.js');
const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent,
        GatewayIntentBits.DirectMessages,
    ],
});
const { sendMail } = require('./notifications.js');
const TOKEN = 'MTE1Njk3NDg5ODY0NDc5NTM5Mw.G-Tkor.jI6ml3UDSDKEOdiNy6DjXF2RcHvmmkGHFG6etA';

client.login(TOKEN);

client.on('ready', () => {
    console.log(`Logged in as ${client.user.tag}!`);
});

client.on('messageCreate', (msg) => {
    if (msg.guild && msg.guild.id === "1153316990128226327") {
        const messages = msg.content;

        console.log(`Message from ${msg.author.tag}: ${messages}`);
        sendMail(messages);
    }
});

module.exports = client;