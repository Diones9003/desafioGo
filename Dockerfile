# Use uma imagem base mínima do Go
FROM golang:1.22.4-alpine AS builder
# Configure o diretório de trabalho
WORKDIR /app

# Copie os arquivos go.mod e go.sum e baixe as dependências
COPY go.mod .
RUN go mod download

# Copie o código-fonte
COPY . .

# Compile o binário
RUN go build -o main .

# Use uma imagem base mínima para o estágio final
FROM scratch

# Copie o binário do estágio de build
COPY --from=builder /app/main /app/main

# Defina o comando de inicialização
ENTRYPOINT ["/app/main"]
