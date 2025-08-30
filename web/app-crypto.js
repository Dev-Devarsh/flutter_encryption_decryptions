// --- String Encryption/Decryption ---
function encryptString(key, data) {
	return CryptoJS.AES.encrypt(data, key).toString();
}

function decryptString(key, encryptedData) {
	const bytes = CryptoJS.AES.decrypt(encryptedData, key);
	return bytes.toString(CryptoJS.enc.Utf8);
}

// --- Map Encryption/Decryption ---
function encryptMap(key, data) {
	const jsonString = JSON.stringify(data);
	return encryptString(key, jsonString);
}

function decryptMap(key, encryptedData) {
	const decryptedString = decryptString(key, encryptedData);
	return JSON.parse(decryptedString);
}

// --- List Encryption/Decryption ---
function encryptList(key, data) {
	const jsonString = JSON.stringify(data);
	return encryptString(key, jsonString);
}

function decryptList(key, encryptedData) {
	const decryptedString = decryptString(key, encryptedData);
	return JSON.parse(decryptedString);
}

// --- Integer Encryption/Decryption ---
function encryptInt(key, data) {
	return encryptString(key, data.toString());
}

function decryptInt(key, encryptedData) {
	const decryptedString = decryptString(key, encryptedData);
	return parseInt(decryptedString, 10);
}

// --- Double Encryption/Decryption ---
function encryptDouble(key, data) {
	return encryptString(key, data.toString());
}

function decryptDouble(key, encryptedData) {
	const decryptedString = decryptString(key, encryptedData);
	return parseFloat(decryptedString);
}