FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY MedicationPrescriber.sln ./
COPY MedicationPrescriber.Api/*.csproj ./MedicationPrescriber.Api/
COPY MedicationPresriber.Domain/*.csproj ./MedicationPresriber.Domain/
RUN dotnet restore

COPY . .

WORKDIR /src/MedicationPresriber.Domain
RUN dotnet build  -c Release -o /app

WORKDIR /src/MedicationPrescriber.Api
RUN dotnet build -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
RUN dotnet dev-certs https -t
ENTRYPOINT ["dotnet", "MedicationPrescriber.Api.dll"]