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
#set text(font: "Mulish", size: 9.5pt)
#set par(leading: 0.5em)

#show: project.with(
  theme: rgb("#0F83C0"),
  name: "Aishwarya Shevkar",
  contact: (
    contact(
      text: "LinkedIn://aish06",
      link: "https://www.linkedin.com/in/aish06/"
    ),
    contact(
      text: "GitHub://ashevkar",
      link: "https://github.com/ashevkar"
    ),
    contact(
      text: "(872) 664-2261",
      link: "tel:872-664-2261"
    ),
    contact(
      text: "ashshevkar@gmail.com",
      link: "mailto:ashshevkar@gmail.com"
    )
  ),
  main: (
    section(
      title: "Experience",
      content: (
        subSection(
          title: "Arizona State University",
          titleEnd: "Tempe, AZ",
          subTitle: "Software Developer",
          subTitleEnd: "(Aug 2025 – Present)",
          content: list(
            [Architected and maintained a research collaboration web platform using *TypeScript, Node.js, and React*, supporting multi-role access for 100+ concurrent users, designed to streamline grant discovery.],
            [Developed AI-driven search and recommendation features using *Pinecone vector database and custom embeddings*, enabling semantic search across thousands of research records.],
            [Optimized API performance with *AWS Lambda and serverless architecture* across 5+ production services, implementing monitoring to maintain high reliability and scale.],
            [Implemented automated CI/CD pipelines with *Vercel and AWS CloudFormation*, supporting frequent internal releases, reducing manual errors, and improving deployment efficiency.],
            [Driven cross-functional collaboration across 3 teams including development, QA, and product, shaping platform direction and scaling AI-driven solutions.]
          )
        ),
        subSection(
          title: "Anikaay Integration",
          titleEnd: "Pune, India",
          subTitle: "Software Developer",
          subTitleEnd: "(Mar 2022 – Jun 2023)",
          content: list(
            [Directed microservices migration for *2M users on AWS*, reducing load times by 40% and improving scalability and uptime.],
            [Designed RESTful APIs using *Node.js and React*, increasing data throughput by 25% and achieving 95% customer satisfaction.],
            [Implemented *Docker-based CI/CD pipelines*, cutting deployment time by 30% and improving release reliability across 10+ services.],
            [Mentored 4 junior engineers, improving code quality and reducing production issues by 20%.],
            [Led technical decisions to resolve legacy bottlenecks, ensuring scalable architecture and *99.9% system availability*.]
          )
        ),
        subSection(
          title: "GlobalStep",
          titleEnd: "Pune, India",
          subTitle: "Software Developer",
          subTitleEnd: "(Aug 2020 – Mar 2022)",
          content: list(
            [Led full-stack development of a *React and Redux-based* customer portal, launching 4 major feature releases within the first year.],
            [Integrated secure third-party RESTful APIs and payment gateways, enabling *1,000+ successful monthly transactions*.],
            [Optimized *PostgreSQL* schemas and query logic, reducing data retrieval latency to under 200ms for high-traffic endpoints.],
            [Implemented Git flow with Bitbucket, enabling seamless collaboration across 5 developers with zero major merge conflicts for 6 months.],
            [Eliminated critical defects through *JUnit testing*, resolving 25+ bugs per sprint prior to user acceptance testing.]
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
            [Designed and delivered a secure, multi-method global payment system with credit/debit card support and third-party gateway fallback logic, improving checkout success and *reducing cart abandonment by 25%*.],
            [Built real-time transaction monitoring and alerting with *Kafka and PostgreSQL*, cutting payment-related support tickets by 40% while strengthening fraud detection.]
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
            *Languages & Frontend:* Java, JavaScript, TypeScript, React, Next.js, Angular, Vue.js, Redux, HTML5, CSS3 \
            *Backend & Databases:* Node.js, Express.js, Spring Boot, FastAPI, PostgreSQL, MySQL, MongoDB, Pinecone, Redis \
            *Cloud, DevOps & Testing:* Azure, GCP, Docker, Kubernetes, AWS Lambda, CloudFormation, Jenkins, CI/CD, JUnit, Cypress \
            *AI/ML & Concepts:* OpenAI API, LLMs, TensorFlow, Prompt Engineering, Distributed Systems, REST APIs
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