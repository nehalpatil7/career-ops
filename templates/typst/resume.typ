#import "template.typ": *

#set page(
  margin: (
    left: 6mm,
    right: 6mm,
    top: 6mm,
    bottom: 6mm
  ),
)

// Reduce font size and line spacing slightly to save space
#set text(font: "Mulish", size: 8.5pt)
#set par(leading: 0.5em)

#show: project.with(
  theme: rgb("#0F83C0"),
  name: "Aishwarya Shevkar",
  contact: (
    contact(
      text: "(872) 664-2261",
      link: "tel:872-664-2261"
    ),
    contact(
      text: "ashshevkar@gmail.com",
      link: "mailto:ashshevkar@gmail.com"
    ),
    contact(
      text: "LinkedIn://aish06",
      link: "https://www.linkedin.com/in/aish06/"
    ),
    contact(
      text: "GitHub://ashevkar",
      link: "https://github.com/ashevkar"
    ),
  ),
  main: (
    section(
      title: "Experience",
      content: (
        subSection(
          title: "DocEnsure",
          titleEnd: "",
          subTitle: "Full-Stack Developer",
          subTitleEnd: "(Feb 2026 – Present)",
          content: list(
            [Built an *AI-powered document fraud detection platform* performing *144+ forensic checks*, reducing manual review time by ~70% to under 2 minutes.],
            [Developed *React/Next.js dashboards* and *Node.js/Express REST APIs* handling *500+ daily uploads* with *99.5% uptime*.],
            [Created *Python/FastAPI microservices* for PDF forensics, font analysis, and salary validation, improving detection accuracy by *30%*.],
            [Designed *modular multi-industry pipelines* (HR, Fintech, Banking, Insurance), reducing new document onboarding time by *40%*.],
            [Implemented an *end-to-end verdict workflow* with real-time status tracking, increasing reviewer throughput by *3×*.],
            [Integrated *asynchronous job queues and caching layers* to maintain peak-load performance with *sub-2s document analysis latency*.],
          )
        ),

        subSection(
          title: "Arizona State University",
          titleEnd: "Tempe, AZ",
          subTitle: "Software Developer",
          subTitleEnd: "(Aug 2025 – Present)",
          content: list(
            [Architected a research collaboration platform using *TypeScript, React, and Node.js*, supporting *100+ concurrent multi-role users* with high reliability.],
            [Built *semantic search and recommendation system* using *Pinecone vector database and custom embeddings*, enabling context-aware retrieval across thousands of records.],
            [Optimized *AWS Lambda serverless APIs* across *5+ production services*, scaling the platform to handle *40% higher concurrency*.],
            [Implemented *CI/CD pipelines* using *Vercel and AWS CloudFormation*, reducing deployment errors and accelerating release cycles.],
            [Led *requirements gathering, feature design, and prototyping* to align AI capabilities with real researcher workflows.],
            [Drove *cross-functional collaboration* across engineering, QA, and product teams, ensuring platform stability and strategic alignment.],
          )
        ),

        subSection(
          title: "Anikaay Integration",
          titleEnd: "Pune, India",
          subTitle: "Software Developer",
          subTitleEnd: "(Mar 2022 – Jun 2023)",
          content: list(
            [Led *microservices migration* serving *2M users on AWS*, reducing load times by *40%* and improving scalability and uptime.],
            [Designed *RESTful APIs using Node.js and React*, improving data throughput by *25%* and sustaining *95% customer satisfaction*.],
            [Implemented *Docker-based CI/CD pipelines*, cutting deployment time by *30%* and improving release reliability across *10+ services*.],
            [Resolved legacy architecture bottlenecks through targeted refactoring, achieving *99.9% system availability* under production load.],
            [Mentored *4 junior engineers* on coding standards and code reviews, reducing production incidents by *20%* over two quarters.],
            [Partnered with PMs to deliver enterprise features on schedule, achieving *100% quarterly roadmap completion* across all sprints.],
          )
        ),

        subSection(
          title: "GlobalStep",
          titleEnd: "Pune, India",
          subTitle: "Software Developer",
          subTitleEnd: "(Aug 2020 – Mar 2022)",
          content: list(
            [Built a *React/Redux customer portal from scratch*, shipping *4 major feature releases* and driving strong user adoption within the first year.],
            [Integrated secure *REST APIs and payment gateways*, enabling *1,000+ monthly transactions* with high reliability and production stability.],
            [Optimized *PostgreSQL schema design and query performance*, reducing latency to &lt;200ms for high-traffic endpoints.],
            [Standardized *Swagger API documentation* and *Git workflows (Bitbucket)*, reducing developer onboarding time to *3 days*.],
            [Improved system reliability by resolving *25+ defects per sprint* through *JUnit testing* and preventing critical production regressions.],
            [Handled *40+ Tier-3 production issues per cycle* while maintaining strict *SLA compliance* and high system availability.],
          )
        ),
      ),
    ),

    section(
      title: "Education",
      content: (
        subSection(
          title: "Illinois Institute of Technology",
          titleEnd: "Chicago, IL",
          subTitle: "M.S. Information Technology",
          subTitleEnd: "(May 2025)"
        ),
        subSection(
          title: "University of Pune",
          titleEnd: "Pune, India",
          subTitle: "B.E. Information Technology",
          subTitleEnd: "(June 2020)"
        )
      ),
    ),

    section(
      title: "Projects",
      content: (
        subSection(
          title: "Tracer Code Copilot",
          content: list(
            [Developed a backend system for *AI-powered code refactoring*, implementing secure API endpoints and efficient data processing pipelines.],
            [Designed scalable architecture supporting concurrent users while maintaining *sub-100ms response times* for critical operations.]
          )
        ),
        subSection(
          title: "Ring Atelier",
          content: list(
            [Built a secure global payment system with gateway fallback, reducing cart abandonment by 25%.],
            [Implemented real-time monitoring with Kafka/PostgreSQL, cutting support tickets by 40% and improving fraud detection.]
          )
        )
      )
    ),

    section(
      title: "Skills & Certifications",
      content: (
        subSection(
          title: "Technical Skills",
          content: [
            *Languages & Frontend:* Java, JavaScript, TypeScript, React, Next.js, Angular, Vue.js, Redux, HTML5, CSS3, TanStack Query \
            *Backend & Databases:* Node.js, Express.js, Spring Boot, FastAPI, PostgreSQL, MySQL, MongoDB, Pinecone, Redis \
            *Cloud, DevOps & Testing:* Azure, GCP, Docker, Kubernetes, AWS Lambda, CloudFormation, Jenkins, CI/CD, JUnit, Cypress \
            *AI/ML & Concepts:* OpenAI API, LLMs, TensorFlow, Prompt Engineering, REST APIs \
            *Testing:* JUnit, Mockito, Cypress, Selenium, Unit Testing, Integration Testing, API Testing \
            *Tools & Concepts:* Git, Jira, Postman, Kibana, Firebase, Agile/Scrum, System Design, Distributed Systems, Observability \
          ]
        ),

        subSection(
          title: "Certifications",
          content: [
            Hash Code 2022 • Kickstart 2021 • Oracle Cloud Foundations • Salesforce AI Associate • Salesforce AI Specialist • Google AI
          ]
        )
      )
    )
  ),
  sidebar: (),
)