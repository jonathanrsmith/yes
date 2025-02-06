# GAS Node Template
Template for setting up GAS in Node. Recommended to replace this section's title with the Google Apps Script name, and include a link to the Google Apps Scripts file in google Drive this is publishing to.

## Template Setup
When setting up a Node GAS project, ensure the .clasp.json > scriptId is assigned to the id in GAS, found under Project Settings > IDs. When publishing, the account you are logged into for clasp must have edit permission to the Apps Scripts file in Drive.

Ideally, once a repository is created in GSA Github, add a comment to the top of index.ts with the url, for example: `// https://github.com/GSA/gas-node-template`.

## Getting Started

### Install clasp globally and login
If you have already done this on this machine, you can skip this step.
<pre><code>npm install @google/clasp -g</code></pre>
<pre><code>clasp login</code></pre>

### Install dependencies
<pre><code>npm install</code></pre>

### Run Scripts
You can build the script to look at it's output.
<pre><code>npm run build</code></pre>

When you are ready to publish, run the publish script which will build, push to the GAS, and then clean up the dist folder. 
<pre><code>npm run publish</code></pre>

## Guidelines
Some general guidelines to follow when writing code.

### Publishing
By default, this simply updates the "head" of the code in GAS. It does not create a new version, nor does it update any deployments.

For Sheets, the head is what is automatically used for any actions within the spreadsheet and will take affect immediately. For Web Apps or APIs, typically those are on deployments on a specific version.

### No node dependencies allowed
Apps Scripts is unlikely to play nice with dependencies, and we want to keep the direct Apps Scripts files as simple as possible, so avoid adding any npm packages as dependencies. It might not work at all to begin with.

You can add as many devDependencies as needed since they won't be included in the publish.

### TSC and building
Typescript's CLI is used to convert the files in ./src to the output in ./dist when `npm run publish` or `npm run build` is called. Javascript files are also allowed and will simply be copied over as-is.

### Keep sensitive data outside of the code
Do not copy any sensitive data directly into the code. Use the AppConfig.ts with `PropertiesService.getScriptProperties().getProperty('<your key>')` and put any values in google the Apps Script > Project Settings > Script Properties. 
Script Properties isn't the most secure, but it's better than making it visible to any user who can see the codebase.

## Typescript
clasp technically supports directly publishing TS files to GAS. However, it's limited to TS 3.8.2. Rather than use GAS's converter to publish the TS files directly, we compile to JS so we can take full advantage of TS.

Supposedly it's ok to target ESNext and I've had no issues so far, but should the published files throw weird JS errors when trying to execute in GAS, the offical instructions recommend setting the target to ES2019 in the tsconfig.json.

## Troubleshooting

### "Manifest file has been updated. Do you want to push and overwrite?" during npm run publish
If this message appears when you try to publish, unless you know why this is happening, it's best to stop the publish and copy the manifest (appssscripts.json) from GAS to the project. 
In GAS under the editor, look for appsscripts.json file. If one is not present, go to the settings and click `Show "appsscript.json" manifest file in editor` and then refresh the page if it still doesn't show up.
Copy the contents of the appsscripts.json inside of the project, and ensure to commit the changes. Run `npm run publish` again and it should no longer provide the prompt.