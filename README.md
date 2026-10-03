# MentorOS 🚀

> **AI-Powered Personalized Mentorship & Growth Operating System**

[![Stack](https://img.shields.io/badge/Tech_Stack-Flutter_%7C_Serverpod_4_%7C_PostgreSQL-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Status](https://img.shields.io/badge/Status-In_Development-orange?style=for-the-badge)](https://github.com/)

MentorOS is an AI-powered personalized mentorship and growth platform designed to help individuals clarify their goals, understand their skill gaps, build structured growth paths, and receive targeted, continuous mentorship aligned with their evolving aspirations.

---

## 📌 Overview

MentorOS is **not** simply a marketplace directory for matching students with mentors. While mentor matching is a component of the platform, the central focus of MentorOS is creating an end-to-end **personalized mentorship operating system**.

Rather than searching through unstructured mentor lists, a user starts by defining their vision and goals. MentorOS uses AI intelligence to unpack those goals into actionable growth paths, identify specific knowledge and skill gaps, determine what kind of guidance is needed, match with suitable domain experts, assist in session preparation, and track progress over time.

---

## 💡 The Problem

* **Unclear & Unstructured Goals:** Learners often have ambitious career or skill goals but struggle to break them down into concrete, achievable milestones.
* **Lack of Contextual Guidance:** Generic advice or self-directed learning paths frequently fail to address individual skill gaps and context.
* **Fragmented Growth Journey:** Learning materials, mentorship sessions, and progress tracking are isolated across multiple disconnected tools.
* **Unfocused Mentorship Sessions:** Mentorship often happens without clear agendas, prior skill context, or pre-session preparation, leading to low ROI for both mentors and mentees.
* **Lack of Continuous Alignment:** Traditional mentorship ends after individual meetings without ongoing tracking to ensure mentorship evolves as the learner grows.

---

## 🎯 Our Approach

MentorOS treats mentorship as an integrated, goal-driven operating system structured around a continuous growth lifecycle:

```text
┌──────────┐     ┌───────────┐     ┌──────────────────┐     ┌──────────────────────────┐     ┌────────────┐     ┌──────────┐     ┌──────────────────────┐
│  PERSON  │ ──► │   GOALS   │ ──► │ AI UNDERSTANDING │ ──► │ PERSONALIZED GROWTH PATH │ ──► │ MENTORSHIP │ ──► │ PROGRESS │ ──► │ CONTINUOUS ALIGNMENT │
└──────────┘     └───────────┘     └──────────────────┘     └──────────────────────────┘     └────────────┘     └──────────┘     └──────────────────────┘
```

1. **Person & Goals:** The user defines their current position, personal goals, and professional aspirations.
2. **AI Understanding:** AI analyzes user input to decompose complex objectives, extract core competencies, and identify skill gaps.
3. **Personalized Growth Path:** A tailored roadmap with structured milestones is generated to guide the user's journey.
4. **Mentorship:** When human expertise is needed, the system connects the user with mentors whose specific expertise aligns with current milestones.
5. **Progress & Continuous Alignment:** Every mentorship interaction feeds back into the growth path, continuously updating milestones and realigning guidance as goals evolve.

---

## ✨ Core Capabilities

| Capability | Description | Status |
| :--- | :--- | :--- |
| **AI Goal Understanding** | AI-driven breakdown of user aspirations into structured objectives and competency taxonomies. | ⏳ Planned |
| **Personalized Growth Paths** | Dynamic roadmaps and actionable milestone generation tailored to individual goals. | ⏳ Planned |
| **Skill & Gap Analysis** | Automated assessment of current user skills versus target goal requirements to surface specific guidance needs. | ⏳ Planned |
| **Mentor Discovery & Matching** | Contextual matching pairing mentees with relevant domain experts based on active milestone needs. | ⏳ Planned |
| **Personalized Mentorship** | Guided framework for structured mentor-mentee interactions aligned with active growth goals. | ⏳ Planned |
| **Session Preparation** | AI assistance for generating tailored meeting agendas, discussion points, and targeted questions. | ⏳ Planned |
| **Progress Tracking** | Milestone tracking and progress logging over time across the mentorship lifecycle. | ⏳ Planned |
| **Continuous Goal Alignment** | Dynamic adjustments to growth paths and mentorship recommendations as learner goals evolve. | ⏳ Planned |

---

## 🤖 How AI Is Used

MentorOS integrates Large Language Model (LLM) intelligence at key stages of the mentorship and growth journey:

* **Goal Structuring & Decomposition:** Converting open-ended user statements into structured, multi-stage goals and milestone frameworks.
* **Skill Gap Analysis:** Evaluating user profiles against target skill requirements to highlight precise areas where mentorship is needed.
* **Match Rationale Generation:** Synthesizing mentee needs and mentor profiles to provide clear explanation for why a mentor connection is recommended.
* **Session Preparation Assistance:** Suggesting focused agendas and questions prior to mentorship sessions based on upcoming growth milestones.
* **Adaptive Alignment:** Re-evaluating growth progress over time to suggest path updates or shifts in mentorship focus.

---

## 🏗️ High-Level Architecture

```text
Flutter App (iOS / Android / Web / Desktop)
                   │
                   ▼
            Serverpod Client
                   │
                   ▼
          Serverpod 4 Backend
┌──────────────────────────────────────────┐
│  ├── Serverpod Authentication            │
│  ├── API / Serverpod Endpoints           │
│  ├── Growth & Personalization Logic      │
│  ├── AI / LLM Service Integration Layer  │
│  └── PostgreSQL Database                 │
└──────────────────────────────────────────┘
```

---

## 🛠️ Technology Stack

| Layer | Technology | Description |
| :--- | :--- | :--- |
| **Frontend** | [Flutter](https://flutter.dev) + [Dart](https://dart.dev) | Cross-platform UI application |
| **Frontend Dev Tool** | **Kiro** | Specialized frontend development tool for Flutter UI implementation |
| **Backend Framework** | [Serverpod 4](https://serverpod.dev) | Server-side Dart application framework |
| **Database** | [PostgreSQL](https://www.postgresql.org) | Relational database for core project entities |
| **API & Client** | Serverpod Client + Endpoints | Auto-generated, strongly typed client-server communication protocol |
| **Authentication** | Serverpod Authentication | Integrated user identity and access management |
| **AI / Intelligence** | LLM API | Goal understanding, skill extraction, personalization, and matching assistance |
| **AI-Assisted Dev Tools** | **Antigravity**, Claude / ChatGPT | Project setup, environment assistance, and development tools |
| **Deployment Target** | Serverpod Cloud | Intended cloud target for backend services |
| **Version Control** | Git + GitHub | Repository and source code management |

---

## 🚦 Current Development Status

* [x] Project Vision & Product Strategy Defined
* [x] Technology Stack Finalized (Flutter + Serverpod 4 + PostgreSQL)
* [x] Serverpod Workspace Initialized (`mentor_os_server`, `mentor_os_client`, `mentor_os_flutter`)
* [x] PostgreSQL Database Configured
* [x] Flutter Environment Setup Complete
* [ ] Flutter Frontend UI Implementation (In active development via Kiro)
* [ ] Serverpod Core Data Models & Endpoints (Under development)
* [ ] LLM AI Service Integration (Planned)
* [ ] End-to-End Client & Server Integration (Planned)

---

## 🗺️ Implementation Roadmap

### Phase 1 — Foundation & Environment Setup
* Workspace structure, Serverpod backend initialization, and Flutter environment configuration.

### Phase 2 — Core Backend & Data Models
* Definition of Serverpod protocol models (Users, Goals, Growth Paths, Mentors, Sessions) and endpoint implementation.

### Phase 3 — AI Personalization Engine
* LLM service integration for goal analysis, skill gap extraction, and contextual mentor recommendation logic.

### Phase 4 — Flutter Experience
* Full Flutter UI implementation and client integration for goal planning, growth tracking, and mentorship sessions.

### Phase 5 — Integration, Testing & Deployment
* End-to-end integration testing and backend deployment targeting Serverpod Cloud.

---

## 📂 Repository Structure

```text
Mentor-os/
├── README.md                  # Project overview and documentation
├── pubspec.yaml               # Root workspace pubspec
├── docs/                      # Project architectural documentation
│   └── architecture.md
├── mentor_os_server/          # Serverpod 4 backend project
├── mentor_os_client/          # Auto-generated Serverpod client package
└── mentor_os_flutter/         # Flutter frontend application
```

---

## 💻 Local Development

### Prerequisites
* [Dart SDK](https://dart.dev) & [Flutter SDK](https://flutter.dev)
* [Serverpod CLI](https://serverpod.dev)
* Docker & PostgreSQL (for local backend database execution)

### Backend Server (`mentor_os_server`)
To start the local Serverpod backend:
```bash
cd mentor_os_server
docker-compose up -d
serverpod start
```

### Flutter Frontend (`mentor_os_flutter`)
To run the Flutter application:
```bash
cd mentor_os_flutter
flutter run
```

---

## 📄 License & Project Info

Developed as part of the MentorOS project. All code and documentation managed via [GitHub](https://github.com/Dhanuprithika/Mentor-os).

