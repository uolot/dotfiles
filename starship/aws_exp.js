const fs = require("fs");

let expires = "";
const awsCredentialExpiration = process.env.AWS_CREDENTIAL_EXPIRATION;

try {
  if (awsCredentialExpiration) {
    const exp = new Date(awsCredentialExpiration);
    const now = new Date();
    const diffMs = exp - now;
    const diffMinutes = Math.trunc(diffMs / 1000 / 60);
    expires = diffMinutes > 0 ? `${diffMinutes}m` : "EXPIRED";
  }
} catch (e) {}

let account = "";
const profile = process.env.SAML2AWS_PROFILE;

if (profile === "saml") {
  try {
    const awsCredentialsContents = fs.readFileSync(
      `${process.env.HOME}/.aws/credentials`,
      { encoding: "utf8", flag: "r" }
    );

    if (awsCredentialsContents) {
      const accounts = new Map([
        ["409621694634", "LAC PROD"],
        ["686442161031", "LAC QA"],
        ["231207746339", "LAC DEV"],
        ["976547032187", "CD PROD"],
        ["878774257274", "CD DEV"],
        ["064455468047", "CD SANDBOX"],
      ]);

      const lines = awsCredentialsContents
        .split("\n")
        .filter((line) => line.includes("x_principal_arn"));
      const accountId = lines[0]
        .split("=")
        .pop()
        .split(":")
        .filter((line) => line.match(/\d+/))[0];

      if (accounts.has(accountId)) {
        account = accounts.get(accountId);
      }
    }
  } catch (e) {}
} else {
  try {
    const [accountId, role] = profile.split(":");

    let accountName;

    switch (accountId) {
      case "lego-mct-ccd-dev":
        accountName = "CD DEV";
        break;
      default:
        accountName = "UNKNOWN (profile)";
        break;
    }

    account = `${accountName} ${role}`;
  } catch (e) {}
}

console.log(`${account} ${expires}`.trim());
