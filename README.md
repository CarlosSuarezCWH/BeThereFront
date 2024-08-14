# Interfaz Gráfica para la Plataforma de Streaming

## Descripción de la Interfaz Gráfica

Esta es la interfaz gráfica para la plataforma de streaming, diseñada para proporcionar a los usuarios una experiencia intuitiva y fluida al interactuar con los eventos en vivo, gestionar sus perfiles, y realizar compras dentro de la plataforma. La interfaz gráfica está siendo desarrollada en **Flutter**, lo que permite crear aplicaciones nativas para Android e iOS desde una única base de código.

## Características Principales

- **Autenticación de Usuarios**: Los usuarios pueden iniciar sesión y registrarse directamente desde la aplicación.
- **Gestión de Perfiles**: Los usuarios pueden crear, editar y eliminar perfiles de usuario.
- **Exploración de Eventos**: Los usuarios pueden navegar y buscar eventos disponibles en la plataforma.
- **Compra de Eventos**: Integración directa con el sistema de compras de la API, permitiendo a los usuarios adquirir acceso a eventos en vivo.
- **Streaming de Eventos**: Visualización de eventos en vivo directamente desde la aplicación.
- **Desarrollo Multiplataforma**: Utilizando Flutter para desarrollar una aplicación que funcione tanto en dispositivos Android como iOS.

## Conexión con la API

La interfaz gráfica se conecta a la API de la plataforma de streaming para manejar la autenticación, la gestión de perfiles, la compra de eventos y el acceso a los streams. La comunicación entre la interfaz gráfica y la API se realiza a través de peticiones HTTP utilizando el protocolo de autenticación basado en tokens JWT.

### Endpoints Principales Utilizados:

- **Autenticación**: `/auth/login`, `/auth/register`
- **Gestión de Perfiles**: `/profiles`, `/profiles/{profile_id}`
- **Eventos**: `/events`, `/events/{event_id}`
- **Compras**: `/purchases`, `/purchases/{purchase_id}`

## Estado del Proyecto

Actualmente, la interfaz gráfica está en desarrollo activo. Algunas funcionalidades clave ya están implementadas, mientras que otras están en proceso de desarrollo. 

### Funcionalidades Implementadas:
- Autenticación básica.
- Navegación de eventos.
- Gestión de perfiles.

### Funcionalidades en Desarrollo:
- Compra de eventos.
- Integración completa de streaming.

## Requisitos Previos

Para contribuir al desarrollo de la interfaz gráfica, asegúrate de tener instalado:

- **Flutter SDK**: [Instrucciones de instalación](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (incluido con Flutter).
- **Acceso a la API**: La API debe estar configurada y en ejecución.

![5](https://github.com/user-attachments/assets/2f261524-16da-4695-921b-2235ffcfaffb)
![3](https://github.com/user-attachments/assets/7b06f079-53ac-465b-91ed-0e130712cbfd)
![2](https://github.com/user-attachments/assets/93d48bd3-ca01-433d-bd85-4e81fa00ce79)
![1](https://github.com/user-attachments/assets/a64f6977-06af-41c9-a47f-b7d3595e43b5)

