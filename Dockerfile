# Usar uma imagem base do Maven com JDK 11
FROM maven:3.8.6-jdk-11 AS build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o pom.xml e o diretório src
COPY pom.xml .
COPY src ./src

# Compilar a aplicação e rodar os testes
RUN mvn clean package

# Usar uma imagem base do OpenJDK para rodar a aplicação
FROM openjdk:11-jre-slim

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o jar gerado na etapa anterior
COPY --from=build /app/target/provaEngenhariaDeSoftware1-1.0-SNAPSHOT.jar ./app.jar

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
