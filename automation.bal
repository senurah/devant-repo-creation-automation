import ballerina/log;
import ballerina/http;

configurable string gitPAT = ?;
configurable string gitORG= ?;
configurable string REPO_NAME= ?;
// configurable string IS_PUBLIC = ?;
// configurable string DESC = ?;
// configurable string IS_ISSUES = ?;

public function main(string orgName, string repoName, string isPublic, string repoDesc, string enableIssues) returns error? {
    do {
        string org = orgName != "" ? orgName : gitORG;
        string repo = repoName !="" ? repoName : REPO_NAME;
        boolean isRepoPublic = isPublic == "true"? true: false;
        boolean hasIssues = enableIssues =="true"? true:false;

        //string orgName, string repoName, string isPublic, string repoDesc, string enableIssues

        //Getting all the values from the .env
        // string org = gitORG;
        // string repo = REPO_NAME;
        // boolean isRepoPublic = IS_PUBLIC == "true"? true:false;
        // string repoDesc = DESC;
        // boolean hasIssues = IS_ISSUES == "true"? true : false;


        // string org = "devant-test-org";
        // string repo = "from-devant";
        // boolean isRepoPublic = false;
        // boolean hasIssues = true;

        string apirUrl = string `https://api.github.com/orgs/${org}/repos`;

        http:Client githubClient = check new(apirUrl);

        map<string> headers = {
            "Authorization": string `token ${gitPAT}`,
            "Accept":"application/vnd.github.v3+json"
        };

        json payload = {
            "name":repo,
            "private": !isRepoPublic,
            "description":repoDesc,
            "has_issues":hasIssues
        };

        http:Response response = check githubClient->post("",payload,headers);

        if(response.statusCode == 201){
            log:printInfo(string `Repository ${repo} created successfully.`);
            json responseBody = check response.getJsonPayload();
            log:printInfo("Details: "+responseBody.toString());
        }else{
            string errorText = check response.getTextPayload();
            log:printError(`Error occured while creating the Repository:${response.statusCode}`);
            log:printError(errorText);
            return error(string `Failed to create the repository : ${response.statusCode}`);
        }
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
