# Setup Wordpress in GKE


1. Set up variables
   ```
   export PROJECT_ID=$(gcloud config get-value project)
   export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
   export REGION="us-central1"
   gcloud config set compute/region $REGION
   ```


2. Enable Google Services
   ```
   gcloud services enable \
   cloudresourcemanager.googleapis.com \
   container.googleapis.com \
   artifactregistry.googleapis.com \
   containerregistry.googleapis.com \
   containerscanning.googleapis.com
   ```
  
3. Create GKE Cluster
   ```
   gcloud container clusters create wordpress-cluster --num-nodes=3 --machine-type=e2-small --zone us-central1-a

   gcloud container clusters get-credentials wordpress-cluster --zone=us-central1-a
   ```

4. Create a Docker Repository on Artifact registry
   ```
   gcloud artifacts repositories create wordpress-container --repository-format=docker \
   --location=$REGION \
   --description="Docker repository for Wordpress"
   ```

5. Run the following command to configure Git and GitHub in Cloud Shell:
   ```
   gh auth login
   Where do you use GitHub? GitHub.com
   What is your preferred protocol for Git operations on this host? HTTPS
   Authenticate Git with your GitHub credentials? Yes
   How would you like to authenticate GitHub CLI? Paste an authentication token
   Tip: you can generate a Personal Access Token here https://github.com/settings/tokens
   The minimum required scopes are 'repo', 'read:org', 'workflow'.
   Paste your authentication token: ****************************************
   gh config set -h github.com git_protocol https
   ✓  Configured git protocol
   ✓ Logged in as sherwin-ad
   ! You were already logged in to this account
   ```

6. In Cloud Shell, run the following commands to create the Git repository:
   ```
   gh repo create wordpress-gke-cicd --public
   ```

   ```
   git init
   git add .
   git commit -m "first commit"
   git branch -M main
   git remote add origin git@github.com:sherwin-ad/wordpress-gke-cicd.git
   git push -u origin main
   ```
   

   ```
   sed 's/$PROJECT_ID/dev-staging-337304/g' cloudbuild.yaml
   ```