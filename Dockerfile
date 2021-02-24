ARG REPO=mcr.microsoft.com/dotnet
ARG VERSION=5.0

FROM ${REPO}/sdk:${VERSION} AS build-env
WORKDIR /app

# Copy project
COPY ./ ./

# Build project
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM ${REPO}/aspnet:${VERSION}
WORKDIR /app
COPY --from=build-env /app/out .

CMD ["dotnet", "demo.dll"]