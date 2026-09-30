# MentorOS Architecture & Design Specification

> **Status:** Architectural Blueprint (Pre-Implementation)

## System Overview

MentorOS connects mentees and mentors through AI-powered goal analysis. The system consists of three primary components:

1. **Flutter App Frontend (`mentor_os_flutter`):** Cross-platform user interface for mentees and mentors.
2. **Serverpod 4 Backend (`mentor_os_server`):** Server-side Dart backend handling authentication, APIs, PostgreSQL database interactions, and LLM integrations.
3. **Serverpod Client (`mentor_os_client`):** Strongly-typed client library generated automatically from Serverpod protocol models.

---

## Data Flow Architecture

```text
┌───────────────────────────┐
│     Flutter Frontend      │
│  (UI Components & State)  │
└─────────────┬─────────────┘
              │  Serverpod Client Protocols
              ▼
┌───────────────────────────┐
│    Serverpod 4 Server     │
│  ├── Auth Module          │
│  ├── Endpoints (API)      │
│  ├── AI Service (LLM API) │
│  └── Database Layer       │
└─────────────┬─────────────┘
              │  SQL / PgVector
              ▼
┌───────────────────────────┐
│    PostgreSQL Database    │
└───────────────────────────┘
```

---

## Key Subsystems (Planned)

### 1. Goal Deconstruction Engine (AI)
* Receives raw goal text from user.
* Evaluates goal using LLM API.
* Generates structured output: primary domains, skill vectors, recommended milestones, and target mentor profile attributes.

### 2. Mentor Matching Engine
* Matches user skill vector and target profile against mentor database records in PostgreSQL.
* Calculates compatibility scores and match rationales.

### 3. Mentorship Management & Sessions
* Tracks active goal progress.
* Schedules sessions and manages status updates.

---

## Deployment Target
* **Serverpod Cloud** hosting for backend endpoints & PostgreSQL database.
* Flutter client deployed to Web, Android, and iOS.
