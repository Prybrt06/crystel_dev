const { Translate } = require("@google-cloud/translate").v2;
const dotenv = require("dotenv");

dotenv.config();

const CREDENTIALS = JSON.parse(process.env.CREDENTIALS);

const translate = new Translate({
	credentials: CREDENTIALS,
	projectId: CREDENTIALS.project_id,
});

const detectLanguage = async (text) => {
	try {
		let response = await translate.detect(text);
		return response[0].language;
	} catch {
		console.log(`Error at detectlanguage - ${error}`);
		return 0;
	}
};

detectLanguage("ধন্যবাদ")
	.then((res) => {
		console.log(res);
	})
	.catch((err) => {
		console.log(err);
	});

exports.tranlateText = async (text, targetLanguage) => {
	try {
		let response = await translate.translate(text, targetLanguage);
		return response[0];
	} catch (err) {
		console.log(`Error at translation - ${err}`);
		return 0;
	}
};

// tranlateText("ধন্যবাদ", "en")
// 	.then((res) => {
// 		console.log(res);
// 	})
// 	.catch((err) => {
// 		console.log(err);
// 	});
