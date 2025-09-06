FROM thelounge/thelounge:latest

# Install the CG theme
USER root
RUN npm install -g thelounge-theme-cg
USER thelounge

# The theme will be available for selection