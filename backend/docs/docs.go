// Package docs Code generated by swaggo/swag. DO NOT EDIT
package docs

import "github.com/swaggo/swag"

const docTemplate = `{
    "schemes": {{ marshal .Schemes }},
    "swagger": "2.0",
    "info": {
        "description": "{{escape .Description}}",
        "title": "{{.Title}}",
        "contact": {},
        "version": "{{.Version}}"
    },
    "host": "{{.Host}}",
    "basePath": "{{.BasePath}}",
    "paths": {
        "/auth/check-auth": {
            "get": {
                "description": "check access token",
                "tags": [
                    "auth"
                ],
                "summary": "Check auth header",
                "parameters": [
                    {
                        "type": "string",
                        "description": "Authorization header must be set for valid response. It should be in format: Bearer {access_token}",
                        "name": "Authorization",
                        "in": "header",
                        "required": true
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK. Access token is valid"
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    }
                }
            }
        },
        "/auth/get-verification-code": {
            "post": {
                "description": "send verification code to user's email",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "auth"
                ],
                "summary": "Get verification code",
                "parameters": [
                    {
                        "description": "getVerifCode request parameters",
                        "name": "request",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/v1.getVerifCodeRequest"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK. Email with verification code was sent to user"
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "404": {
                        "description": "Not Found. User with provided email is not signing up",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    }
                }
            }
        },
        "/auth/login": {
            "post": {
                "description": "log user in",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "auth"
                ],
                "summary": "Log user in",
                "parameters": [
                    {
                        "description": "login request parameters",
                        "name": "request",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/v1.loginRequest"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK. User was logged in",
                        "schema": {
                            "$ref": "#/definitions/v1.loginResponse"
                        }
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "401": {
                        "description": "Unauthorized. Email or password is incorrect",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    }
                }
            }
        },
        "/auth/logout": {
            "post": {
                "description": "log user out using refresh-token",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "auth"
                ],
                "summary": "Log user out",
                "parameters": [
                    {
                        "description": "logout request parameters",
                        "name": "request",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/v1.logoutRequest"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK. User was logged out",
                        "schema": {
                            "$ref": "#/definitions/v1.refreshTokensResponse"
                        }
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    }
                }
            }
        },
        "/auth/refresh-tokens": {
            "post": {
                "description": "get new access and refresh tokens",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "auth"
                ],
                "summary": "Refresh tokens",
                "parameters": [
                    {
                        "description": "refreshTokens request parameters",
                        "name": "request",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/v1.refreshTokensRequest"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK. Tokens were refreshed",
                        "schema": {
                            "$ref": "#/definitions/v1.refreshTokensResponse"
                        }
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "401": {
                        "description": "Unauthorized. Request cannot be processed with provided credentials",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    }
                }
            }
        },
        "/auth/register": {
            "post": {
                "description": "register new user",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "auth"
                ],
                "summary": "Register user",
                "parameters": [
                    {
                        "description": "register request parameters",
                        "name": "request",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/v1.registerRequest"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK. Message was sent to user"
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "409": {
                        "description": "Conflict. User with provided email already exists",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    }
                }
            }
        },
        "/auth/verify-email": {
            "post": {
                "description": "verify user's email by confirmation code",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "auth"
                ],
                "summary": "Verify user's email",
                "parameters": [
                    {
                        "description": "verify code request parameters",
                        "name": "request",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/v1.verifyCodeRequest"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK. User was verified",
                        "schema": {
                            "$ref": "#/definitions/v1.verifyCodeResponse"
                        }
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "401": {
                        "description": "Unauthorized. User provided invalid verification code",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "$ref": "#/definitions/apperr.AppError"
                        }
                    }
                }
            }
        }
    },
    "definitions": {
        "apperr.AppError": {
            "type": "object",
            "properties": {
                "code": {
                    "type": "string"
                },
                "dev_message": {
                    "type": "string"
                },
                "err_message": {
                    "type": "string"
                },
                "user_message": {
                    "type": "string"
                }
            }
        },
        "v1.getVerifCodeRequest": {
            "type": "object",
            "properties": {
                "email": {
                    "type": "string"
                }
            }
        },
        "v1.loginRequest": {
            "type": "object",
            "properties": {
                "email": {
                    "type": "string"
                },
                "fingerprint": {
                    "type": "string"
                },
                "password": {
                    "type": "string"
                }
            }
        },
        "v1.loginResponse": {
            "type": "object",
            "properties": {
                "access_token": {
                    "type": "string"
                },
                "refresh_token": {
                    "type": "string"
                }
            }
        },
        "v1.logoutRequest": {
            "type": "object",
            "properties": {
                "refresh_token": {
                    "type": "string"
                }
            }
        },
        "v1.refreshTokensRequest": {
            "type": "object",
            "properties": {
                "fingerprint": {
                    "type": "string"
                },
                "refresh_token": {
                    "type": "string"
                },
                "user_id": {
                    "type": "string"
                }
            }
        },
        "v1.refreshTokensResponse": {
            "type": "object",
            "properties": {
                "access_token": {
                    "type": "string"
                },
                "refresh_token": {
                    "type": "string"
                }
            }
        },
        "v1.registerRequest": {
            "type": "object",
            "properties": {
                "email": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "password": {
                    "type": "string"
                }
            }
        },
        "v1.verifyCodeRequest": {
            "type": "object",
            "properties": {
                "code": {
                    "type": "string"
                },
                "email": {
                    "type": "string"
                },
                "fingerprint": {
                    "type": "string"
                }
            }
        },
        "v1.verifyCodeResponse": {
            "type": "object",
            "properties": {
                "access_token": {
                    "type": "string"
                },
                "refresh_token": {
                    "type": "string"
                }
            }
        }
    }
}`

// SwaggerInfo holds exported Swagger Info so clients can modify it
var SwaggerInfo = &swag.Spec{
	Version:          "1.0",
	Host:             "localhost:8080",
	BasePath:         "/v1",
	Schemes:          []string{},
	Title:            "Habit Tracker API",
	Description:      "habit tracker API for mobile app",
	InfoInstanceName: "swagger",
	SwaggerTemplate:  docTemplate,
	LeftDelim:        "{{",
	RightDelim:       "}}",
}

func init() {
	swag.Register(SwaggerInfo.InstanceName(), SwaggerInfo)
}
