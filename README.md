# 🐶 ListOfDogsClean

Aplicación iOS desarrollada en SwiftUI utilizando Clean Architecture y SwiftData.
La app muestra una lista de perros obtenidos desde un API y almacenados localmente usando SwiftData.

---

## 🚀 Descripción del proyecto

* Cuando el usuario abre la app por primera vez, los datos de perros se obtienen desde el endpoint remoto.
* Posteriormente, los datos son almacenados en SwiftData para futuros accesos offline.
* La lista de perros muestra:

  * Imagen
  * Nombre
  * Descripción
  * Edad

---

## 📦 Flujo de datos

1. Al iniciar la app por primera vez:
    - Se consulta el endpoint `https://jsonblob.com/api/1151549092634943488`.
    - Los datos obtenidos se almacenan localmente en SwiftData.
2. En futuros lanzamientos:
    - Se consultan los datos directamente desde SwiftData.

---

## 🚀 Tecnologías utilizadas

- Swift 5.10
- SwiftUI
- SwiftData
- Clean Architecture (Domain, Data, Presentation layers)
- URLSession
- Async/Await
- XCTest

---

## 🔬 Pruebas Unitarias

Se incluyen tests unitarios para:

* `GetDogsUseCase`
* `ListOfDogsViewModel`
* `LocalDogRepository` (Pendiente)

## 🔧 Arquitectura

El proyecto sigue los principios de **Clean Architecture**:
```bash
ListOfDogsClean/
│
├── Domain/
│   ├── Entities/
│   │   └── Dog.swift
│   │   └── DogEntity.swift
│   └── UseCases/
│       └── GetDogsUseCase.swift
│
├── Data/
│   ├── Repositories/
│   │   └── DogRepository.swift
│   └── Services/
│       └── APISource.swift
│       └── NetworkService.swift
│
├── Presentation/
│   ├── ViewModels/
│   │   └── ListOfDogsViewModel.swift
│   └── Views/
│       └── ListOfDogsView.swift
│
├── ListOfDogsCleanApp.swift
│
└── Tests/
    ├── GetDogsUseCaseTests.swift
    ├── DogListViewModelTests.swift
    └── LocalDogRepositoryTests.swift

```

## 💬 Comentarios

La elección de una arquitectura Clean nos ayuda a tener capas en el desarrollo de la App, 
lo cual facilita su testeo y a futuro asegura la escalabilidad de la misma.

Si el desarrollo fuera solamente para un demo, elegiría una arquitectura mas sencilla como MVVM o MVC, 
ya que los datos del Modelo son practicamente los mismos que se presentan en la vista principal.

Mejoras a futuro: 
  - Agregar Tests faltantes
  - Agregar vista con detalle de información
  - Utilizar Environment para la Entidad
  - Agregar Alert cuando exista un error
  - Agregar tracking para errores
