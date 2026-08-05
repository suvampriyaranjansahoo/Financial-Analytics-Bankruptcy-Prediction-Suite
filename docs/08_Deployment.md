# Deployment

## Streamlit Community Cloud

1. Push this repository to GitHub.
2. Create an app in Streamlit Community Cloud.
3. Select `app/streamlit_app.py` as the entry point.
4. Keep sensitive data and credentials out of Git; use platform secrets when integrations are added.

The sample app runs without a fitted ML artefact. For a private deployment, train a reviewed model, store it in controlled artifact storage, and add monitoring before exposing probability outputs.
