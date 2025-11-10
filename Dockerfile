FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
WORKDIR /source
COPY . .
RUN curl https://api.nuget.org/v3/index.json -k
RUN dotnet restore "./plataforma-ecp.api/plataforma-ecp.api.csproj"
RUN dotnet publish "./plataforma-ecp.api/plataforma-ecp.api.csproj" -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime
WORKDIR /app
COPY --from=build /app ./
EXPOSE 5000
ENTRYPOINT [ "dotnet", "plataforma-ecp.api.dll" ]