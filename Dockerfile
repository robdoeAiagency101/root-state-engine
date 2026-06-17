FROM mcr.microsoft.com/powershell:7.4-ubuntu-22.04
ENV SYSTEM_MODULE="StateEngine" RUNTIME_AUTH="Robdoe"
COPY . /workspace
WORKDIR /workspace
CMD ["pwsh"]
