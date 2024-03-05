const fs = require("fs");

function expires() {
  const awsCredentialExpiration = process.env.AWS_CREDENTIAL_EXPIRATION;

  try {
    if (awsCredentialExpiration) {
      const exp = new Date(awsCredentialExpiration);
      const now = new Date();
      const diffMs = exp - now;
      const diffMinutes = Math.trunc(diffMs / 1000 / 60);
      return diffMinutes > 0 ? `${diffMinutes}m` : "EXPIRED";
    }
  } catch (e) {}
  return "";
}

function accountName(accountId) {
  const names = new Map([
    ["lego-mct-ccd-prod", "CD PROD"],
    ["lego-mct-ccd-dev", "CD DEV"],
    ["lego-mct-ccd-sandbox", "CD SANDBOX"],
    ["lego-lac-prod", "LAC PROD"],
    ["lego-lac-qa", "LAC QA"],
    ["lego-lac-dev", "LAC DEV"],
    ["lego-epx-prod", "EPX PROD"],
    ["lego-epx-qa", "EPX QA"],
    ["lego-epx-dev", "EPX DEV"],
    ["lego-epx-data-prod", "EPX DATA PROD"],
  ]);

  return names.get(accountId) ?? "UNKNOWN";
}

const profile = process.env.SAML2AWS_PROFILE;

if (profile) {
  const [accountId, role] = profile.split(":");
  const name = accountName(accountId);

  console.log(`${name} ${role} ${expires()}`.trim());
}
