FROM  bellsoft/liberica-runtime-container:jre-21-slim-glibc

## GID/UID for non-priviledged user
ARG UID=10001
ARG GID=10001
ARG APP_OWNER='springboot'
ARG APP_DIR='deployment'
# Add non-priveledged user and directory for the app
RUN addgroup -S -g ${GID} ${APP_OWNER} && \
    adduser -S -u ${UID} ${APP_OWNER} -G ${APP_OWNER} && \
    mkdir /${APP_DIR} && \
	chown -R ${UID}:${UID} /${APP_DIR} 
    
LABEL org.opencontainers.image.created=$IMAGE_CREATED
LABEL org.opencontainers.image.version=$IMAGE_VERSION
LABEL org.opencontainers.image.revision=$IMAGE_REVISION

WORKDIR /${APP_DIR}
EXPOSE 8080
# Setu context to non-priviledged user
USER ${UID}
# Make user the sole owner of the app
COPY --chown=${UID}:${GID} ./**.jar /deployment/app.jar

ENTRYPOINT [ "java" ,"-jar", "app.jar"]
