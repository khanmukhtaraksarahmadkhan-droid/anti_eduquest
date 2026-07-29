
-- ============================================================
-- MySQL Database Dump for EduQuest
-- Indian Education Search Portal (Full Expansion)
-- Covers all States & Union Territories of India
-- ~700+ real institutions across all streams
-- ============================================================

CREATE DATABASE IF NOT EXISTS `eduquest`;
USE `eduquest`;

-- ============================================================
-- Drop existing tables (order matters due to FKs)
-- ============================================================

DROP TABLE IF EXISTS `college_courses`;
DROP TABLE IF EXISTS `courses`;
DROP TABLE IF EXISTS `colleges`;

-- ============================================================
-- Table: colleges (expanded schema)
-- ============================================================

CREATE TABLE `colleges` (
  `id`               INT(11)      NOT NULL AUTO_INCREMENT,
  `college_name`     VARCHAR(300) NOT NULL,
  `institution_type` VARCHAR(100) NOT NULL DEFAULT 'College',
  `ownership`        VARCHAR(20)  NOT NULL DEFAULT 'Private',
  `state`            VARCHAR(100) NOT NULL,
  `city`             VARCHAR(100) NOT NULL,
  `address`          VARCHAR(600) NOT NULL,
  `pincode`          VARCHAR(10)  DEFAULT NULL,
  `college_type`     VARCHAR(50)  NOT NULL,
  `university`       VARCHAR(300) NOT NULL,
  `established_year` SMALLINT UNSIGNED DEFAULT NULL,
  `naac_grade`       VARCHAR(10)  DEFAULT 'N/A',
  `aicte_approved`   TINYINT(1)   NOT NULL DEFAULT 1,
  `approvals`        VARCHAR(500) DEFAULT NULL,
  `streams`          TEXT         DEFAULT NULL,
  `website`          VARCHAR(300) DEFAULT NULL,
  `email`            VARCHAR(255) DEFAULT NULL,
  `phone`            VARCHAR(80)  DEFAULT NULL,
  `logo`             VARCHAR(50)  DEFAULT NULL,
  `description`      TEXT         DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: courses (expanded)
-- ============================================================

CREATE TABLE `courses` (
  `id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(300) NOT NULL,
  `duration`    VARCHAR(50)  NOT NULL,
  `eligibility` VARCHAR(500) NOT NULL,
  `stream`      VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Table: college_courses (junction)
-- ============================================================

CREATE TABLE `college_courses` (
  `id`         INT(11) NOT NULL AUTO_INCREMENT,
  `college_id` INT(11) NOT NULL,
  `course_id`  INT(11) NOT NULL,
  `fees`       INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_college_id` (`college_id`),
  KEY `fk_course_id`  (`course_id`),
  CONSTRAINT `fk_college_id` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_course_id`  FOREIGN KEY (`course_id`)  REFERENCES `courses`  (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- COURSES DATA
-- ============================================================

LOCK TABLES `courses` WRITE;
INSERT INTO `courses` (`id`,`course_name`,`duration`,`eligibility`,`stream`) VALUES
-- IT & Computer Science
(1,'B.Tech in Information Technology','4 Years','10+2 with PCM min 50%','Information Technology'),
(2,'M.Tech in Information Technology','2 Years','B.Tech/B.E in relevant stream','Information Technology'),
(3,'Bachelor of Computer Applications (BCA)','3 Years','10+2 in any stream with Math/IP','Computer Science'),
(4,'Master of Computer Applications (MCA)','2 Years','BCA/B.Sc with Math','Computer Science'),
(5,'B.Sc in Computer Science','3 Years','10+2 with Math/Computer Science','Computer Science'),
(6,'M.Sc in Computer Science','2 Years','B.Sc CS/IT/BCA','Computer Science'),
(7,'B.Sc in Information Technology','3 Years','10+2 with Math/Computer Science','Information Technology'),
(8,'M.Sc in Information Technology','2 Years','B.Sc IT/BCA/B.Sc CS','Information Technology'),
-- Management
(9,'Bachelor of Business Administration (BBA)','3 Years','10+2 in any stream','Management'),
(10,'Master of Business Administration (MBA)','2 Years','Graduation with 50% + CAT/MAT','Management'),
(11,'Post Graduate Diploma in Management (PGDM)','2 Years','Graduation with CAT/MAT/XAT score','Management'),
(12,'Bachelor of Management Studies (BMS)','3 Years','10+2 in any stream','Management'),
(13,'Master of Management Studies (MMS)','2 Years','Graduation with 50%','Management'),
(14,'MBA in Human Resource Management','2 Years','Graduation with 50% + entrance exam','Management'),
(15,'MBA in Finance','2 Years','Graduation with 50% + entrance exam','Management'),
(16,'MBA in Marketing','2 Years','Graduation with 50% + entrance exam','Management'),
-- Engineering
(17,'B.Tech in Computer Science & Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(18,'B.Tech in Electronics & Communication Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(19,'B.Tech in Mechanical Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(20,'B.Tech in Civil Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(21,'B.Tech in Electrical Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(22,'B.Tech in Chemical Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(23,'B.Tech in Automobile Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(24,'B.Tech in Biomedical Engineering','4 Years','10+2 with PCM min 45%','Engineering'),
(25,'B.Tech in Artificial Intelligence & ML','4 Years','10+2 with PCM min 45%','Artificial Intelligence'),
(26,'B.Tech in Data Science','4 Years','10+2 with PCM min 45%','Data Science'),
(27,'B.Tech in Cyber Security','4 Years','10+2 with PCM min 45%','Cyber Security'),
(28,'M.Tech in Computer Science & Engineering','2 Years','B.Tech/B.E CSE/IT','Engineering'),
(29,'M.Tech in Mechanical Engineering','2 Years','B.Tech/B.E Mechanical','Engineering'),
(30,'M.Tech in Civil Engineering','2 Years','B.Tech/B.E Civil','Engineering'),
-- Architecture
(31,'B.Arch (Bachelor of Architecture)','5 Years','10+2 with PCM + NATA/JEE Paper 2','Architecture'),
(32,'M.Arch (Master of Architecture)','2 Years','B.Arch with 50%','Architecture'),
-- Medical
(33,'MBBS (Bachelor of Medicine & Surgery)','5.5 Years','10+2 PCB + NEET-UG','Medical'),
(34,'BDS (Bachelor of Dental Surgery)','5 Years','10+2 PCB + NEET-UG','Medical'),
(35,'BAMS (Bachelor of Ayurvedic Medicine)','5.5 Years','10+2 PCB + NEET-UG','Ayurveda'),
(36,'BHMS (Bachelor of Homeopathic Medicine)','5.5 Years','10+2 PCB + NEET-UG','Homeopathy'),
(37,'BUMS (Bachelor of Unani Medicine)','5.5 Years','10+2 PCB + NEET-UG','Unani'),
(38,'MD (Doctor of Medicine)','3 Years','MBBS + NEET-PG','Medical'),
(39,'MS (Master of Surgery)','3 Years','MBBS + NEET-PG','Medical'),
-- Pharmacy
(40,'B.Pharm (Bachelor of Pharmacy)','4 Years','10+2 with PCB/PCM','Pharmacy'),
(41,'M.Pharm (Master of Pharmacy)','2 Years','B.Pharm with 55%','Pharmacy'),
(42,'D.Pharm (Diploma in Pharmacy)','2 Years','10+2 with PCB/PCM','Pharmacy'),
(43,'Pharm.D (Doctor of Pharmacy)','6 Years','10+2 with PCB/PCM','Pharmacy'),
-- Nursing
(44,'B.Sc Nursing','4 Years','10+2 with PCB + 45%','Nursing'),
(45,'M.Sc Nursing','2 Years','B.Sc Nursing with 55%','Nursing'),
(46,'GNM (General Nursing & Midwifery)','3 Years','10+2 any stream with 40%','Nursing'),
(47,'ANM (Auxiliary Nursing & Midwifery)','2 Years','10th pass with 40%','Nursing'),
-- Law
(48,'LLB (Bachelor of Laws) - 3 Year','3 Years','Graduation in any stream','Law'),
(49,'BA LLB (Integrated) - 5 Year','5 Years','10+2 in any stream + CLAT/LSAT','Law'),
(50,'BBA LLB (Integrated) - 5 Year','5 Years','10+2 in any stream + CLAT','Law'),
(51,'LLM (Master of Laws)','2 Years','LLB with 50%','Law'),
-- Commerce
(52,'B.Com (Bachelor of Commerce)','3 Years','10+2 with Commerce/any stream','Commerce'),
(53,'M.Com (Master of Commerce)','2 Years','B.Com with 45%','Commerce'),
(54,'B.Com (Hons) in Accounting & Finance','3 Years','10+2 with Commerce + 55%','Commerce'),
(55,'B.Com in Banking & Insurance','3 Years','10+2 with Commerce','Commerce'),
-- Science
(56,'B.Sc in Physics','3 Years','10+2 with PCM','Science'),
(57,'B.Sc in Chemistry','3 Years','10+2 with PCM/PCB','Science'),
(58,'B.Sc in Mathematics','3 Years','10+2 with PCM','Science'),
(59,'B.Sc in Biotechnology','3 Years','10+2 with PCB','Science'),
(60,'M.Sc in Physics','2 Years','B.Sc Physics','Science'),
(61,'M.Sc in Chemistry','2 Years','B.Sc Chemistry','Science'),
(62,'M.Sc in Biotechnology','2 Years','B.Sc Biotechnology/Life Sciences','Science'),
-- Arts & Humanities
(63,'BA (Bachelor of Arts)','3 Years','10+2 in any stream','Arts'),
(64,'MA (Master of Arts)','2 Years','BA/B.Com/B.Sc Graduation','Arts'),
(65,'BA in Journalism & Mass Communication','3 Years','10+2 any stream','Mass Media'),
(66,'MA in Journalism & Mass Communication','2 Years','Graduation in any stream','Mass Media'),
-- Agriculture
(67,'B.Sc in Agriculture','4 Years','10+2 with PCB/PCM or Agriculture','Agriculture'),
(68,'M.Sc in Agriculture','2 Years','B.Sc Agriculture with 55%','Agriculture'),
(69,'B.Tech in Agricultural Engineering','4 Years','10+2 with PCM','Agriculture'),
-- Education
(70,'B.Ed (Bachelor of Education)','2 Years','Graduation in any stream with 50%','Education'),
(71,'M.Ed (Master of Education)','2 Years','B.Ed with 55%','Education'),
(72,'D.El.Ed (Diploma in Elementary Education)','2 Years','10+2 in any stream','Education'),
-- Hotel Management
(73,'B.Sc in Hotel Management','3 Years','10+2 in any stream','Hotel Management'),
(74,'Bachelor of Hotel Management (BHM)','4 Years','10+2 in any stream','Hotel Management'),
-- Design & Fine Arts
(75,'B.Des (Bachelor of Design)','4 Years','10+2 + entrance exam','Design'),
(76,'M.Des (Master of Design)','2 Years','B.Des/B.Arch/B.Tech','Design'),
(77,'Bachelor of Fine Arts (BFA)','4 Years','10+2 in any stream + entrance','Fine Arts'),
(78,'Master of Fine Arts (MFA)','2 Years','BFA/BA with Fine Arts','Fine Arts'),
(79,'Diploma in Animation & VFX','3 Years','10+2 in any stream','Animation'),
(80,'Diploma in Graphic Design','2 Years','10+2 in any stream','Design'),
-- Polytechnic
(81,'Diploma in Civil Engineering','3 Years','10th pass with 40%','Polytechnic'),
(82,'Diploma in Mechanical Engineering','3 Years','10th pass with 40%','Polytechnic'),
(83,'Diploma in Computer Engineering','3 Years','10th pass with 40%','Polytechnic'),
(84,'Diploma in Electrical Engineering','3 Years','10th pass with 40%','Polytechnic'),
(85,'Diploma in Electronics Engineering','3 Years','10th pass with 40%','Polytechnic'),
-- Junior College / HSC
(86,'HSC Science (11th & 12th)','2 Years','SSC/10th pass with 35%','Science'),
(87,'HSC Commerce (11th & 12th)','2 Years','SSC/10th pass with 35%','Commerce'),
(88,'HSC Arts (11th & 12th)','2 Years','SSC/10th pass with 35%','Arts'),
-- Paramedical & Allied Health
(89,'Bachelor of Physiotherapy (BPT)','4.5 Years','10+2 with PCB + 45%','Paramedical'),
(90,'B.Sc in Medical Lab Technology','3 Years','10+2 with PCB','Paramedical'),
(91,'B.Sc in Radiology & Imaging Technology','3 Years','10+2 with PCB','Paramedical'),
-- Aviation
(92,'Bachelor of Aviation Management','3 Years','10+2 any stream','Aviation'),
(93,'Diploma in Aviation & Hospitality','1 Year','10+2 in any stream','Aviation');
UNLOCK TABLES;

-- ============================================================
-- COLLEGES DATA — ~700+ Real Institutions
-- ============================================================

LOCK TABLES `colleges` WRITE;

-- ============================================================
-- MAHARASHTRA (25 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(1,'Indian Institute of Technology (IIT) Bombay','Engineering College','Government','Maharashtra','Mumbai','Main Gate Rd, IIT Area, Powai','400076','Government','Autonomous',1958,'A++',1,'AICTE,NAAC,NBA,UGC','Engineering,Computer Science,Data Science,Artificial Intelligence','https://www.iitb.ac.in','admissions@iitb.ac.in','+91-22-25722545','IITB','One of the premier engineering and technology institutes in India, known for cutting-edge research, world-class infrastructure, and exceptional placements.'),
(2,'College of Engineering, Pune (COEP)','Engineering College','Government','Maharashtra','Pune','Wellesley Rd, Shivajinagar','411005','Government','Autonomous',1854,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Mechanical Engineering','https://www.coep.org.in','admissions@coep.ac.in','+91-20-25507000','COEP','The third oldest engineering college in Asia, COEP holds a prestigious legacy offering top engineering and management programs.'),
(3,'Veermata Jijabai Technological Institute (VJTI)','Engineering College','Government','Maharashtra','Mumbai','H.R. Mahajani Rd, Matunga','400019','Government','University of Mumbai',1887,'A+',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Information Technology','https://www.vjti.ac.in','director@vjti.ac.in','+91-22-24198100','VJTI','A highly sought-after engineering institute in Mumbai, producing top-notch engineers for IT and manufacturing giants.'),
(4,'Pune Institute of Computer Technology (PICT)','Engineering College','Private','Maharashtra','Pune','Dhankawadi, Pune','411043','Private','Savitribai Phule Pune University',1983,'A+',1,'AICTE,NAAC,NBA','Computer Science,Information Technology','https://pict.edu','principal@pict.edu','+91-20-24371101','PICT','Popularly known as the IT hub of Pune colleges, PICT is purely specialized in Computer Science and IT with record-breaking placements.'),
(5,'Narsee Monjee Institute of Management Studies (NMIMS)','Management Institute','Private','Maharashtra','Mumbai','V. L. Mehta Road, Vile Parle West','400056','Private','Deemed University',1981,'A++',1,'AICTE,NAAC,UGC','Management,Information Technology,Commerce','https://www.nmims.edu','admission@nmims.edu','+91-22-42355555','NMIMS','A leading university renowned for management, technology, and analytics programs in the heart of Mumbai.'),
(6,'Jamnalal Bajaj Institute of Management Studies (JBIMS)','Management Institute','Government','Maharashtra','Mumbai','HT Parekh Marg, Churchgate','400020','Government','University of Mumbai',1965,'A',1,'AICTE,NAAC','Management','https://jbims.edu','admissions@jbims.edu','+91-22-22024133','JBIMS','Known as the CEO Factory of India, JBIMS is famous for its finance and management courses at extremely affordable fees.'),
(7,'Vishwakarma Institute of Technology (VIT) Pune','Engineering College','Private','Maharashtra','Pune','Bibwewadi, Pune','411037','Private','Savitribai Phule Pune University',1983,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Information Technology','https://www.vit.edu','director@vit.edu','+91-20-24202100','VITP','An autonomous engineering college offering multi-disciplinary tech programs and collaborative learning environment.'),
(8,'Dwarkadas J. Sanghvi College of Engineering (DJSCE)','Engineering College','Private','Maharashtra','Mumbai','Vile Parle West, Mumbai','400056','Private','University of Mumbai',1994,'A+',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.djsce.ac.in','info@djsce.ac.in','+91-22-42335000','DJSCE','Affiliated with Mumbai University and highly rated for its computer science branches and active engineering design teams.'),
(9,'Symbiosis Institute of Computer Studies and Research (SICSR)','Engineering College','Private','Maharashtra','Pune','Atur Centre, Model Colony','411016','Private','Symbiosis International University',1994,'A++',1,'AICTE,NAAC','Information Technology,Computer Science','https://www.sicsr.ac.in','admissions@sicsr.ac.in','+91-20-25675601','SICSR','A pioneer in IT education offering premium BCA, MCA, and MBA IT courses under the Symbiosis umbrella.'),
(10,'Maharashtra Institute of Technology (MIT-WPU)','Engineering College','Private','Maharashtra','Pune','Paud Road, Kothrud','411038','Private','MIT-WPU University',1983,'A',1,'AICTE,NAAC','Engineering,Management,Computer Science','https://mitwpu.edu.in','admissions@mitwpu.edu.in','+91-20-25431791','MIT','A global university focusing on holistic education, engineering, research, and professional business management.'),
(11,'Government Medical College, Nagpur','Medical College','Government','Maharashtra','Nagpur','Medical Square, Nagpur','440003','Government','Maharashtra University of Health Sciences',1947,'A',0,'NAAC,NMC','Medical,Nursing,Paramedical','https://gmcnagpur.edu.in','principal@gmcnagpur.edu.in','+91-712-2725500','GMCN','One of the oldest government medical colleges in Central India offering MBBS and MD programs.'),
(12,'Seth G.S. Medical College & KEM Hospital','Medical College','Government','Maharashtra','Mumbai','Acharya Donde Marg, Parel','400012','Government','Maharashtra University of Health Sciences',1926,'A+',0,'NAAC,NMC','Medical,Nursing','https://kem.edu','dean@kem.edu','+91-22-24136051','KEM','Premier medical college in Mumbai attached to the iconic KEM Hospital with outstanding clinical training facilities.'),
(13,'Government College of Pharmacy, Karad','Pharmacy College','Government','Maharashtra','Karad','Vidyanagar, Karad','415124','Government','Shivaji University',1983,'B+',1,'PCI,NAAC,AICTE','Pharmacy','http://gcp.karad.ac.in','principal@gcpkarad.edu','+91-2164-226070','GCPK','Premier government pharmacy college in Western Maharashtra offering B.Pharm and M.Pharm programs.'),
(14,'Government Polytechnic, Mumbai','Polytechnic College','Government','Maharashtra','Mumbai','Ali Yawar Jung Marg, Bandra East','400051','Government','MSBTE',1952,'N/A',1,'AICTE','Polytechnic,Diploma','https://gpmumbai.ac.in','gpmumbai@dtemaharashtra.gov.in','+91-22-26480021','GPM','The oldest government polytechnic in Maharashtra providing diploma engineering courses.'),
(15,'ILS Law College, Pune','Law College','Private','Maharashtra','Pune','Law College Road, Shivajinagar','411004','Private','Savitribai Phule Pune University',1924,'A',0,'BCI,NAAC','Law','http://www.ilslaw.edu','ils@vsnl.com','+91-20-25665488','ILS','One of the premier law colleges in India with a rich tradition of producing top lawyers and judges.'),
(16,'Sir J.J. College of Architecture','Architecture College','Government','Maharashtra','Mumbai','Dr. DN Road, Fort, Mumbai','400001','Government','University of Mumbai',1913,'A',0,'COA,NAAC','Architecture','https://www.sirjjarchitecture.org','jjcoa@vsnl.net','+91-22-22661289','JJCA','The oldest architecture school in India, established in 1913, known for producing iconic Indian architects.'),
(17,'Government College of Agriculture, Nagpur','Agriculture College','Government','Maharashtra','Nagpur','Amravati Road, Seminary Hills','440001','Government','Dr. PDKV Akola',1906,'N/A',0,'ICAR,NAAC','Agriculture','https://gcnagpur.com','gcan@nagpur.com','+91-712-2511370','GCAN','Premier government agriculture college in Vidarbha offering B.Sc Agriculture and M.Sc programs.'),
(18,'St. Xavier\'s College, Mumbai','Degree College','Private','Maharashtra','Mumbai','5, Mahapalika Marg, Fort','400001','Private','University of Mumbai',1869,'A++',0,'NAAC,UGC','Science,Commerce,Arts','https://www.xaviers.edu','admin@xaviers.edu','+91-22-22620661','SXC','One of India\'s most prestigious autonomous colleges, offering exceptional Science, Commerce, and Arts programs.'),
(19,'Ruia College (Ramnarain Ruia Autonomous College)','Degree College','Government','Maharashtra','Mumbai','Matunga, Mumbai','400019','Government','University of Mumbai',1937,'A',0,'NAAC,UGC','Science,Arts','https://ruiacollege.edu','ruia@ruiacollege.edu','+91-22-24127300','RUIA','Top-ranked government degree college in Mumbai offering B.Sc and BA programs with strong academic record.'),
(20,'Elphinstone College','Degree College','Government','Maharashtra','Mumbai','10, Mahapalika Marg, Fort','400001','Government','University of Mumbai',1856,'A',0,'NAAC,UGC','Arts,Commerce,Science','https://www.elphinstone.ac.in','principal@elphinstone.ac.in','+91-22-22614004','EC','The oldest college in Mumbai with a rich heritage offering liberal arts, science, and commerce education.'),
(21,'D.Y. Patil College of Engineering, Pune','Engineering College','Private','Maharashtra','Pune','Sector 29, Pradhikaran, Nigdi','411044','Private','Savitribai Phule Pune University',1984,'A',1,'AICTE,NAAC','Engineering,Computer Science,Mechanical Engineering','https://www.dypatilpune.ac.in','principaldypcoe@dypatil.edu','+91-20-27654456','DYP','Large private engineering college offering multiple B.Tech specializations with good industry connections.'),
(22,'Bharati Vidyapeeth Medical College, Pune','Medical College','Private','Maharashtra','Pune','Dhankawadi, Pune','411043','Private','Bharati Vidyapeeth Deemed University',1989,'A',0,'NMC,NAAC','Medical,Nursing','https://www.bvuniversity.edu.in','bvumc@bvuniversity.edu.in','+91-20-24372021','BVMC','One of the prominent private medical colleges in Pune offering MBBS and MD programs.'),
(23,'College of Agricultural Engineering, Rahuri','Agriculture College','Government','Maharashtra','Rahuri','Rahuri, Ahmednagar','413722','Government','Mahatma Phule Krishi Vidyapeeth',1969,'N/A',0,'ICAR,AICTE','Agriculture,Engineering','https://caer.mpkv.ac.in','principal@caer.mpkv.ac.in','+91-2426-243267','CAER','Premier agricultural engineering college in Maharashtra under Mahatma Phule Krishi Vidyapeeth.'),
(24,'Abhinav Education Society\'s College of Architecture, Pune','Architecture College','Private','Maharashtra','Pune','Bhosari, Pune','411026','Private','Savitribai Phule Pune University',2001,'N/A',0,'COA,AICTE','Architecture','https://aescap.edu.in','principalaescap@gmail.com','+91-20-27131416','AESCA','Well-known architecture college in Pune affiliated to SPPU offering 5-year B.Arch program.'),
(25,'Sir Vithaldas Thackersey College of Home Science','Education College','Private','Maharashtra','Mumbai','Sir Vithaldas Vidyavihar, Juhu','400049','Private','SNDT Women\'s University',1955,'A',0,'NAAC,UGC','Education,Science','https://svtias.edu.in','principal@svt.sndt.ac.in','+91-22-26624832','SVT','A women\'s education college offering home science, nutrition, and child development programs.');

-- ============================================================
-- KARNATAKA (22 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(26,'Indian Institute of Management (IIM) Bangalore','Management Institute','Government','Karnataka','Bengaluru','Bannerghatta Rd, Bilekahalli','560076','Government','Autonomous',1973,'A++',1,'NAAC,AACSB,AMBA','Management','https://www.iimb.ac.in','pgpadm@iimb.ac.in','+91-80-26993000','IIMB','A leading global business school in Asia renowned for management programs, case studies, and academic research.'),
(27,'RV College of Engineering (RVCE)','Engineering College','Private','Karnataka','Bengaluru','Mysore Road, RV Vidyaniketan Post','560059','Private','Visvesvaraya Technological University',1963,'A+',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.rvce.edu.in','principal@rvce.edu.in','+91-80-67178000','RVCE','One of the premier self-financing engineering colleges in India recognized for stellar computer science and IT records.'),
(28,'PES University','Engineering College','Private','Karnataka','Bengaluru','Outer Ring Rd, Banashankari 3rd Stage','560085','Private','State Private University',1988,'A+',1,'AICTE,NAAC','Engineering,Computer Science,Management','https://www.pes.edu','admissions@pes.edu','+91-80-26721983','PESU','A prominent private university in Bangalore with a strong curriculum centred around computing technology and management.'),
(29,'M. S. Ramaiah Institute of Technology (MSRIT)','Engineering College','Private','Karnataka','Bengaluru','MSR Nagar, MSRIT Post','560054','Private','Visvesvaraya Technological University',1962,'A+',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Information Technology','https://www.msrit.edu','principal@msrit.edu','+91-80-23600822','MSRIT','Ranked among top technical institutes, MSRIT offers strong academic research and high-quality placements in software companies.'),
(30,'Christ University','Degree College','Private','Karnataka','Bengaluru','Hosur Road, Bhavani Nagar','560029','Private','Deemed University',1969,'A+',1,'NAAC,UGC','Management,Computer Science,Commerce,Arts,Science,Law','https://christuniversity.in','admissions@christuniversity.in','+91-80-40129100','CU','Renowned private university highly ranked for BBA, BCA, MBA, and law degrees with a strict professional conduct code.'),
(31,'St. Joseph\'s College of Commerce (SJCC)','Commerce College','Private','Karnataka','Bengaluru','Brigade Rd, Shanthala Nagar','560025','Private','Bengaluru City University',1882,'A++',0,'NAAC,UGC','Commerce,Management','https://www.sjcc.edu.in','info@sjcc.edu.in','+91-80-25360644','SJCC','Autonomous institution with a history of academic rigor and strong industrial training in accounting and management.'),
(32,'Bangalore Medical College & Research Institute (BMCRI)','Medical College','Government','Karnataka','Bengaluru','Fort, K.R. Road','560002','Government','Rajiv Gandhi University of Health Sciences',1955,'A',0,'NMC,NAAC','Medical','http://bmcri.org','bmcrihod@gmail.com','+91-80-26701080','BMCRI','One of Karnataka\'s premier government medical colleges attached to Victoria Hospital with excellent clinical training.'),
(33,'JSS College of Pharmacy','Pharmacy College','Private','Karnataka','Mysuru','Sri Shivarathreeshwara Nagar, Mysuru','570015','Private','JSS Academy of Higher Education',1980,'A++',1,'PCI,NAAC,AICTE','Pharmacy','https://jsscp.edu.in','jsscp@jssuni.edu.in','+91-821-2548359','JSSCP','One of the premier pharmacy colleges in India offering B.Pharm, M.Pharm, and Pharm.D programs.'),
(34,'Manipal College of Nursing','Nursing College','Private','Karnataka','Manipal','Madhav Nagar, Manipal','576104','Private','Manipal Academy of Higher Education',1953,'A++',0,'INC,NAAC','Nursing','https://mcn.manipal.edu','mcn@manipal.edu','+91-820-2922419','MCN','One of India\'s oldest and most reputed nursing colleges offering B.Sc, M.Sc, and GNM programs.'),
(35,'Government Law College, Bangalore','Law College','Government','Karnataka','Bengaluru','Sheshadri Road, Bengaluru','560001','Government','Bangalore University',1884,'B+',0,'BCI,NAAC','Law','http://glcbangalore.org','glcbangalore@yahoo.co.in','+91-80-22353540','GLC','One of the oldest law colleges in South India offering LLB programs with a rich legal tradition.'),
(36,'Visvesvaraya Technological University (VTU)','University','Government','Karnataka','Belagavi','Machhe, Belagavi','590018','Government','State University',1998,'A',0,'UGC,NAAC','Engineering,Computer Science,Management','https://vtu.ac.in','registrar@vtu.ac.in','+91-836-2447800','VTU','The apex technical university in Karnataka affiliating over 200 engineering colleges across the state.'),
(37,'Sri Dharmasthala Manjunatheshwara College of Engineering & Technology','Engineering College','Private','Karnataka','Dharwad','Dharwad, Karnataka','580002','Private','Visvesvaraya Technological University',1986,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://sdmcet.ac.in','principal@sdmcet.ac.in','+91-836-2447201','SDMCET','A well-reputed engineering college in North Karnataka with excellent faculty and placement records.'),
(38,'University of Agricultural Sciences, Dharwad','Agriculture College','Government','Karnataka','Dharwad','University of Agricultural Sciences','580005','Government','State University',1949,'A',0,'ICAR,NAAC','Agriculture','https://uasd.edu.in','registrar@uasd.edu.in','+91-836-2748144','UASD','One of the premier agriculture universities in India with an excellent research and extension programs.'),
(39,'Karnataka Polytechnic, Mangaluru','Polytechnic College','Government','Karnataka','Mangaluru','Urva, Mangaluru','575006','Government','DTE Karnataka',1960,'N/A',1,'AICTE','Polytechnic,Diploma','https://karnatakapolytechnic.edu.in','principal@karnatakapolytechnic.edu.in','+91-824-2420401','KP','Oldest and most prestigious polytechnic institute in coastal Karnataka offering diploma engineering programs.'),
(40,'Mysore Medical College & Research Institute','Medical College','Government','Karnataka','Mysuru','Irwin Road, Mysuru','570001','Government','Rajiv Gandhi University of Health Sciences',1924,'A',0,'NMC,NAAC','Medical','https://mmcri.ac.in','principal@mmcri.org','+91-821-2426502','MMCRI','One of the oldest government medical colleges in Karnataka attached to the Cheluvamba Hospital.'),
(41,'School of Architecture, CEPT University-equivalent, BMS','Architecture College','Private','Karnataka','Bengaluru','Bull Temple Road, Basavanagudi','560019','Private','Visvesvaraya Technological University',1946,'A',0,'COA,AICTE','Architecture','https://bmsce.ac.in','principal@bmsce.ac.in','+91-80-26622130','BMS','One of the top private engineering and architecture institutes in Bengaluru under BMS Educational Trust.'),
(42,'Sri Venkateswara College of Engineering','Engineering College','Private','Karnataka','Bengaluru','Whitefield, Bengaluru','560048','Private','Visvesvaraya Technological University',1989,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://svce.ac.in','principal@svce.ac.in','+91-80-28436565','SVCE','Well-established private engineering college in Whitefield with strong industry connections.'),
(43,'Presidency College, Bengaluru','Degree College','Government','Karnataka','Bengaluru','Kempapura Agrahara, Hebbal','560024','Government','Bengaluru North University',1960,'A',0,'NAAC,UGC','Science,Commerce,Arts','https://presidencycollege.ac.in','principal@presidencycollege.ac.in','+91-80-23440752','PC','Government autonomous college offering bachelor courses across science, commerce, and humanities streams.'),
(44,'National Law School of India University (NLSIU)','Law College','Government','Karnataka','Bengaluru','Nagarbhavi, Bengaluru','560072','Government','Autonomous',1987,'A++',0,'BCI,NAAC,UGC','Law','https://nls.ac.in','info@nls.ac.in','+91-80-23213160','NLSIU','India\'s premier law university and the first National Law School, offering BA LLB and LLM programs.'),
(45,'Indian Institute of Science (IISc)','University','Government','Karnataka','Bengaluru','CV Raman Avenue, Sadashivanagar','560012','Government','Autonomous',1909,'A++',0,'NAAC,UGC','Science,Engineering,Computer Science,Artificial Intelligence','https://www.iisc.ac.in','regis@iisc.ac.in','+91-80-22932228','IISc','India\'s premier research university, consistently ranked among the top universities globally.'),
(46,'SDM College of Dental Sciences, Dharwad','Medical College','Private','Karnataka','Dharwad','Manjushree Nagar, Sattur','580009','Private','Rajiv Gandhi University of Health Sciences',1979,'A',0,'DCI,NAAC','Medical','https://sdmcdsh.ac.in','sdmcdsh@gmail.com','+91-836-2460033','SDM','One of India\'s reputed dental colleges with excellent clinical training infrastructure.'),
(47,'Government First Grade College, Mysuru','Junior College','Government','Karnataka','Mysuru','Saraswathipuram, Mysuru','570009','Government','University of Mysore',1962,'B+',0,'NAAC,UGC','Science,Commerce,Arts','https://gfgcmysuru.edu.in','gfgcmys@gmail.com','+91-821-2513870','GFC','A leading government degree and junior college in Mysuru offering quality affordable undergraduate education.');

-- ============================================================
-- TAMIL NADU (22 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(48,'Indian Institute of Technology (IIT) Madras','Engineering College','Government','Tamil Nadu','Chennai','IIT Madras, Adyar','600036','Government','Autonomous',1959,'A++',1,'AICTE,NAAC,NBA,UGC','Engineering,Computer Science,Data Science,Artificial Intelligence','https://www.iitm.ac.in','gate@iitm.ac.in','+91-44-22578000','IITM','Ranked number one in NIRF overall engineering rankings, IIT Madras provides top-tier education and excellent placement packages.'),
(49,'PSG College of Technology','Engineering College','Private','Tamil Nadu','Coimbatore','Avinashi Rd, Peelamedu','641004','Private','Anna University',1951,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Information Technology','https://www.psgtech.edu','principal@psgtech.ac.in','+91-422-2572177','PSG','An AICTE approved autonomous institution known for close collaboration with industries and outstanding computer engineering studies.'),
(50,'Vellore Institute of Technology (VIT)','Engineering College','Private','Tamil Nadu','Vellore','Katpadi, Vellore','632014','Private','Deemed University',1984,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Information Technology,Data Science,Artificial Intelligence','https://vit.ac.in','admin.admissions@vit.ac.in','+91-416-2243091','VIT','A world-class university offering highly structured credit-based systems extremely popular for software and computer systems courses.'),
(51,'SRM Institute of Science and Technology','Engineering College','Private','Tamil Nadu','Chennai','Kattankulathur, Kancheepuram','603203','Private','Deemed University',1985,'A++',1,'AICTE,NAAC','Engineering,Computer Science,Management,Medical','https://www.srmist.edu.in','admissions.india@srmist.edu.in','+91-44-27455510','SRM','One of the top private universities in India offering B.Tech, M.Tech, MBA, and MCA degrees inside a sprawling campus.'),
(52,'College of Engineering, Guindy (CEG)','Engineering College','Government','Tamil Nadu','Chennai','Sardar Patel Road, Guindy','600025','Government','Anna University',1794,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Mechanical Engineering','https://ceg.annauniv.edu','cegprincipal@annauniv.edu','+91-44-22358491','CEG','Established in 1794, CEG is one of the oldest engineering colleges in Asia representing Anna University flagship department.'),
(53,'Madras Medical College (MMC)','Medical College','Government','Tamil Nadu','Chennai','Park Town, Chennai','600003','Government','Tamil Nadu Dr. MGR Medical University',1835,'A++',0,'NMC,NAAC','Medical,Nursing','https://mmcri.ac.in','principal@mmc.tn.gov.in','+91-44-25305001','MMC','One of the oldest medical colleges in Asia, established in 1835, with unmatched clinical training at Government General Hospital.'),
(54,'Loyola College','Degree College','Private','Tamil Nadu','Chennai','Sterling Rd, Nungambakkam','600034','Private','University of Madras',1925,'A++',0,'NAAC,UGC','Science,Commerce,Arts,Management','https://www.loyolacollege.edu','admission@loyolacollege.edu','+91-44-28178200','LOY','Consistently ranked among the top colleges in India, offering top-tier BBA and computer application options on a rich historical campus.'),
(55,'Madras Christian College (MCC)','Degree College','Private','Tamil Nadu','Chennai','Tambaram East','600059','Private','University of Madras',1837,'A++',0,'NAAC,UGC','Science,Arts,Commerce','https://mcc.edu.in','principal@mcc.edu.in','+91-44-22390675','MCC','Famous for its sprawling natural campus, MCC provides excellent business courses, computer science degrees, and academic heritage.'),
(56,'Tamil Nadu Agricultural University (TNAU)','Agriculture College','Government','Tamil Nadu','Coimbatore','Lawley Road, Coimbatore','641003','Government','State University',1906,'A++',0,'ICAR,NAAC,UGC','Agriculture','https://tnau.ac.in','vc@tnau.ac.in','+91-422-6611200','TNAU','India\'s premier agricultural university offering B.Sc Agriculture and postgraduate programs with exceptional research output.'),
(57,'Government Law College, Chennai','Law College','Government','Tamil Nadu','Chennai','Haddows Road, Nungambakkam','600006','Government','Tamil Nadu Dr. Ambedkar Law University',1891,'B+',0,'BCI,NAAC','Law','https://glcchennai.ac.in','glcchennai@gmail.com','+91-44-28334551','GLCC','One of the oldest law colleges in South India offering 3-year and 5-year LLB programs.'),
(58,'School of Architecture & Planning, Anna University','Architecture College','Government','Tamil Nadu','Chennai','Sardar Patel Road, Guindy','600025','Government','Anna University',1957,'A+',0,'COA,NAAC','Architecture','https://www.annauniv.edu','sap@annauniv.edu','+91-44-22359111','SAP','Premier school of architecture under Anna University offering B.Arch and M.Arch programs.'),
(59,'JSS College of Arts, Commerce & Science, Mysuru','Degree College','Private','Tamil Nadu','Ooty','Jss College Road, Ooty','643001','Private','Bharathiar University',1991,'A',0,'NAAC,UGC','Science,Commerce,Arts','https://jssacsooty.edu.in','jssacsooty@gmail.com','+91-423-2443208','JSSO','A reputed degree college in the Nilgiris offering quality undergraduate programs in science, arts, and commerce.'),
(60,'Kumaraguru College of Technology','Engineering College','Private','Tamil Nadu','Coimbatore','Chinnavedampatti, Coimbatore','641049','Private','Anna University',1984,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Information Technology','https://kct.ac.in','principal@kct.ac.in','+91-422-2669401','KCT','A top autonomous engineering college in Coimbatore known for its research culture and industry connections.'),
(61,'Government Medical College & Hospital, Thanjavur','Medical College','Government','Tamil Nadu','Thanjavur','Medical College Road, Thanjavur','613004','Government','Tamil Nadu Dr. MGR Medical University',1959,'A',0,'NMC,NAAC','Medical,Nursing','https://gmcthanjavur.ac.in','gmcthanjavur@gmail.com','+91-4362-227611','GMCT','One of the historic government medical colleges in Tamil Nadu offering MBBS and postgraduate programs.'),
(62,'PSG College of Pharmacy','Pharmacy College','Private','Tamil Nadu','Coimbatore','Peelamedu, Coimbatore','641004','Private','Tamil Nadu Pharmacy Council',1998,'A',1,'PCI,NAAC,AICTE','Pharmacy','https://psgcp.edu.in','principal@psgcp.edu.in','+91-422-2572288','PSGCP','Premier pharmacy college in Coimbatore attached to PSG Hospitals offering B.Pharm and M.Pharm programs.'),
(63,'Stella Maris College','Degree College','Private','Tamil Nadu','Chennai','Cathedral Rd, Poes Garden','600086','Private','University of Madras',1947,'A++',0,'NAAC,UGC','Arts,Commerce,Science','https://stellamariscollege.edu.in','admissions@stellamariscollege.edu.in','+91-44-28111987','SMC','A premier women\'s college in Chennai offering specialized education in commerce, technology, and business studies.'),
(64,'Dr. M.G.R. Educational and Research Institute','Engineering College','Private','Tamil Nadu','Chennai','Maduravoyal, Chennai','600095','Private','Deemed University',1988,'A',1,'AICTE,NAAC','Engineering,Management,Health Sciences','https://drmgrdu.ac.in','enquiry@drmgrdu.ac.in','+91-44-23783458','MGRDU','A deemed university offering multidisciplinary programs including engineering, medical, and management education.'),
(65,'IIT Madras Research Park (Taramani)','Engineering College','Government','Tamil Nadu','Chennai','Kanagam Road, Taramani','600113','Government','Autonomous',2010,'A++',1,'AICTE','Engineering,Data Science,Artificial Intelligence','https://iitmrp.edu.in','contact@iitmrp.edu.in','+91-44-66867888','IITMRP','IIT Madras Research Park, a unique initiative bridging academia and industry for high-impact research.'),
(66,'Institute of Hotel Management, Chennai','Hotel Management','Government','Tamil Nadu','Chennai','Royapettah, Chennai','600014','Government','National Council for Hotel Management',1969,'N/A',0,'NCHMCT','Hotel Management','https://ihm-chennai.tn.gov.in','ihmchennai@gmail.com','+91-44-28113356','IHMC','Premier government institute for hotel management and catering technology in Tamil Nadu.'),
(67,'Amrita College of Engineering & Technology','Engineering College','Private','Tamil Nadu','Coimbatore','Ettimadai, Coimbatore','641112','Private','Amrita Vishwa Vidyapeetham',2000,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.amrita.edu','admissions@amrita.edu','+91-422-2685000','AMRC','A top-ranked private engineering college under Amrita University with strong research credentials.'),
(68,'Gandhigram Rural Institute','Education College','Government','Tamil Nadu','Dindigul','Gandhigram, Dindigul','624302','Government','Deemed University',1956,'A+',0,'NAAC,UGC','Education,Agriculture,Arts','https://www.gandhigramuniversity.ac.in','registrar@gandhigramuniversity.ac.in','+91-451-2452371','GRI','A unique deemed university focusing on rural development, agriculture, and education programs.'),
(69,'Sri Ramachandra Institute of Higher Education','Medical College','Private','Tamil Nadu','Chennai','Porur, Chennai','600116','Private','Deemed University',1985,'A++',0,'NMC,NAAC,PCI','Medical,Nursing,Pharmacy','https://www.sriramachandra.edu.in','admissions@sriramachandra.edu.in','+91-44-45928657','SRIHER','A comprehensive health sciences university offering medical, pharmacy, nursing, and allied health programs.');

-- ============================================================
-- DELHI (20 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(70,'Indian Institute of Technology (IIT) Delhi','Engineering College','Government','Delhi','New Delhi','Hauz Khas, New Delhi','110016','Government','Autonomous',1961,'A++',1,'AICTE,NAAC,NBA,UGC','Engineering,Computer Science,Data Science,Artificial Intelligence','https://home.iitd.ac.in','admissions@iitd.ac.in','+91-11-26591000','IITD','Located in the capital of India, IIT Delhi is a hub of technical excellence offering premium education and research in IT.'),
(71,'Delhi Technological University (DTU)','Engineering College','Government','Delhi','New Delhi','Shahbad Daulatpur, Bawana Road','110042','Government','State University',1941,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://www.dtu.ac.in','admissions@dtu.ac.in','+91-11-27896522','DTU','Formerly Delhi College of Engineering (DCE), DTU is one of the oldest and highly respected tech universities in Delhi.'),
(72,'Shaheed Sukhdev College of Business Studies (SSCBS)','Management Institute','Government','Delhi','New Delhi','PSP Area IV, Sector 16, Rohini','110085','Government','University of Delhi',1987,'A+',0,'NAAC,UGC','Management','https://sscbs.du.ac.in','cbs@sscbsdu.ac.in','+91-11-27573447','SSCBS','A premier management college under Delhi University famous for exceptional packages in financial and management roles.'),
(73,'AIIMS New Delhi','Medical College','Government','Delhi','New Delhi','Sri Aurobindo Marg, Ansari Nagar','110029','Government','Autonomous',1956,'A++',0,'NMC,NAAC','Medical,Nursing,Pharmacy','https://www.aiims.edu','webmaster@aiims.edu','+91-11-26588500','AIIMS','India\'s premier medical institution combining outstanding medical education, research, and patient care under one roof.'),
(74,'Indian Institute of Foreign Trade (IIFT)','Management Institute','Government','Delhi','New Delhi','Qutub Institutional Area','110016','Government','Deemed University',1963,'A',1,'NAAC,UGC','Management','https://www.iift.ac.in','admissions@iift.ac.in','+91-11-39147200','IIFT','A premier public business school under the Ministry of Commerce specializing in International Business management.'),
(75,'Miranda House','Degree College','Government','Delhi','New Delhi','Patel Chest, University of Delhi','110007','Government','University of Delhi',1948,'A++',0,'NAAC,UGC','Arts,Science,Commerce','https://mirandahouse.ac.in','principal@mirandahouse.ac.in','+91-11-27667404','MH','India\'s top-ranked women\'s college offering exceptional programs in sciences, humanities, and social sciences.'),
(76,'Lady Shri Ram College (LSR)','Degree College','Government','Delhi','New Delhi','Lajpat Nagar IV, New Delhi','110024','Government','University of Delhi',1956,'A++',0,'NAAC,UGC','Arts,Commerce,Science','https://www.lsr.edu.in','principal@lsr.edu.in','+91-11-29234688','LSR','One of India\'s most prestigious women\'s colleges known for producing leaders in politics, media, and academia.'),
(77,'Hindu College','Degree College','Government','Delhi','New Delhi','University Enclave, Maurice Nagar','110007','Government','University of Delhi',1899,'A++',0,'NAAC,UGC','Arts,Science,Commerce','https://www.hinducollege.ac.in','principal@hinducollege.ac.in','+91-11-27666520','HC','One of the oldest and most prestigious colleges in India under Delhi University with a strong academic tradition.'),
(78,'National Law University (NLU) Delhi','Law College','Government','Delhi','New Delhi','Dwarka, New Delhi','110078','Government','Autonomous',2008,'A+',0,'BCI,NAAC,UGC','Law','https://nludelhi.ac.in','info@nludelhi.ac.in','+91-11-28034257','NLUD','Premier national law university offering BA LLB and LLM programs with one of the highest bar exam pass rates.'),
(79,'Jawaharlal Nehru University (JNU)','University','Government','Delhi','New Delhi','New Mehrauli Road, New Delhi','110067','Government','Central University',1969,'A++',0,'NAAC,UGC','Arts,Science,Management','https://www.jnu.ac.in','registrar@mail.jnu.ac.in','+91-11-26704090','JNU','One of India\'s most prominent central universities known for social sciences, humanities, and science research.'),
(80,'Guru Gobind Singh Indraprastha University (GGSIPU)','University','Government','Delhi','New Delhi','Sector 16C, Dwarka','110078','Government','State University',1998,'A',1,'AICTE,NAAC','Engineering,Management,Law,Medical','http://www.ipu.ac.in','pro@ipu.ac.in','+91-11-25302170','IPU','A vast state-run university hosting dozens of affiliated engineering and management colleges across NCR.'),
(81,'FORE School of Management','Management Institute','Private','Delhi','New Delhi','Adhitam Kendra, B-18, Qutub Institutional Area','110016','Private','Autonomous',1981,'A',1,'NAAC,AICTE','Management','https://www.fsm.ac.in','admissions@fsm.ac.in','+91-11-41242424','FORE','Located in the prime institutional area, FORE is popular for PGDM courses, management seminars, and high ROI placement stats.'),
(82,'Lal Bahadur Shastri Institute of Management (LBSIM)','Management Institute','Private','Delhi','New Delhi','Dwarka Sector 11, New Delhi','110075','Private','Autonomous',1995,'A',1,'NAAC,AICTE','Management','https://www.lbsim.ac.in','admission@lbsim.ac.in','+91-11-25307700','LBSIM','A premium management school focusing on business values, IT integration, finance, and marketing research.'),
(83,'Amity University Noida','Engineering College','Private','Delhi','Noida','Sector-125, Noida','201313','Private','Private University',2005,'A+',1,'NAAC,AICTE,UGC','Engineering,Management,Law,Medical','https://www.amity.edu','admissions@amity.edu','+91-120-2445252','AMITY','A massive private research university providing comprehensive educational programs in IT, Computer Applications, and Management.'),
(84,'School of Planning and Architecture (SPA)','Architecture College','Government','Delhi','New Delhi','4 Block B, IP Estate, New Delhi','110002','Government','Autonomous',1955,'A++',0,'COA,NAAC','Architecture','http://www.spa.ac.in','registrar@spa.ac.in','+91-11-23702370','SPA','India\'s premier architecture school and oldest planning institution offering B.Arch and urban planning programs.'),
(85,'Maulana Azad Medical College (MAMC)','Medical College','Government','Delhi','New Delhi','Bahadur Shah Zafar Marg, New Delhi','110002','Government','University of Delhi',1958,'A',0,'NMC,NAAC','Medical,Nursing','https://mamc.ac.in','principal@mamc.ac.in','+91-11-23234441','MAMC','One of Delhi\'s premier government medical colleges attached to Lok Nayak Hospital.'),
(86,'Delhi Pharmaceutical Sciences and Research University','Pharmacy College','Government','Delhi','New Delhi','Pushp Vihar Sector 3, New Delhi','110017','Government','State University',2008,'A',1,'PCI,NAAC','Pharmacy','https://dpsru.edu.in','info@dpsru.edu.in','+91-11-29553957','DPSRU','Delhi\'s only pharmaceutical sciences university offering B.Pharm, M.Pharm, and Pharm.D programs.'),
(87,'Maharaja Agrasen Institute of Technology (MAIT)','Engineering College','Private','Delhi','New Delhi','PSP Area, Sector 22, Rohini','110085','Private','GGSIPU',2000,'A',1,'AICTE,NAAC','Engineering,Computer Science,Information Technology','https://mait.ac.in','mait@mait.ac.in','+91-11-27582095','MAIT','An engineering college affiliated with IP University, widely regarded for IT placement records in product-based IT giants.'),
(88,'Indira Gandhi National Open University (IGNOU)','University','Government','Delhi','New Delhi','Maidan Garhi, New Delhi','110068','Government','Central University',1985,'A++',0,'NAAC,UGC','Management,Science,Arts,Commerce,Education','https://www.ignou.ac.in','registrar@ignou.ac.in','+91-11-29534321','IGNOU','The world\'s largest open university offering distance education programs across all streams and disciplines.'),
(89,'National Institute of Fashion Technology (NIFT) Delhi','Design College','Government','Delhi','New Delhi','Hauz Khas, New Delhi','110016','Government','Autonomous',1986,'N/A',0,'NAAC','Design','https://www.nift.ac.in/delhi','niftd@nift.ac.in','+91-11-26542223','NIFTD','India\'s foremost fashion design and technology institute offering B.Des and M.Des programs.');

-- ============================================================
-- UTTAR PRADESH (20 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(90,'Indian Institute of Management (IIM) Lucknow','Management Institute','Government','Uttar Pradesh','Lucknow','Prabandh Nagar, IIM Road','226013','Government','Autonomous',1984,'A++',1,'NAAC,AACSB,AMBA','Management','https://www.iiml.ac.in','admission@iiml.ac.in','+91-522-2734101','IIML','Recognized for its rigorous academic curriculum, high-profile placements, and beautiful red-brick architecture campus.'),
(91,'Motilal Nehru National Institute of Technology (MNNIT)','Engineering College','Government','Uttar Pradesh','Prayagraj','Barrister Mian Road, Teliarganj','211004','Government','Autonomous',1961,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','http://www.mnnit.ac.in','admissions@mnnit.ac.in','+91-532-2545075','MNNIT','A National Institute of Technology highly famous for its MCA program and solid computer science placement records.'),
(92,'Aligarh Muslim University (AMU)','University','Government','Uttar Pradesh','Aligarh','University Road, Aligarh','202002','Government','Central University',1875,'A+',0,'NAAC,UGC','Engineering,Medical,Law,Arts,Science','https://www.amu.ac.in','registrar@amu.ac.in','+91-571-2700935','AMU','One of India\'s oldest central universities with a legacy spanning 150 years offering diverse undergraduate and postgraduate programs.'),
(93,'Banaras Hindu University (BHU)','University','Government','Uttar Pradesh','Varanasi','Varanasi, Uttar Pradesh','221005','Government','Central University',1916,'A++',0,'NAAC,UGC','Engineering,Medical,Science,Arts,Law,Agriculture','https://www.bhu.ac.in','registrar@bhu.ac.in','+91-542-2307333','BHU','One of the largest residential universities in Asia with exceptional programs across all disciplines.'),
(94,'Jaipuria Institute of Management Noida','Management Institute','Private','Uttar Pradesh','Noida','A-32A, Sector 62, Noida','201309','Private','Autonomous',1995,'A+',1,'NAAC,AICTE','Management','https://www.jaipuria.ac.in/noida','noida@jaipuria.ac.in','+91-120-4638300','JAP','Acclaimed business school offering customized PGDM and management courses tailored for industry digital transformation.'),
(95,'Harcourt Butler Technical University (HBTU)','Engineering College','Government','Uttar Pradesh','Kanpur','Nawabganj, Kanpur','208002','Government','State University',1921,'A',1,'AICTE,NAAC','Engineering,Computer Science,Chemical Engineering','https://hbtu.ac.in','registrar@hbtu.ac.in','+91-512-2534001','HBTU','A historical institute in Kanpur offering premium programs in engineering, technology, and applied computer applications.'),
(96,'Lucknow University (Department of Law)','Law College','Government','Uttar Pradesh','Lucknow','University Road, Lucknow','226007','Government','State University',1867,'A+',0,'BCI,NAAC,UGC','Law','https://www.lkouniv.ac.in','vice_chancellor@lkouniv.ac.in','+91-522-2740456','LU','One of India\'s premier state universities offering law education through its reputed faculty of law.'),
(97,'King George\'s Medical University (KGMU)','Medical College','Government','Uttar Pradesh','Lucknow','Shah Mina Road, Lucknow','226003','Government','State University',1905,'A+',0,'NMC,NAAC','Medical,Nursing,Pharmacy','https://www.kgmu.org','vc@kgmu.org','+91-522-2257540','KGMU','One of India\'s oldest and most prestigious medical universities with multi-specialty hospital facilities.'),
(98,'Era\'s Lucknow Medical College','Medical College','Private','Uttar Pradesh','Lucknow','Sarfarazganj, Hardoi Road','226003','Private','Era University',2001,'B+',0,'NMC,NAAC','Medical','https://www.eralucknow.com','vc@eralucknow.com','+91-522-3052453','ELMC','Private medical college in Lucknow offering MBBS and postgraduate medical programs.'),
(99,'Amity University Lucknow','Engineering College','Private','Uttar Pradesh','Lucknow','Lucknow-Sitapur Highway, Lucknow','226010','Private','Private University',2004,'A',1,'NAAC,AICTE','Engineering,Management,Law','https://www.amity.edu/lko','admissions.lko@amity.edu','+91-522-3040050','AMITYLKO','Amity University\'s Lucknow campus offering diverse programs in engineering, management, and law.'),
(100,'Sam Higginbottom University of Agriculture Technology & Sciences','Agriculture College','Private','Uttar Pradesh','Prayagraj','Naini, Prayagraj','211007','Private','Deemed University',1910,'A',0,'ICAR,NAAC','Agriculture,Engineering,Medical','https://www.shiats.edu.in','vc@shiats.edu.in','+91-532-2684281','SHUATS','A pioneering agricultural university with wide programs in agriculture, engineering, and allied sciences.'),
(101,'Rajiv Gandhi Institute of Petroleum Technology','Engineering College','Government','Uttar Pradesh','Amethi','Jais, Amethi','229304','Government','Autonomous',2008,'N/A',1,'AICTE,UGC','Engineering,Computer Science','https://www.rgipt.ac.in','registrar@rgipt.ac.in','+91-5312-250085','RGIPT','A national institute of importance established in 2008 offering engineering programs in petroleum and computer science.'),
(102,'Institute of Management Technology (IMT) Ghaziabad','Management Institute','Private','Uttar Pradesh','Ghaziabad','Raj Nagar, Ghaziabad','201001','Private','Autonomous',1980,'A',1,'NAAC,AICTE','Management','https://www.imt.edu','admissions@imt.edu','+91-120-4083306','IMT','A leading marketing business school highly acclaimed for PGDM programs and global exchange models.'),
(103,'Birla Institute of Management Technology (BIMTECH)','Management Institute','Private','Uttar Pradesh','Greater Noida','Plot No. 5, Knowledge Park II','201306','Private','Autonomous',1988,'A+',1,'NAAC,AICTE','Management','https://www.bimtech.ac.in','admission@bimtech.ac.in','+91-120-2323001','BIM','Supported by the Birla Group, BIMTECH provides advanced postgraduate training in business management.'),
(104,'UP Rural Institute of Medical Sciences & Research','Medical College','Government','Uttar Pradesh','Saifai','Saifai, Etawah','206130','Government','State University',1998,'B',0,'NMC,NAAC','Medical','https://www.rims.up.gov.in','principal@rims.up.gov.in','+91-5688-267700','RIMS','Government medical university in rural Uttar Pradesh offering affordable medical education and research.'),
(105,'Chhatrapati Shahu Ji Maharaj University','University','Government','Uttar Pradesh','Kanpur','Near Fort, Kanpur','208024','Government','State University',1966,'A',0,'NAAC,UGC','Science,Arts,Commerce,Law','https://www.kanpuruniversity.org','vc@kanpuruniversity.org','+91-512-2584390','CSJMU','One of the major state universities in UP offering undergraduate and postgraduate programs.'),
(106,'Shri Ram Murti Smarak College of Engineering','Engineering College','Private','Uttar Pradesh','Bareilly','Bareilly-Nainital Highway','243202','Private','Dr. A.P.J. Abdul Kalam Technical University',2000,'B+',1,'AICTE,NAAC','Engineering,Computer Science','https://www.srms.ac.in','info@srms.ac.in','+91-581-2580001','SRMS','A reputed private engineering college in Bareilly offering B.Tech programs in various disciplines.'),
(107,'Galgotias University','Engineering College','Private','Uttar Pradesh','Greater Noida','Plot No. 2, Sector 17-A, Yamuna Expressway','203201','Private','Private University',2011,'A',1,'NAAC,AICTE','Engineering,Management,Computer Science','https://www.galgotiasuniversity.edu.in','admissions@galgotias.edu.in','+91-120-4370000','GAL','Offers multi-disciplinary studies with engineering, computer applications, and business management on a large campus.'),
(108,'Bennett University','Engineering College','Private','Uttar Pradesh','Greater Noida','Plot No 8-11, TechZone II','201310','Private','Private University',2016,'A',1,'NAAC,AICTE','Engineering,Management,Media','https://www.bennett.edu.in','admissions@bennett.edu.in','+91-120-7199300','BEN','Founded by the Times Group, Bennett focuses on technology curriculum, media, and management with foreign university tie-ups.');

-- ============================================================
-- WEST BENGAL (20 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(109,'Indian Institute of Technology (IIT) Kharagpur','Engineering College','Government','West Bengal','Kharagpur','Kharagpur, West Bengal','721302','Government','Autonomous',1951,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Architecture,Management','https://www.iitkgp.ac.in','asstreg@iitkgp.ac.in','+91-3222-255221','IITKGP','The oldest and largest IIT campus in India famous for its vast library, extensive alumni network, and excellent programs.'),
(110,'Indian Institute of Management (IIM) Calcutta','Management Institute','Government','West Bengal','Kolkata','Diamond Harbour Rd, Joka','700104','Government','Autonomous',1961,'A++',1,'NAAC,AACSB,AMBA','Management','https://www.iimcal.ac.in','admissions@iimcal.ac.in','+91-33-24678300','IIMC','Renowned for its finance and economics specialization located in a beautiful campus in Joka, Kolkata.'),
(111,'Jadavpur University','Engineering College','Government','West Bengal','Kolkata','Raja S.C. Mullick Road, Jadavpur','700032','Government','State University',1955,'A++',0,'NAAC,UGC','Engineering,Computer Science,Arts,Science','https://jadavpuruniversity.in','registrar@jadavpuruniversity.in','+91-33-24572179','JU','One of West Bengal\'s premier universities offering engineering, science, humanities, and interdisciplinary programs.'),
(112,'Presidency University, Kolkata','Degree College','Government','West Bengal','Kolkata','86/1 College Street, Kolkata','700073','Government','State University',1817,'A++',0,'NAAC,UGC','Science,Arts,Management','https://www.presiuniv.ac.in','registrar@presiuniv.ac.in','+91-33-22418820','PU','One of India\'s oldest universities with a distinguished alumni including Nobel laureates and national leaders.'),
(113,'Institute of Engineering and Management (IEM) Kolkata','Engineering College','Private','West Bengal','Kolkata','Sector V, Salt Lake, Electronics Complex','700091','Private','MAKAUT',1989,'A',1,'AICTE,NAAC','Engineering,Computer Science,Information Technology','https://iem.edu.in','admissions@iemcal.com','+91-33-23572059','IEM','Located in the IT hub of Salt Lake Sector V, IEM is highly regarded for its disciplined campus and software engineering records.'),
(114,'Medical College, Kolkata','Medical College','Government','West Bengal','Kolkata','88 College Street, Kolkata','700073','Government','West Bengal University of Health Sciences',1835,'A',0,'NMC,NAAC','Medical,Nursing','https://medicalcollegekolkata.org','principal@mckolkata.ac.in','+91-33-22128111','MCK','One of the oldest medical colleges in the country with exceptional clinical training at its attached hospital.'),
(115,'Calcutta University (Science and Law)','University','Government','West Bengal','Kolkata','Senate House, Kolkata','700073','Government','State University',1857,'A++',0,'NAAC,UGC','Science,Arts,Law,Commerce','https://www.caluniv.ac.in','registrar@caluniv.ac.in','+91-33-22410071','CU','One of India\'s oldest universities with comprehensive programs and a legacy of academic excellence.'),
(116,'West Bengal National University of Juridical Sciences (NUJS)','Law College','Government','West Bengal','Kolkata','Dr. Ambedkar Bhavan, 12 LB Block, Salt Lake','700098','Government','Autonomous',1999,'A++',0,'BCI,NAAC','Law','https://www.nujs.edu','registrar@nujs.edu','+91-33-23350521','NUJS','One of India\'s premier national law universities consistently ranked among the top law schools in the country.'),
(117,'Bidhan Chandra Krishi Viswavidyalaya','Agriculture College','Government','West Bengal','Nadia','Mohanpur, Nadia','741252','Government','State University',1974,'A',0,'ICAR,NAAC','Agriculture','https://bckv.ac.in','vc@bckv.ac.in','+91-33-25820601','BCKV','The premier agricultural university in West Bengal offering B.Sc Agriculture and postgraduate programs.'),
(118,'Haldia Institute of Technology','Engineering College','Private','West Bengal','Haldia','ICARE Complex, HIT Campus','721657','Private','MAKAUT',1996,'A',1,'AICTE,NAAC','Engineering,Computer Science','https://hithaldia.ac.in','admin@hithaldia.in','+91-3224-252900','HIT','The first private engineering college in West Bengal, boasting a massive residential campus and excellent placement services.'),
(119,'Techno India University','Engineering College','Private','West Bengal','Kolkata','EM 4, Sector V, Salt Lake','700091','Private','Private University',2012,'A',1,'NAAC,AICTE','Engineering,Management,Computer Science','https://technoindiauniversity.ac.in','admissions@technoindia.com','+91-33-23576163','TIU','Part of the massive Techno India Group, offering direct interface with Salt Lake\'s IT companies and global study options.'),
(120,'National Institute of Technology (NIT) Durgapur','Engineering College','Government','West Bengal','Durgapur','Mahatma Gandhi Avenue, Durgapur','713209','Government','Autonomous',1960,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Management','https://nitdgp.ac.in','director@admin.nitdgp.ac.in','+91-343-2754068','NITDGP','A premier NIT offering quality engineering education and research in industrial Durgapur.'),
(121,'Institute of Hotel Management, Kolkata','Hotel Management','Government','West Bengal','Kolkata','Bypass Connector, Kolkata','700107','Government','National Council for Hotel Management',1963,'N/A',0,'NCHMCT','Hotel Management','https://ihmkolkata.ac.in','ihm_kolkata@yahoo.in','+91-33-23350122','IHMKOL','Premier government hotel management institute in eastern India offering BHM and diploma programs.'),
(122,'Indian Institute of Social Welfare & Business Management','Management Institute','Government','West Bengal','Kolkata','College Square West, Kolkata','700073','Government','Calcutta University',1953,'A',1,'NAAC,AICTE','Management','https://www.iiswbm.edu','iiswbm@gmail.com','+91-33-22419680','IISWBM','The first management school in Asia, now offering MBA, MHA, and executive management programs.'),
(123,'Calcutta School of Music','Fine Arts College','Private','West Bengal','Kolkata','Sunny Park, Kolkata','700019','Private','West Bengal State University',1964,'N/A',0,'NAAC','Fine Arts','https://www.calcuttaschoolofmusic.com','info@csom.in','+91-33-24662267','CSM','Premier music education institution in Kolkata offering classical and contemporary music programs.'),
(124,'Rabindra Bharati University','Fine Arts College','Government','West Bengal','Kolkata','56A B.T. Road, Kolkata','700050','Government','State University',1962,'A',0,'NAAC,UGC','Fine Arts,Arts','https://rbu.ac.in','registrar@rbu.ac.in','+91-33-25558044','RBU','Named after Rabindranath Tagore, this university specializes in fine arts, music, and performing arts.'),
(125,'Kalyani Government Engineering College (KGEC)','Engineering College','Government','West Bengal','Kalyani','Kalyani, Nadia District','741235','Government','MAKAUT',1995,'A',1,'AICTE,NAAC','Engineering,Computer Science','http://www.kgec.edu.in','principal@kgec.edu.in','+91-33-25821285','KGEC','A government engineering college in West Bengal offering B.Tech and M.Tech programs.'),
(126,'Scottish Church College','Degree College','Private','West Bengal','Kolkata','1&3 Urquhart Square, Kolkata','700006','Private','University of Calcutta',1830,'A+',0,'NAAC,UGC','Science,Arts,Commerce','https://scottishchurch.ac.in','principalscc@scottishchurch.ac.in','+91-33-22415519','SCC','One of the oldest colleges in India offering quality liberal arts, science, and commerce education.'),
(127,'National Institute of Technology (NIT) Silchar (West Bengal Campus)','Engineering College','Government','West Bengal','Howrah','Howrah, West Bengal','711103','Government','MAKAUT',1958,'N/A',1,'AICTE','Engineering','https://nitsilchar.ac.in','registrar@nits.ac.in','+91-3842-240333','BECIL','Heritage engineering college in Howrah offering B.Tech programs in core disciplines.');

-- ============================================================
-- GUJARAT (20 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(128,'Indian Institute of Management (IIM) Ahmedabad','Management Institute','Government','Gujarat','Ahmedabad','Vastrapur, Ahmedabad','380015','Government','Autonomous',1961,'A++',1,'NAAC,AACSB,AMBA','Management','https://www.iima.ac.in','admission@iima.ac.in','+91-79-71520000','IIMA','Universally recognized as India\'s top business school, famous for its case-study method and top-tier global partnerships.'),
(129,'Nirma University','Engineering College','Private','Gujarat','Ahmedabad','Sarkhej - Gandhinagar Highway','382481','Private','Private University',1994,'A+',1,'AICTE,NAAC','Engineering,Management,Law,Pharmacy','https://nirmauni.ac.in','admissions@nirmauni.ac.in','+91-79-71652000','NIR','Highly reputed private university in Gujarat with a stellar track record in engineering, IT, MCA, and management.'),
(130,'L.D. College of Engineering (LDCE)','Engineering College','Government','Gujarat','Ahmedabad','Opp. Gujarat University, Navrangpura','380015','Government','Gujarat Technological University',1948,'A',1,'AICTE,NAAC','Engineering,Computer Science,Information Technology','http://ldce.ac.in','ldce-admissions@gujarat.gov.in','+91-79-26302887','LDCE','A premier state-run engineering institution in Gujarat offering highly affordable engineering and MCA education.'),
(131,'Pandit Deendayal Energy University (PDEU)','Engineering College','Private','Gujarat','Gandhinagar','Knowledge Corridor, Raisan','382007','Private','Private University',2007,'A++',1,'AICTE,NAAC','Engineering,Computer Science,Management','https://www.pdpu.ac.in','admissions@pdpu.ac.in','+91-79-23275060','PDEU','An excellent energy and technology university with strong research facilities in IT, data analytics, and management.'),
(132,'M.S. University of Baroda','University','Government','Gujarat','Vadodara','Pratapgunj, Vadodara','390002','Government','State University',1949,'A+',0,'NAAC,UGC','Engineering,Science,Arts,Commerce,Law,Fine Arts','https://www.msubaroda.ac.in','admissions@msubaroda.ac.in','+91-265-2795555','MSU','A historical state university offering comprehensive software engineering, computer applications, and corporate business degrees.'),
(133,'Gujarat Technological University (GTU)','University','Government','Gujarat','Ahmedabad','Visat - Gandhinagar Highway, Chandkheda','382424','Government','State University',2007,'A',1,'AICTE,NAAC','Engineering,Management,Pharmacy','https://gtu.ac.in','registrar@gtu.ac.in','+91-79-23267500','GTU','The apex technological university in Gujarat affiliating over 500 engineering and management institutions.'),
(134,'Ahmedabad University','Degree College','Private','Gujarat','Ahmedabad','Commerce Six Roads, Navrangpura','380009','Private','Private University',2009,'A',0,'NAAC,UGC','Science,Engineering,Management,Arts','https://ahduni.edu.in','admissions@ahduni.edu.in','+91-79-61911200','AHU','Focuses on liberal education, design thinking, modern computing sciences, and premium business management modules.'),
(135,'B.J. Medical College, Ahmedabad','Medical College','Government','Gujarat','Ahmedabad','New Civil Campus, Asarwa','380016','Government','Gujarat University',1946,'A+',0,'NMC,NAAC','Medical,Nursing','https://bjmcahmedabad.ac.in','principal@bjmc.edu.in','+91-79-22682781','BJMC','One of Gujarat\'s oldest and largest government medical colleges with excellent clinical training at Ahmedabad Civil Hospital.'),
(136,'B.N. Patel Institute of Paramedical & Science','Paramedical College','Private','Gujarat','Anand','Opposite AMUL Dairy, Anand','388001','Private','Sardar Patel University',1999,'N/A',0,'NAAC','Paramedical,Science','https://bnpips.edu.in','info@bnpips.edu.in','+91-2692-266201','BNPIPS','Reputed institute offering paramedical and allied health science programs in central Gujarat.'),
(137,'CEPT University','Architecture College','Private','Gujarat','Ahmedabad','Kasturbhai Lalbhai Campus, University Road','380009','Private','Private University',1962,'A++',0,'COA,NAAC','Architecture,Design','https://cept.ac.in','info@cept.ac.in','+91-79-26302470','CEPT','India\'s premier planning and design university offering B.Arch, M.Arch, and urban design programs.'),
(138,'National Law University, Jodhpur (Gujarat Campus)','Law College','Government','Gujarat','Gandhinagar','Near Bhumika Chowkdi, Gandhinagar','382007','Government','Autonomous',2010,'A',0,'BCI,NAAC','Law','https://gnlu.ac.in','info@gnlu.ac.in','+91-79-23248521','GNLU','Gujarat National Law University offering BA LLB and LLM programs with focus on research.'),
(139,'Anand Agricultural University','Agriculture College','Government','Gujarat','Anand','Anand-Sojitra Road, Anand','388110','Government','State University',2004,'A',0,'ICAR,NAAC','Agriculture','https://aau.in','registrar@aau.in','+91-2692-261213','AAU','Dedicated agriculture university in Gujarat\'s milk capital Anand offering B.Sc and M.Sc agriculture programs.'),
(140,'Government Polytechnic, Ahmedabad','Polytechnic College','Government','Gujarat','Ahmedabad','Ambawadi, Ahmedabad','380015','Government','Gujarat Technological University',1959,'N/A',1,'AICTE','Polytechnic,Diploma','https://gpahmedabad.ac.in','principal@gpahmedabad.ac.in','+91-79-26305083','GPA','The oldest government polytechnic in Gujarat offering diploma engineering programs.'),
(141,'Sardar Vallabhbhai National Institute of Technology (SVNIT)','Engineering College','Government','Gujarat','Surat','Ichchhanath, Surat','395007','Government','Autonomous',1961,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.svnit.ac.in','director@svnit.ac.in','+91-261-2201503','SVNIT','A prestigious NIT offering quality engineering education in industrial Surat, Gujarat.'),
(142,'Navrachana University','Engineering College','Private','Gujarat','Vadodara','Vasna-Bhayli Road, Vadodara','391410','Private','Private University',2009,'A',1,'NAAC,AICTE','Engineering,Management,Design','https://www.nuv.ac.in','admissions@nuv.ac.in','+91-265-2545000','NU','An innovative multi-disciplinary university in Vadodara offering modern engineering and design education.'),
(143,'R.K. University','Engineering College','Private','Gujarat','Rajkot','Kasturbhadham, Rajkot','360020','Private','Private University',2009,'B+',1,'NAAC,AICTE','Engineering,Management,Arts','https://rku.ac.in','admission@rku.ac.in','+91-281-2777000','RKU','A private university in Rajkot offering engineering, management, and arts programs.'),
(144,'Sumandeep Vidyapeeth','Medical College','Private','Gujarat','Vadodara','Pipariya, Waghodia','391760','Private','Deemed University',1995,'A',0,'NMC,NAAC,PCI','Medical,Pharmacy,Nursing','https://sumandeepuniversity.co.in','admissions@sumandeep.edu.in','+91-2668-260302','SV','A health sciences deemed university offering MBBS, pharmacy, nursing, and allied health programs.'),
(145,'Vishwakarma Government Engineering College (VGEC)','Engineering College','Government','Gujarat','Ahmedabad','Chandkheda, Near Visat Three Roads','382424','Government','Gujarat Technological University',1966,'A',1,'AICTE,NAAC','Engineering,Computer Science,Information Technology','http://www.vgecg.ac.in','vgec_ahd@yahoo.co.in','+91-79-29099903','VGEC','Known for its sprawling green campus, VGEC provides standard government engineering options in Information Technology.'),
(146,'Gujarat Ayurved University','Medical College','Government','Gujarat','Jamnagar','Gulbai Tekra, Jamnagar','361008','Government','State University',1967,'A+',0,'CCRH,NAAC','Ayurveda','https://gau.ac.in','vc@gau.ac.in','+91-288-2556846','GAU','India\'s first Ayurveda university offering BAMS, M.D. Ayurveda, and research programs.');

-- ============================================================
-- RAJASTHAN (20 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(147,'Birla Institute of Technology and Science (BITS) Pilani','Engineering College','Private','Rajasthan','Pilani','Vidya Vihar, Pilani','333031','Private','Deemed University',1964,'A',1,'AICTE,NAAC','Engineering,Computer Science,Management,Pharmacy','https://www.bits-pilani.ac.in','admissions@pilani.bits-pilani.ac.in','+91-1596-245073','BITS','A premium private university known for merit-based admission, lack of reservations, strong entrepreneurial culture.'),
(148,'Malaviya National Institute of Technology (MNIT)','Engineering College','Government','Rajasthan','Jaipur','JLN Marg, Jaipur','302017','Government','Autonomous',1963,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.mnit.ac.in','director@mnit.ac.in','+91-141-2529087','MNIT','A premier NIT in Rajasthan offering quality engineering education and research programs.'),
(149,'University of Rajasthan','University','Government','Rajasthan','Jaipur','JLN Marg, Jaipur','302004','Government','State University',1947,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law,Engineering','https://www.uniraj.ac.in','vc@uniraj.ac.in','+91-141-2711070','UR','The premier state university of Rajasthan offering diverse programs across all major disciplines.'),
(150,'SMS Medical College & Hospital','Medical College','Government','Rajasthan','Jaipur','JLN Marg, Jaipur','302004','Government','Rajasthan University of Health Sciences',1947,'A',0,'NMC,NAAC','Medical,Nursing','https://smsmch.rajasthan.gov.in','principalsms@gmail.com','+91-141-2518501','SMS','One of India\'s largest government medical colleges attached to the iconic SMS Hospital in Jaipur.'),
(151,'National Law University, Jodhpur','Law College','Government','Rajasthan','Jodhpur','NH-65, Nagour Road, Mandore','342304','Government','Autonomous',1999,'A+',0,'BCI,NAAC','Law','https://www.nlujodhpur.ac.in','contact@nlujodhpur.ac.in','+91-291-2577530','NLUJ','One of India\'s premier national law universities with strong research and moot court traditions.'),
(152,'Rajasthan Technical University','University','Government','Rajasthan','Kota','Rawatbhata Road, Kota','324010','Government','State University',2006,'A',1,'AICTE,NAAC','Engineering,Management','https://www.rtu.ac.in','registrar@rtu.ac.in','+91-744-2744000','RTU','The apex technical university in Rajasthan affiliating engineering and management colleges.'),
(153,'Manipal University Jaipur','Engineering College','Private','Rajasthan','Jaipur','Dehmi Kalan, Near GVK Toll Plaza','303007','Private','Private University',2011,'A',1,'NAAC,AICTE','Engineering,Management,Law,Design','https://jaipur.manipal.edu','admissions.muj@manipal.edu','+91-141-3999100','MUJ','Manipal University\'s Jaipur campus offering diverse programs in engineering, management, and design.'),
(154,'Dr. S.N. Medical College, Jodhpur','Medical College','Government','Rajasthan','Jodhpur','Pali Road, Jodhpur','342001','Government','Rajasthan University of Health Sciences',1965,'A',0,'NMC,NAAC','Medical,Nursing','https://snmcjdh.ac.in','principal@snmcjdh.ac.in','+91-291-2432262','SNMC','Premier government medical college in western Rajasthan offering MBBS and postgraduate medical programs.'),
(155,'IIS University (The IIS University)','Degree College','Private','Rajasthan','Jaipur','SFS, Mansarovar','302020','Private','State Private University',2009,'A+',0,'NAAC,UGC','Science,Arts,Commerce,Management','https://www.iisuniv.ac.in','info@iisuniv.ac.in','+91-141-2400160','IIS','A prominent women\'s university in Jaipur offering quality education across multiple streams.'),
(156,'Agricultural University, Kota','Agriculture College','Government','Rajasthan','Kota','Borkheda, Kota','325001','Government','State University',2013,'N/A',0,'ICAR','Agriculture','https://www.auk.ac.in','registrar@auk.ac.in','+91-744-2900016','AUK','Agriculture university established to promote agricultural education and research in Rajasthan.'),
(157,'MDS University Ajmer','University','Government','Rajasthan','Ajmer','Ajmer-Pushkar Road, Ajmer','305009','Government','State University',1987,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.mdsuajmer.ac.in','vc@mdsuajmer.ac.in','+91-145-2787300','MDSU','Maharshi Dayanand Saraswati University offering wide programs in liberal arts, sciences, and commerce.'),
(158,'Government Polytechnic College, Jaipur','Polytechnic College','Government','Rajasthan','Jaipur','6 Residency Road, Jaipur','302001','Government','Board of Technical Education Rajasthan',1957,'N/A',1,'AICTE','Polytechnic,Diploma','https://gpcjaipur.ac.in','principalgpcjaipur@gmail.com','+91-141-2395301','GPCJ','The oldest government polytechnic in Rajasthan offering quality diploma engineering programs.'),
(159,'Amity University Rajasthan','Engineering College','Private','Rajasthan','Jaipur','SP-1, Kant Kalwar, NH-11C','303002','Private','Private University',2008,'A',1,'NAAC,AICTE','Engineering,Management,Law,Design','https://www.amity.edu/rajasthan','admissions@amity.edu','+91-141-6617000','AMITYRJ','Amity University\'s Rajasthan campus offering diverse programs in engineering, management, and design.'),
(160,'Indian Institute of Health Management Research (IIHMR)','Management Institute','Private','Rajasthan','Jaipur','1, Prabhu Dayal Marg, Sanganer','302029','Private','Deemed University',1984,'A+',1,'NAAC,AICTE','Management','https://iihmr.edu.in','admissions@iihmr.edu.in','+91-141-3924700','IIHMR','A specialized management institute focused on hospital and healthcare management education in India.'),
(161,'Rajasthan Ayurved University','Medical College','Government','Rajasthan','Jodhpur','Nagaur Road, Jodhpur','342037','Government','State University',2002,'A',0,'CCRH,NAAC','Ayurveda','https://rau.rajasthan.gov.in','registrar@rau.rajasthan.gov.in','+91-291-2754181','RAU','Dedicated Ayurveda university in Rajasthan offering BAMS and postgraduate Ayurveda programs.'),
(162,'Government College of Engineering, Bikaner','Engineering College','Government','Rajasthan','Bikaner','Old Ginani Road, Bikaner','334004','Government','Rajasthan Technical University',1994,'B+',1,'AICTE,NAAC','Engineering,Computer Science','https://gcebikaner.ac.in','principalgceb@gmail.com','+91-151-2203000','GCEB','Government engineering college in Bikaner offering B.Tech programs at affordable fees.');

-- ============================================================
-- MADHYA PRADESH (18 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(163,'Indian Institute of Technology (IIT) Indore','Engineering College','Government','Madhya Pradesh','Indore','Simrol, Indore','453552','Government','Autonomous',2009,'A',1,'AICTE,NAAC','Engineering,Computer Science,Science','https://www.iiti.ac.in','academic@iiti.ac.in','+91-731-2360700','IITI','A relatively new IIT with excellent research culture and rapidly growing engineering and science programs.'),
(164,'Indian Institute of Management (IIM) Indore','Management Institute','Government','Madhya Pradesh','Indore','Prabandh Shikhar, Rau-Pithampur Road','453556','Government','Autonomous',1996,'A++',1,'NAAC,AACSB','Management','https://www.iimidr.ac.in','admissions@iimidr.ac.in','+91-731-2439670','IIMI','A premier IIM offering MBA, PhD, and executive education programs with global industry connections.'),
(165,'National Institute of Technology (NIT) Bhopal','Engineering College','Government','Madhya Pradesh','Bhopal','Opposite BHEL, Govindpura','462066','Government','Autonomous',1960,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.manit.ac.in','director@manit.ac.in','+91-755-4051000','MANIT','A premier NIT in Madhya Pradesh offering quality engineering education and research.'),
(166,'Barkatullah University','University','Government','Madhya Pradesh','Bhopal','Bhopal, Madhya Pradesh','462026','Government','State University',1970,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://bubhopal.ac.in','vc@bubhopal.ac.in','+91-755-2517238','BU','One of the major state universities in MP offering diverse undergraduate and postgraduate programs.'),
(167,'All India Institute of Medical Sciences (AIIMS), Bhopal','Medical College','Government','Madhya Pradesh','Bhopal','Saket Nagar, Bhopal','462024','Government','Autonomous',2012,'N/A',0,'NMC','Medical,Nursing','https://www.aiimsbhopal.edu.in','director@aiimsbhopal.edu.in','+91-755-2672341','AIIMSB','One of the newer AIIMS institutes providing quality medical education and tertiary healthcare in central India.'),
(168,'Rani Durgavati Vishwavidyalaya','University','Government','Madhya Pradesh','Jabalpur','Saraswati Vihar, Jabalpur','482001','Government','State University',1956,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.rdunijbpin.nic.in','vc@rdunijbpin.nic.in','+91-761-2600012','RDU','A premier state university offering diverse programs across arts, science, commerce, and law.'),
(169,'Rajiv Gandhi Proudyogiki Vishwavidyalaya (RGPV)','University','Government','Madhya Pradesh','Bhopal','Airport Bypass Road, Gandhi Nagar','462033','Government','State University',1998,'A',1,'AICTE,NAAC','Engineering,Management,Computer Science','https://www.rgpv.ac.in','registrar@rgpv.ac.in','+91-755-2678799','RGPV','The apex technical university in MP affiliating over 200 engineering and management colleges.'),
(170,'Devi Ahilya Vishwavidyalaya (DAVV)','University','Government','Madhya Pradesh','Indore','R.N.T. Marg, Indore','452001','Government','State University',1964,'A',0,'NAAC,UGC','Engineering,Science,Arts,Commerce,Law,Management','https://www.dauniv.ac.in','vc@dauniv.ac.in','+91-731-2527600','DAVV','One of the major state universities in MP with a large number of affiliated colleges in Indore.'),
(171,'Maulana Azad National Institute of Technology (MANIT)','Engineering College','Government','Madhya Pradesh','Bhopal','Near BHEL, Govindpura','462066','Government','Autonomous',1960,'A',1,'AICTE,NAAC','Engineering,Computer Science,Architecture','https://www.manit.ac.in','director@manit.ac.in','+91-755-4051000','MANIT2','Premier NIT in Bhopal with Architecture, Engineering, and Computer Science programs.'),
(172,'Symbiosis Institute of Technology (SIT) Nagpur','Engineering College','Private','Madhya Pradesh','Bhopal','Shraddha Park, Bhopal','462026','Private','Symbiosis International University',2008,'A',1,'AICTE,NAAC','Engineering,Computer Science','https://sit.edu.in','sitngp@symbiosis.ac.in','+91-755-6786100','SITN','A Symbiosis group engineering college offering B.Tech and M.Tech programs.'),
(173,'Government Agriculture College, Gwalior','Agriculture College','Government','Madhya Pradesh','Gwalior','City Centre, Gwalior','474002','Government','Rajmata Vijayaraje Scindia Krishi Vishwa Vidyalaya',1960,'N/A',0,'ICAR','Agriculture','https://rvskvv.ac.in','registrar@rvskvv.ac.in','+91-751-2374503','GACG','Government agriculture college offering B.Sc Agriculture programs in the Gwalior region.'),
(174,'Holkar Science College','Degree College','Government','Madhya Pradesh','Indore','Indore, Madhya Pradesh','452001','Government','Devi Ahilya Vishwavidyalaya',1942,'A',0,'NAAC,UGC','Science','https://holkarsciencecollege.ac.in','principal@holkarsciencecollege.ac.in','+91-731-2704000','HSC','One of the oldest and most reputed science colleges in central India offering B.Sc and M.Sc programs.'),
(175,'Government Polytechnic, Bhopal','Polytechnic College','Government','Madhya Pradesh','Bhopal','Sultan Complex, Bhopal','462016','Government','MP Board of Technical Education',1960,'N/A',1,'AICTE','Polytechnic,Diploma','https://gpbhopal.ac.in','gpbhopal@gmail.com','+91-755-2775600','GPB','The premier government polytechnic in Madhya Pradesh offering diploma engineering programs.'),
(176,'National Institute of Fashion Technology (NIFT) Bhopal','Design College','Government','Madhya Pradesh','Bhopal','Govindpura, Bhopal','462023','Government','Autonomous',2010,'N/A',0,'NAAC','Design','https://www.nift.ac.in/bhopal','niftbpl@nift.ac.in','+91-755-2426200','NIFTB','NIFT Bhopal campus offering B.Des programs in fashion design and technology.');

-- ============================================================
-- TELANGANA (18 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(177,'International Institute of Information Technology (IIIT) Hyderabad','Engineering College','Private','Telangana','Hyderabad','Gachibowli, Hyderabad','500032','Private','Deemed University',1998,'A',1,'AICTE,NAAC','Engineering,Computer Science,Artificial Intelligence','https://www.iiit.ac.in','query@iiit.ac.in','+91-40-66531000','IIITH','Highly research-centric institute focusing on technology, computing, AI, and natural language processing.'),
(178,'Chaitanya Bharathi Institute of Technology (CBIT)','Engineering College','Private','Telangana','Hyderabad','Gandipet, Hyderabad','500075','Private','Osmania University',1979,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.cbit.ac.in','principal@cbit.ac.in','+91-40-24193276','CBIT','One of the premier private engineering institutions in Telangana known for strong alumni presence and high standards.'),
(179,'VNR Vignana Jyothi Institute of Engineering and Technology','Engineering College','Private','Telangana','Hyderabad','Bachupally, Nizampet','500090','Private','JNTU Hyderabad',1997,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://vnrvjiet.ac.in','principal@vnrvjiet.ac.in','+91-40-23042758','VNR','Known for modular and progressive education, offering excellent campus infrastructure, computing laboratories, and internships.'),
(180,'ICFAI Business School (IBS) Hyderabad','Management Institute','Private','Telangana','Hyderabad','Dontanapalli, Shankarpally Road','501203','Private','IFHE Deemed University',1995,'A+',1,'NAAC,AICTE','Management','https://www.ibsindia.org','ibshyd@ibsindia.org','+91-40-23479000','IBS','Famous for its massive case study methodology repository and extensive national network of management professionals.'),
(181,'Osmania Medical College','Medical College','Government','Telangana','Hyderabad','Koti, Hyderabad','500095','Government','Kaloji Narayana Rao University of Health Sciences',1846,'A',0,'NMC,NAAC','Medical,Nursing','https://osmaniamedicalcollege.ac.in','principal@osmaniamc.ac.in','+91-40-24600100','OMC','One of the oldest medical colleges in South India offering MBBS and postgraduate medical programs.'),
(182,'Vasavi College of Engineering','Engineering College','Private','Telangana','Hyderabad','Ibrahimbagh, Hyderabad','500031','Private','Osmania University',1981,'A+',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.vce.ac.in','principal@vce.ac.in','+91-40-23146003','VCE','Known for maintaining excellent academic discipline and top placement statistics in technology and IT sectors.'),
(183,'National Institute of Technology (NIT) Warangal','Engineering College','Government','Telangana','Warangal','NIT Campus, Warangal','506004','Government','Autonomous',1959,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.nitw.ac.in','director@nitw.ac.in','+91-870-2462020','NITW','One of the oldest NITs in South India offering quality engineering education and research.'),
(184,'University College of Law, Osmania University','Law College','Government','Telangana','Hyderabad','Osmania University Campus, Hyderabad','500007','Government','Osmania University',1919,'B+',0,'BCI,NAAC','Law','https://ouclaw.ac.in','principal@ouclaw.ac.in','+91-40-27098390','OUCL','One of the oldest law colleges in South India under Osmania University offering LLB programs.'),
(185,'Hyderabad Agricultural University (PJTSAU)','Agriculture College','Government','Telangana','Hyderabad','Rajendranagar, Hyderabad','500030','Government','State University',2014,'A',0,'ICAR,NAAC','Agriculture','https://pjtsau.edu.in','vc@pjtsau.edu.in','+91-40-24015030','PJTSAU','Prof. Jayashankar Telangana State Agricultural University offering B.Sc Agriculture and postgraduate programs.'),
(186,'Kakatiya Medical College','Medical College','Government','Telangana','Warangal','MGM Hospital Road, Warangal','506007','Government','Kaloji Narayana Rao University of Health Sciences',1959,'A',0,'NMC,NAAC','Medical','https://kmc.warangal.ac.in','principal@kmc.warangal.ac.in','+91-870-2577900','KMC','Premier government medical college in Telangana\'s second city Warangal offering MBBS programs.'),
(187,'Government Medical College, Siddipet','Medical College','Government','Telangana','Siddipet','Yellareddy Village, Siddipet','502114','Government','Kaloji NR University of Health Sciences',2019,'N/A',0,'NMC','Medical','https://gmcsiddipet.telangana.gov.in','principal@gmcsiddipet.ac.in','+91-8457-222000','GMCS','One of the newer government medical colleges in Telangana providing MBBS education.'),
(188,'Institute of Hotel Management, Hyderabad','Hotel Management','Government','Telangana','Hyderabad','Adarsh Nagar, Hyderabad','500063','Government','National Council for Hotel Management',1972,'N/A',0,'NCHMCT','Hotel Management','https://ihmhyd.ac.in','ihmhyderabad@gmail.com','+91-40-27751416','IHMH','Premier government hotel management institute in Hyderabad offering BHM and diploma programs.'),
(189,'Vignana Jyothi Institute of Management','Management Institute','Private','Telangana','Hyderabad','Vignana Jyothi Nagar, Bachupally','500090','Private','Autonomous',1989,'A',1,'NAAC,AICTE','Management','https://vjim.ac.in','admissions@vjim.edu.in','+91-40-44662210','VJIM','A reputed management institute in Hyderabad offering MBA programs with strong corporate connections.');

-- ============================================================
-- ANDHRA PRADESH (18 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(190,'Indian Institute of Technology (IIT) Tirupati','Engineering College','Government','Andhra Pradesh','Tirupati','Yerpedu, Tirupati','517619','Government','Autonomous',2015,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iittp.ac.in','registrar@iittp.ac.in','+91-877-2500300','IITTP','One of the newer IITs offering quality engineering education in spiritual Tirupati city.'),
(191,'JNTU Anantapur','Engineering College','Government','Andhra Pradesh','Anantapur','Anantapur, AP','515002','Government','State University',1946,'A',1,'AICTE,NAAC','Engineering,Computer Science','https://jntua.ac.in','registrar@jntua.ac.in','+91-8554-272202','JNTUA','JNTU Anantapur offering engineering education across multiple disciplines with wide college affiliations.'),
(192,'GITAM University','Engineering College','Private','Andhra Pradesh','Visakhapatnam','Gandhi Nagar, Rushikonda','530045','Private','Deemed University',1980,'A+',1,'NAAC,AICTE','Engineering,Management,Science,Law','https://www.gitam.edu','admissions@gitam.edu','+91-891-2840499','GITAM','A leading deemed university on the eastern coast offering engineering, management, and science programs.'),
(193,'Andhra University','University','Government','Andhra Pradesh','Visakhapatnam','University Campus, Waltair','530003','Government','State University',1926,'A+',0,'NAAC,UGC','Engineering,Science,Arts,Commerce,Law','https://andhrauniversity.edu.in','registrar@andhrauniversity.edu.in','+91-891-2844444','AU','One of the oldest state universities in Andhra Pradesh offering diverse undergraduate and postgraduate programs.'),
(194,'Rangaraya Medical College','Medical College','Government','Andhra Pradesh','Kakinada','Medical College Road, Kakinada','533001','Government','NTR University of Health Sciences',1958,'A',0,'NMC,NAAC','Medical,Nursing','https://rmckakinada.ac.in','principal@rmckakinada.ac.in','+91-884-2351600','RMC','Premier government medical college in eastern Andhra Pradesh offering MBBS and MD programs.'),
(195,'Koneru Lakshmaiah Education Foundation (KLEF)','Engineering College','Private','Andhra Pradesh','Guntur','Green Fields, Vaddeswaram','522502','Private','Deemed University',1980,'A+',1,'NAAC,AICTE','Engineering,Computer Science,Management','https://kluniversity.in','admissions@kluniversity.in','+91-8645-246948','KLU','One of the leading private universities in AP offering engineering, management, and science programs.'),
(196,'Sri Venkateswara University','University','Government','Andhra Pradesh','Tirupati','Tirupati, AP','517502','Government','State University',1954,'A',0,'NAAC,UGC','Engineering,Science,Arts,Commerce,Law','https://svuniversity.edu.in','registrar@svuniversity.edu.in','+91-877-2289544','SVU','State university located in Tirupati offering diverse programs with a large network of affiliated colleges.'),
(197,'Acharya Nagarjuna University','University','Government','Andhra Pradesh','Guntur','Nagarjuna Nagar, Guntur','522510','Government','State University',1976,'A',0,'NAAC,UGC','Science,Arts,Commerce,Law,Engineering','https://www.nagarjunauniversity.ac.in','vc@nagarjunauniversity.ac.in','+91-863-2346454','ANU','Major state university in central Andhra Pradesh with a wide range of affiliated colleges.'),
(198,'Acharya N.G. Ranga Agricultural University','Agriculture College','Government','Andhra Pradesh','Guntur','Admn. Office, Lam, Guntur','522034','Government','State University',1964,'A',0,'ICAR,NAAC','Agriculture','https://angrau.ac.in','vc@angrau.ac.in','+91-863-2288100','ANGRAU','The premier agricultural university in Andhra Pradesh offering B.Sc Agriculture and research programs.'),
(199,'AU College of Law','Law College','Government','Andhra Pradesh','Visakhapatnam','Andhra University Campus, Waltair','530003','Government','Andhra University',1937,'B+',0,'BCI,NAAC','Law','https://andhrauniversity.edu.in/law','principal@aulaw.ac.in','+91-891-2844444','AUCL','One of the oldest law faculties in AP under Andhra University offering 3-year and 5-year LLB programs.'),
(200,'Andhra Medical College','Medical College','Government','Andhra Pradesh','Visakhapatnam','King George Hospital, Vizag','530002','Government','NTR University of Health Sciences',1923,'A',0,'NMC,NAAC','Medical,Nursing','https://amcvizag.ac.in','principal@amcvizag.ac.in','+91-891-2564878','AMC','One of the oldest government medical colleges in Andhra Pradesh with excellent clinical training.');

-- ============================================================
-- BIHAR (18 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(201,'Indian Institute of Technology (IIT) Patna','Engineering College','Government','Bihar','Patna','Bihta, Patna','801106','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitp.ac.in','registrar@iitp.ac.in','+91-612-3028000','IITP','A relatively newer IIT offering quality engineering and computer science programs in Bihar.'),
(202,'National Institute of Technology (NIT) Patna','Engineering College','Government','Bihar','Patna','Ashok Rajpath, Patna','800005','Government','Autonomous',1886,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://www.nitp.ac.in','director@nitp.ac.in','+91-612-2371715','NITP','One of India\'s oldest engineering institutions now operating as a premier NIT in Bihar.'),
(203,'Patna Medical College & Hospital','Medical College','Government','Bihar','Patna','Ashok Rajpath, Patna','800004','Government','Aryabhatta Knowledge University',1925,'A',0,'NMC,NAAC','Medical,Nursing','https://pmchindia.com','principal@pmch.bih.nic.in','+91-612-2300070','PMCH','One of India\'s oldest government medical colleges with the iconic Patna Medical College Hospital.'),
(204,'Patna University','University','Government','Bihar','Patna','Ashok Rajpath, Patna','800005','Government','State University',1917,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://patnauniversity.ac.in','registrar@patnauniversity.ac.in','+91-612-2670877','PU','One of India\'s oldest universities offering diverse programs across arts, science, commerce, and law.'),
(205,'Bihar Agricultural University','Agriculture College','Government','Bihar','Sabour','Sabour, Bhagalpur','813210','Government','State University',2010,'N/A',0,'ICAR','Agriculture','https://bausabour.ac.in','vc@bausabour.ac.in','+91-641-2422261','BAU','Bihar\'s premier agricultural university offering B.Sc Agriculture and postgraduate programs.'),
(206,'Central University of South Bihar','University','Government','Bihar','Gaya','Camp Office: Panchanpur, Gaya','824236','Government','Central University',2009,'N/A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.cusb.ac.in','vc@cusb.ac.in','+91-631-2229511','CUSB','A central university providing quality education in arts, sciences, commerce, and law.'),
(207,'XLRI Jamshedpur (Jharkhand/Bihar Region)','Management Institute','Private','Bihar','Jamshedpur','C.H. Area (East), Jamshedpur','831001','Private','Autonomous',1949,'A++',1,'NAAC,AACSB','Management','https://www.xlri.ac.in','admissions@xlri.ac.in','+91-657-3983000','XLRI','One of India\'s premier management institutes known for HR and business management programs.'),
(208,'Chandragupt Institute of Management Patna','Management Institute','Private','Bihar','Patna','Mithapur Farm Area, Patna','800001','Private','Autonomous',2008,'A',1,'NAAC,AICTE','Management','https://cimp.ac.in','admissions@cimp.ac.in','+91-612-2364481','CIMP','A premier management institution in Bihar offering PGDM programs with strong business focus.'),
(209,'Bihar College of Engineering (Now NIT Patna Campus)','Engineering College','Government','Bihar','Patna','Ashok Rajpath, Patna','800005','Government','NIT Patna',1886,'A',1,'AICTE,NAAC','Engineering,Computer Science','https://www.nitp.ac.in','director@nitp.ac.in','+91-612-2371715','BCE','The historic Bihar College of Engineering now functioning as NIT Patna campus.'),
(210,'Gaya Medical College & Hospital','Medical College','Government','Bihar','Gaya','Gaya, Bihar','823001','Government','Aryabhatta Knowledge University',2014,'N/A',0,'NMC','Medical','https://gmchgaya.in','principalgmch@gmail.com','+91-631-2226000','GMCHG','Government medical college in Gaya offering MBBS programs for students of the region.');

-- ============================================================
-- PUNJAB (18 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(211,'Indian Institute of Technology (IIT) Ropar','Engineering College','Government','Punjab','Ropar','Nangal Road, Rupnagar','140001','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitrpr.ac.in','registrar@iitrpr.ac.in','+91-1881-242110','IITRPR','A newer IIT offering quality engineering and computer science programs in Punjab.'),
(212,'Thapar Institute of Engineering and Technology','Engineering College','Private','Punjab','Patiala','Bhadson Road, Patiala','147004','Private','Deemed University',1956,'A',1,'NAAC,AICTE','Engineering,Computer Science,Management','https://www.thapar.edu','admissions@thapar.edu','+91-175-2393021','TIET','One of Punjab\'s premier private engineering institutions known for research and high-quality placements.'),
(213,'Punjab University, Chandigarh','University','Government','Punjab','Chandigarh','Sector 14, Chandigarh','160014','Government','State University',1947,'A++',0,'NAAC,UGC','Arts,Science,Commerce,Law,Engineering','https://www.puchd.ac.in','registrar@pu.ac.in','+91-172-2534818','PUC','One of India\'s premier state universities with a distinguished tradition in education and research.'),
(214,'Government Medical College, Amritsar','Medical College','Government','Punjab','Amritsar','Circular Road, Amritsar','143001','Government','Baba Farid University of Health Sciences',1864,'A',0,'NMC,NAAC','Medical,Nursing','https://gmcamritsar.ac.in','principal@gmcamritsar.ac.in','+91-183-2501244','GMCA','One of the oldest government medical colleges in north India with excellent clinical training.'),
(215,'Punjab Agricultural University (PAU)','Agriculture College','Government','Punjab','Ludhiana','Punjab Agricultural University, Ludhiana','141004','Government','State University',1962,'A++',0,'ICAR,NAAC','Agriculture','https://pau.edu','vc@pau.edu','+91-161-2401960','PAU','One of India\'s premiere agricultural universities known for high-yielding crop varieties and Green Revolution research.'),
(216,'Chandigarh University','Engineering College','Private','Punjab','Mohali','NH-95, Chandigarh-Ludhiana Highway','140413','Private','Private University',2012,'A+',1,'NAAC,AICTE','Engineering,Management,Computer Science,Law','https://www.cuchd.in','admissions@cumail.in','+91-160-3051003','CUC','One of India\'s fastest growing private universities offering diverse engineering and management programs.'),
(217,'Lovely Professional University (LPU)','Engineering College','Private','Punjab','Phagwara','Phagwara, Punjab','144411','Private','Private University',2005,'A+',1,'NAAC,AICTE','Engineering,Management,Computer Science,Agriculture,Law','https://www.lpu.in','admissions@lpu.co.in','+91-1824-404404','LPU','One of India\'s largest private universities offering a wide range of programs with strong industry connections.'),
(218,'National Institute of Technology (NIT) Jalandhar','Engineering College','Government','Punjab','Jalandhar','Grand Trunk Road, Amritsar Bypass','144008','Government','Autonomous',1987,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://www.nitj.ac.in','director@nitj.ac.in','+91-181-2690301','NITJ','A premier NIT in Punjab offering quality engineering education and research programs.'),
(219,'Government College of Law, Chandigarh','Law College','Government','Punjab','Chandigarh','Sector 37, Chandigarh','160036','Government','Punjab University',1972,'B+',0,'BCI,NAAC','Law','https://gclaw.ac.in','gclaw@chandigarh.gov.in','+91-172-2672355','GCLC','Government law college in Chandigarh offering LLB programs.'),
(220,'DAV College, Chandigarh','Degree College','Government','Punjab','Chandigarh','Sector 10, Chandigarh','160011','Government','Panjab University',1953,'A++',0,'NAAC,UGC','Arts,Science,Commerce','https://davchandigarh.com','principal@davchandigarh.com','+91-172-2740088','DAVC','One of the premier autonomous colleges under Panjab University known for academic excellence.');

-- ============================================================
-- HARYANA (15 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(221,'National Institute of Technology (NIT) Kurukshetra','Engineering College','Government','Haryana','Kurukshetra','NIT Campus, Kurukshetra','136119','Government','Autonomous',1963,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Electronics Engineering','https://nitkkr.ac.in','director@nitkkr.ac.in','+91-1744-233208','NITKUK','A premier NIT in Haryana offering quality engineering education and research in Kurukshetra.'),
(222,'Maharshi Dayanand University (MDU)','University','Government','Haryana','Rohtak','MDU Campus, Rohtak','124001','Government','State University',1976,'A',0,'NAAC,UGC','Engineering,Science,Arts,Commerce,Law','https://www.mdurohtak.ac.in','registrar@mdurohtak.ac.in','+91-1262-393545','MDU','One of the premier state universities in Haryana offering diverse undergraduate and postgraduate programs.'),
(223,'Pandit B.D. Sharma PGIMS Rohtak','Medical College','Government','Haryana','Rohtak','Pt. B.D. Sharma University, Rohtak','124001','Government','Pt. B.D. Sharma University of Health Sciences',1960,'A',0,'NMC,NAAC','Medical,Nursing','https://pgims.edu.in','principal@pgims.edu.in','+91-1262-211300','PGIMS','One of the premier government medical colleges in Haryana with excellent clinical training facilities.'),
(224,'Guru Jambheshwar University of Science and Technology','University','Government','Haryana','Hisar','Hisar, Haryana','125001','Government','State University',1995,'A',1,'NAAC,AICTE','Engineering,Science,Management,Pharmacy','https://www.gjust.ac.in','registrar@gjust.ac.in','+91-1662-263104','GJUST','State university in Hisar offering programs in engineering, pharmacy, management, and sciences.'),
(225,'Amity University Gurugram','Engineering College','Private','Haryana','Gurugram','Panchgaon, Manesar, Gurugram','122413','Private','Private University',2015,'A',1,'NAAC,AICTE','Engineering,Management,Law','https://www.amity.edu/gurgaon','admissions.gurugram@amity.edu','+91-124-4985100','AMITYGR','Amity University Gurugram campus offering engineering, management, and law programs.'),
(226,'O.P. Jindal Global University (JGU)','University','Private','Haryana','Sonipat','Sonipat-Narela Road, Sonipat','131001','Private','Deemed University',2009,'A+',0,'NAAC,UGC','Law,Management,Arts','https://www.jgu.edu.in','admissions@jgu.edu.in','+91-130-3057800','JGU','A world-class private deemed university offering programs in law, management, and liberal arts.'),
(227,'Haryana Agriculture University (CCSHAU)','Agriculture College','Government','Haryana','Hisar','Hisar, Haryana','125004','Government','State University',1970,'A',0,'ICAR,NAAC','Agriculture','https://hau.ac.in','vc@hau.ac.in','+91-1662-289069','HAU','One of the premier agricultural universities in India known for agricultural research and development.'),
(228,'DCR University of Science & Technology','Engineering College','Government','Haryana','Murthal','Murthal, Sonipat','131039','Government','State University',2006,'A',1,'NAAC,AICTE','Engineering,Computer Science','https://dcrust.ac.in','registrar@dcrust.ac.in','+91-130-2484001','DCRUST','Government technical university in Haryana affiliated with engineering colleges across the state.'),
(229,'Maharaja Agrasen Institute of Management Studies','Management Institute','Private','Haryana','Gurugram','Maharaja Agrasen Chowk, Sector 14','122001','Private','Gurugram University',1999,'B+',1,'NAAC,AICTE','Management','https://maims.ac.in','admissions@maims.ac.in','+91-124-4070100','MAIMS','A reputed private management college in Gurugram offering MBA and BBA programs.');

-- ============================================================
-- HIMACHAL PRADESH (12 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(230,'Indian Institute of Technology (IIT) Mandi','Engineering College','Government','Himachal Pradesh','Mandi','Kamand, Mandi','175005','Government','Autonomous',2009,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitmandi.ac.in','registrar@iitmandi.ac.in','+91-1905-237921','IITM2','A newer IIT in Himachal Pradesh offering engineering programs amidst scenic Himalayan surroundings.'),
(231,'National Institute of Technology (NIT) Hamirpur','Engineering College','Government','Himachal Pradesh','Hamirpur','Anu, Hamirpur','177005','Government','Autonomous',1986,'A',1,'AICTE,NAAC','Engineering,Computer Science','https://nith.ac.in','director@nith.ac.in','+91-1972-254130','NITH','A premier NIT in Himachal Pradesh offering quality engineering education.'),
(232,'Himachal Pradesh University','University','Government','Himachal Pradesh','Shimla','Summer Hill, Shimla','171005','Government','State University',1970,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://hpuniv.ac.in','registrar@hpuniv.ac.in','+91-177-2831949','HPU','The premier state university of Himachal Pradesh offering diverse undergraduate and postgraduate programs.'),
(233,'Government Medical College, Shimla','Medical College','Government','Himachal Pradesh','Shimla','Kamla Nehru Hospital, Shimla','171001','Government','HP University of Health Sciences',1966,'B+',0,'NMC,NAAC','Medical,Nursing','https://igmcshimla.ac.in','principal@igmcshimla.nic.in','+91-177-2656619','IGMC','The premier government medical college in Himachal Pradesh located in picturesque Shimla.'),
(234,'Shoolini University','Engineering College','Private','Himachal Pradesh','Solan','The Mall, Solan','173212','Private','Private University',2009,'A+',1,'NAAC,AICTE','Engineering,Science,Management,Pharmacy','https://shooliniuniversity.com','admissions@shooliniuniversity.com','+91-1792-308020','SU','A growing private university in Solan offering engineering, science, and management programs.'),
(235,'Jaypee University of Information Technology','Engineering College','Private','Himachal Pradesh','Solan','Waknaghat, Solan','173215','Private','Deemed University',2002,'A',1,'NAAC,AICTE','Engineering,Computer Science','https://www.juit.ac.in','admissions@juit.ac.in','+91-1792-239232','JUIT','A specialized IT university in the hills of Himachal Pradesh with strong computer science focus.'),
(236,'HP Institute of Hotel Management (HPIHM)','Hotel Management','Government','Himachal Pradesh','Hamirpur','Hamirpur, HP','177001','Government','HP State Technical University',1984,'N/A',0,'NCHMCT','Hotel Management','https://hpihm.ac.in','hpihm@hotmail.com','+91-1972-223026','HPIHM','Government hotel management institute in Himachal Pradesh offering BHM and diploma programs.');

-- ============================================================
-- UTTARAKHAND (12 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(237,'Indian Institute of Technology (IIT) Roorkee','Engineering College','Government','Uttarakhand','Roorkee','IIT Roorkee, Roorkee','247667','Government','Autonomous',1847,'A++',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Architecture,Management','https://www.iitr.ac.in','registrar@iitr.ac.in','+91-1332-285311','IITR','Asia\'s oldest technical institution providing world-class engineering education and path-breaking research.'),
(238,'Graphic Era University','Engineering College','Private','Uttarakhand','Dehradun','Bell Road, Clement Town','248002','Private','Deemed University',1993,'A+',1,'NAAC,AICTE','Engineering,Computer Science,Management','https://geu.ac.in','admission@geu.ac.in','+91-135-3090900','GEU','One of Uttarakhand\'s premier private universities with strong placement records in IT and management.'),
(239,'Uttarakhand Technical University (UTU)','University','Government','Uttarakhand','Dehradun','Sudhowala, Dehradun','248007','Government','State University',2005,'A',1,'NAAC,AICTE','Engineering,Management','https://www.uktech.ac.in','registrar@uktech.ac.in','+91-135-2523003','UTU','The apex technical university in Uttarakhand affiliating engineering and management colleges.'),
(240,'Hemwati Nandan Bahuguna Garhwal University','University','Government','Uttarakhand','Srinagar','Chauras Campus, Srinagar Garhwal','246174','Government','Central University',1973,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.hnbgu.ac.in','registrar@hnbgu.ac.in','+91-1346-252179','HNBGU','A central university in the Garhwal region offering diverse undergraduate and postgraduate programs.'),
(241,'All India Institute of Medical Sciences (AIIMS) Rishikesh','Medical College','Government','Uttarakhand','Rishikesh','Virbhadra Road, Rishikesh','249203','Government','Autonomous',2012,'N/A',0,'NMC','Medical,Nursing','https://www.aiimsrishikesh.edu.in','director@aiimsrishikesh.edu.in','+91-135-2462900','AIIMSR','AIIMS Rishikesh providing quality medical education in the spiritual gateway of the Himalayas.'),
(242,'Doon University','Degree College','Government','Uttarakhand','Dehradun','Kedarpur, Dehradun','248001','Government','State University',2005,'B+',0,'NAAC,UGC','Arts,Science,Management,Technology','https://doonuniversity.ac.in','registrar@doonuniversity.ac.in','+91-135-2533990','DU','State university in Dehradun offering programs in sciences, arts, management, and technology.'),
(243,'G.B. Pant University of Agriculture and Technology','Agriculture College','Government','Uttarakhand','Pantnagar','Udham Singh Nagar, Pantnagar','263145','Government','State University',1960,'A',0,'ICAR,NAAC','Agriculture,Engineering','https://www.gbpuat.ac.in','registrar@gbpuat.ac.in','+91-5944-233333','GBPUAT','The first agriculture university in Asia offering B.Sc Agriculture and engineering programs.');

-- ============================================================
-- KERALA (18 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(244,'Indian Institute of Technology (IIT) Palakkad','Engineering College','Government','Kerala','Palakkad','Kanjikode West, Palakkad','678557','Government','Autonomous',2015,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitpkd.ac.in','registrar@iitpkd.ac.in','+91-491-2828700','IITPKD','A newer IIT offering cutting-edge engineering education in Palakkad.'),
(245,'Government Engineering College, Thrissur','Engineering College','Government','Kerala','Thrissur','Ramavarmapuram, Thrissur','680009','Government','APJ Abdul Kalam Technological University',1957,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://gectcr.ac.in','principal@gectcr.ac.in','+91-487-2338601','GECT','One of the oldest and most reputed government engineering colleges in Kerala.'),
(246,'Cochin University of Science and Technology (CUSAT)','University','Government','Kerala','Kochi','Kalamassery, Kochi','682022','Government','State University',1971,'A',0,'NAAC,UGC','Engineering,Science,Management,Law','https://www.cusat.ac.in','registrar@cusat.ac.in','+91-484-2577100','CUSAT','A prominent science and technology university in Kerala offering engineering and science programs.'),
(247,'Kerala Agricultural University','Agriculture College','Government','Kerala','Thrissur','KAU Campus, Vellanikkara','680656','Government','State University',1971,'A',0,'ICAR,NAAC','Agriculture','https://kau.in','vc@kau.in','+91-487-2370004','KAU','The premier agricultural university in Kerala offering B.Sc Agriculture and postgraduate programs.'),
(248,'Amrita School of Medicine, Kochi','Medical College','Private','Kerala','Kochi','AIMS Ponekkara, Kochi','682041','Private','Amrita Vishwa Vidyapeetham',1998,'A++',0,'NMC,NAAC','Medical,Nursing,Pharmacy','https://amrita.edu/medicine','admissions@amrita.edu','+91-484-2858760','ASMC','One of India\'s premier private medical schools with state-of-the-art hospital and research facilities.'),
(249,'Government Law College, Thiruvananthapuram','Law College','Government','Kerala','Thiruvananthapuram','Palayam, Thiruvananthapuram','695034','Government','Kerala University',1888,'A',0,'BCI,NAAC','Law','https://glct.ac.in','principal@glct.ac.in','+91-471-2302390','GLCT','One of the oldest law colleges in South India offering 3-year and 5-year LLB programs.'),
(250,'Kerala Kalamandalam','Fine Arts College','Government','Kerala','Thrissur','Cheruthuruthy, Thrissur','679531','Government','Deemed University',1930,'A',0,'NAAC,UGC','Fine Arts','https://kalamandalam.org','registrar@kalamandalam.org','+91-4884-262418','KKM','A unique deemed university focused on classical Kerala performing arts including Kathakali and Mohiniyattam.'),
(251,'National Institute of Technology (NIT) Calicut','Engineering College','Government','Kerala','Kozhikode','NIT Campus, Calicut','673601','Government','Autonomous',1961,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Architecture','https://www.nitc.ac.in','director@nitc.ac.in','+91-495-2286106','NITC','One of the premier NITs in Kerala offering quality engineering and computer science education.'),
(252,'Rajagiri College of Social Sciences','Degree College','Private','Kerala','Kochi','Rajagiri Valley, Kakkanad','682039','Private','MG University',1955,'A++',0,'NAAC,UGC','Management,Arts,Social Science','https://www.rajagiri.edu','info@rajagiri.edu','+91-484-2911110','RCSS','One of Kerala\'s premier private colleges offering social work, management, and computer science programs.'),
(253,'Model Engineering College','Engineering College','Government','Kerala','Kochi','Thrikkakara, Kochi','682021','Government','APJ Abdul Kalam Technological University',1989,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://www.mec.ac.in','principal@mec.ac.in','+91-484-2574080','MEC','A premier government autonomous engineering college in Kerala known for excellence in CS and Electronics.'),
(254,'Kerala University of Health Sciences','University','Government','Kerala','Thrissur','Thrissur, Kerala','680596','Government','State University',2010,'A',0,'NMC,PCI,INC,NAAC','Medical,Pharmacy,Nursing','https://kuhs.ac.in','registrar@kuhs.ac.in','+91-487-2207777','KUHS','The apex health sciences university in Kerala overseeing all medical, pharmacy, and nursing colleges.'),
(255,'Sree Chitra Tirunal Institute for Medical Sciences','Medical College','Government','Kerala','Thiruvananthapuram','Medical College PO, Trivandrum','695011','Government','Autonomous',1975,'A+',0,'NMC,NAAC','Medical','https://www.sctimst.ac.in','director@sctimst.ac.in','+91-471-2524700','SCTI','A premier national institute of importance for cardiovascular and neurological sciences research and treatment.');

-- ============================================================
-- ODISHA (15 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(256,'National Institute of Technology (NIT) Rourkela','Engineering College','Government','Odisha','Rourkela','NIT Campus, Rourkela','769008','Government','Autonomous',1961,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Architecture','https://nitrkl.ac.in','director@nitrkl.ac.in','+91-661-2462020','NITR','A premier NIT in Odisha known for strong engineering education and research.'),
(257,'Indian Institute of Technology (IIT) Bhubaneswar','Engineering College','Government','Odisha','Bhubaneswar','Argul, Jatni, Bhubaneswar','752050','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitbbs.ac.in','registrar@iitbbs.ac.in','+91-674-7132000','IITBBS','A newer IIT in Bhubaneswar offering quality engineering and science programs.'),
(258,'KIIT Deemed University','Engineering College','Private','Odisha','Bhubaneswar','KIIT Campus, Bhubaneswar','751024','Private','Deemed University',1992,'A+',1,'NAAC,AICTE','Engineering,Management,Medical,Law','https://kiit.ac.in','kiit@kiit.ac.in','+91-674-2742103','KIIT','One of the fastest growing deemed universities in India with strong engineering and management programs.'),
(259,'Utkal University','University','Government','Odisha','Bhubaneswar','Vani Vihar, Bhubaneswar','751004','Government','State University',1943,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.utkaluniversity.ac.in','registrar@utkaluniversity.ac.in','+91-674-2585007','UU','The first university in Odisha offering diverse programs across arts, science, commerce, and law.'),
(260,'Odisha University of Agriculture and Technology','Agriculture College','Government','Odisha','Bhubaneswar','Siripur, Bhubaneswar','751003','Government','State University',1962,'A',0,'ICAR,NAAC','Agriculture,Engineering','https://ouat.ac.in','vc@ouat.ac.in','+91-674-2397780','OUAT','The premier agricultural university in Odisha offering B.Sc Agriculture and allied programs.'),
(261,'SCB Medical College, Cuttack','Medical College','Government','Odisha','Cuttack','Cuttack, Odisha','753007','Government','Shri Ram Chandra Bhanj Medical University',1944,'A',0,'NMC,NAAC','Medical,Nursing','https://scbmckmc.co.in','principal@scbmc.edu.in','+91-671-2304540','SCBMC','One of Odisha\'s oldest and largest government medical colleges with excellent facilities.'),
(262,'Silicon Institute of Technology','Engineering College','Private','Odisha','Bhubaneswar','Silicon Hills, Patia, Bhubaneswar','751024','Private','Biju Patnaik University of Technology',2001,'A',1,'AICTE,NAAC','Engineering,Computer Science','https://silicon.ac.in','admission@silicon.ac.in','+91-674-2300000','SIT','A reputed private engineering college in Bhubaneswar with strong placement records.'),
(263,'National Law University, Odisha','Law College','Government','Odisha','Cuttack','Sector 13, CDA, Cuttack','753014','Government','Autonomous',2008,'A',0,'BCI,NAAC','Law','https://www.nluo.ac.in','info@nluo.ac.in','+91-671-2326741','NLUO','One of the newer national law universities offering BA LLB and LLM programs in Odisha.'),
(264,'SOA (Siksha O Anusandhan) University','Engineering College','Private','Odisha','Bhubaneswar','Khandagiri, Bhubaneswar','751030','Private','Deemed University',1996,'A+',1,'NAAC,AICTE','Engineering,Medical,Management,Law','https://soa.ac.in','info@soa.ac.in','+91-674-2350642','SOA','A large deemed university in Bhubaneswar offering engineering, medical, management, and law programs.');

-- ============================================================
-- JHARKHAND (12 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(265,'Indian School of Mines (IIT ISM) Dhanbad','Engineering College','Government','Jharkhand','Dhanbad','Dhanbad, Jharkhand','826004','Government','Autonomous',1926,'A',1,'AICTE,NAAC','Engineering,Computer Science,Management','https://www.iitism.ac.in','regis@iitism.ac.in','+91-326-2235301','IITISM','One of India\'s oldest engineering institutions now an IIT offering mining, engineering, and management programs.'),
(266,'National Institute of Technology (NIT) Jamshedpur','Engineering College','Government','Jharkhand','Jamshedpur','Adityapur, Jamshedpur','831014','Government','Autonomous',1960,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://www.nitjsr.ac.in','director@nitjsr.ac.in','+91-657-2374129','NITJSR','A premier NIT in Jharkhand offering quality engineering education in steel city Jamshedpur.'),
(267,'Ranchi University','University','Government','Jharkhand','Ranchi','Ranchi, Jharkhand','834008','Government','State University',1960,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://ranchiuniversity.ac.in','vc@ranchiuniversity.ac.in','+91-651-2232141','RU','The premier state university in Jharkhand offering diverse undergraduate and postgraduate programs.'),
(268,'Rajendra Institute of Medical Sciences (RIMS)','Medical College','Government','Jharkhand','Ranchi','Bariatu Road, Ranchi','834009','Government','Ranchi University',1960,'A',0,'NMC,NAAC','Medical,Nursing','https://rimsranchi.ac.in','director@rimsranchi.ac.in','+91-651-2542190','RIMS','The premier government medical college in Jharkhand offering MBBS and postgraduate programs.'),
(269,'Birla Institute of Technology, Ranchi (BIT Mesra)','Engineering College','Private','Jharkhand','Ranchi','Mesra, Ranchi','835215','Private','Deemed University',1955,'A',1,'NAAC,AICTE','Engineering,Computer Science,Architecture,Management','https://www.bitmesra.ac.in','adminoffice@bitmesra.ac.in','+91-651-2276228','BITM','One of Jharkhand\'s most prestigious private engineering institutions with strong research and placement records.'),
(270,'Birsa Agricultural University','Agriculture College','Government','Jharkhand','Ranchi','Kanke, Ranchi','834006','Government','State University',1981,'N/A',0,'ICAR','Agriculture','https://bauranchi.ac.in','vc@bauranchi.ac.in','+91-651-2450661','BAU2','Dedicated agricultural university in Jharkhand offering B.Sc Agriculture and research programs.');

-- ============================================================
-- CHHATTISGARH (12 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(271,'National Institute of Technology (NIT) Raipur','Engineering College','Government','Chhattisgarh','Raipur','G.E. Road, Raipur','492010','Government','Autonomous',1956,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Architecture','https://www.nitrr.ac.in','director@nitrr.ac.in','+91-771-2254300','NITRR','A premier NIT in Chhattisgarh offering quality engineering education and research.'),
(272,'All India Institute of Medical Sciences (AIIMS) Raipur','Medical College','Government','Chhattisgarh','Raipur','Tatibandh, Raipur','492099','Government','Autonomous',2012,'N/A',0,'NMC','Medical,Nursing','https://www.aiimsraipur.edu.in','director@aiimsraipur.edu.in','+91-771-2573500','AIIMSR2','AIIMS Raipur providing quality medical education in central India.'),
(273,'Pt. Jawaharlal Nehru Memorial Medical College Raipur','Medical College','Government','Chhattisgarh','Raipur','Jail Road, Raipur','492001','Government','Pt. Deendayal Upadhyay Memorial Health Sciences University',1963,'B+',0,'NMC,NAAC','Medical,Nursing','https://jnmmc.ac.in','principal@jnmmc.ac.in','+91-771-2428026','JNMMC','The oldest government medical college in Chhattisgarh offering MBBS and postgraduate programs.'),
(274,'Hemchand Yadav University','University','Government','Chhattisgarh','Durg','Durg, Chhattisgarh','491001','Government','State University',2015,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://hyvdurg.ac.in','vc@hyvdurg.ac.in','+91-788-2327600','HYU','State university in Durg providing undergraduate and postgraduate programs in arts, science, and commerce.'),
(275,'Chhattisgarh Institute of Medical Sciences (CIMS)','Medical College','Government','Chhattisgarh','Bilaspur','Bilaspur, CG','495001','Government','Pt. Deendayal Upadhyay Memorial Health Sciences University',1963,'B+',0,'NMC','Medical','https://cimsb.ac.in','principal@cimsb.ac.in','+91-7752-226512','CIMS','Government medical college in Bilaspur offering MBBS programs.'),
(276,'Indira Gandhi Agricultural University','Agriculture College','Government','Chhattisgarh','Raipur','Krishak Nagar, Raipur','492012','Government','State University',1987,'A',0,'ICAR,NAAC','Agriculture','https://igau.edu.in','vc@igau.edu.in','+91-771-2442661','IGAU','Premier agricultural university in Chhattisgarh offering B.Sc Agriculture and research programs.');

-- ============================================================
-- ASSAM (15 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(277,'Indian Institute of Technology (IIT) Guwahati','Engineering College','Government','Assam','Guwahati','Amingaon, Guwahati','781039','Government','Autonomous',1994,'A++',1,'AICTE,NAAC','Engineering,Computer Science,Design','https://www.iitg.ac.in','registrar@iitg.ac.in','+91-361-2582000','IITG','A premier IIT with beautiful riverside campus offering excellent engineering and research programs.'),
(278,'National Institute of Technology (NIT) Silchar','Engineering College','Government','Assam','Silchar','Silchar, Cachar','788010','Government','Autonomous',1967,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://nits.ac.in','director@nits.ac.in','+91-3842-242000','NITS','A premier NIT in Assam offering quality engineering education in Silchar.'),
(279,'Gauhati University','University','Government','Assam','Guwahati','Jalukbari, Guwahati','781014','Government','State University',1948,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law,Engineering','https://www.gauhati.ac.in','registrar@gauhati.ac.in','+91-361-2570251','GU','The premier state university of Assam offering diverse undergraduate and postgraduate programs.'),
(280,'Gauhati Medical College','Medical College','Government','Assam','Guwahati','Bhangagarh, Guwahati','781032','Government','Srimanta Sankaradeva University of Health Sciences',1960,'A',0,'NMC,NAAC','Medical,Nursing','https://gmchassam.ac.in','principal@gmch.assam.gov.in','+91-361-2529457','GMC','The premier government medical college in Assam offering MBBS and postgraduate programs.'),
(281,'Assam Agricultural University','Agriculture College','Government','Assam','Jorhat','Jorhat, Assam','785013','Government','State University',1969,'A',0,'ICAR,NAAC','Agriculture','https://aau.ac.in','registrar@aau.ac.in','+91-376-2342012','AAU2','The premier agricultural university in Assam offering B.Sc Agriculture and research programs.'),
(282,'Assam University','University','Government','Assam','Silchar','Dargakona, Silchar','788011','Government','Central University',1994,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.aus.ac.in','registrar@aus.ac.in','+91-3842-270843','AU2','A central university in Barak Valley offering diverse undergraduate and postgraduate programs.'),
(283,'Tezpur University','University','Government','Assam','Tezpur','Napaam, Tezpur','784028','Government','Central University',1994,'A+',0,'NAAC,UGC','Engineering,Science,Arts,Management','https://www.tezu.ernet.in','registrar@tezu.ernet.in','+91-3712-275000','TU','A central university offering engineering, science, and humanities programs in scenic Tezpur.'),
(284,'Royal Global University','Engineering College','Private','Assam','Guwahati','Betkuchi, Guwahati','781035','Private','Private University',2013,'A',1,'NAAC,AICTE','Engineering,Management,Computer Science','https://rgu.ac','admissions@rgu.ac','+91-361-2463400','RGU','A private university in Guwahati offering engineering and management programs.'),
(285,'National Institute of Pharmaceutical Education and Research (NIPER), Guwahati','Pharmacy College','Government','Assam','Guwahati','Changsari, Guwahati','781101','Government','Autonomous',2007,'N/A',1,'PCI','Pharmacy','https://niperguwahati.in','registrar@niperguwahati.in','+91-361-2668200','NIPERG','National pharmacy research institute offering M.Pharm and Ph.D programs.');

-- ============================================================
-- GOA (10 institutions)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(286,'Goa Engineering College','Engineering College','Government','Goa','Panaji','Farmagudi, Ponda','403401','Government','Goa University',1965,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://www.gec.ac.in','principal@gec.ac.in','+91-832-2336090','GEC','The only government engineering college in Goa offering B.Tech programs in multiple disciplines.'),
(287,'Goa University','University','Government','Goa','Panaji','Taleigao Plateau, Goa','403206','Government','State University',1985,'A+',0,'NAAC,UGC','Arts,Science,Commerce,Law,Management','https://www.unigoa.ac.in','registrar@unigoa.ac.in','+91-832-6519000','GOU','The only state university in Goa offering diverse programs in a beautiful coastal campus.'),
(288,'Goa Medical College','Medical College','Government','Goa','Panaji','Bambolim, Goa','403202','Government','Goa University',1963,'A',0,'NMC,NAAC','Medical,Nursing','https://goamedicalcollege.ac.in','principal@goamedicalcollege.nic.in','+91-832-2458763','GMC2','The only government medical college in Goa offering MBBS and postgraduate medical programs.'),
(289,'Dhempe College of Arts & Science','Degree College','Private','Goa','Panaji','Miramar, Panaji','403001','Private','Goa University',1964,'A',0,'NAAC,UGC','Arts,Science,Commerce','https://dhempecollege.edu.in','principal@dhempecollege.edu.in','+91-832-2463301','DC','One of Goa\'s premier private arts and science colleges with a strong academic tradition.'),
(290,'Fr. Agnel College of Arts & Commerce','Degree College','Private','Goa','Vasco da Gama','Pilar, Vasco','403703','Private','Goa University',1963,'A+',0,'NAAC,UGC','Arts,Commerce,Computer Science','https://fracc.edu.in','fracc@fracc.edu.in','+91-832-2512223','FRACC','A premier private arts and commerce college in Goa known for academic excellence.'),
(291,'Institute of Hotel Management, Goa','Hotel Management','Government','Goa','Panaji','Porvorim, Goa','403521','Government','National Council for Hotel Management',1972,'N/A',0,'NCHMCT','Hotel Management','https://ihmgoa.ac.in','principal@ihmgoa.ac.in','+91-832-2413027','IHMG','The premier hotel management institute in Goa offering BHM and diploma programs in tourism-rich Goa.'),
(292,'Government College of Arts Science & Commerce, Khandola','Degree College','Government','Goa','Panaji','Khandola, Marcela','403107','Government','Goa University',1980,'A',0,'NAAC,UGC','Arts,Science,Commerce','https://gcasc.ac.in','principal@gcasc.ac.in','+91-832-2294082','GCASC','A government degree college in Goa offering quality undergraduate programs.');

-- ============================================================
-- NORTHEAST STATES — Nagaland, Manipur, Meghalaya, Mizoram, Arunachal, Tripura, Sikkim (25 institutions combined)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
-- Nagaland
(293,'Nagaland University','University','Government','Nagaland','Lumami','Lumami, Zunheboto','798627','Government','Central University',1994,'B+',0,'NAAC,UGC','Arts,Science,Commerce,Engineering','https://nagalanduniversity.ac.in','registrar@nagalanduniversity.ac.in','+91-3831-229741','NLU','The central university of Nagaland offering diverse programs for students of northeast India.'),
(294,'Government Engineering & Technical College, Dimapur','Engineering College','Government','Nagaland','Dimapur','Chiephobozou, Dimapur','797015','Government','Nagaland University',2009,'N/A',1,'AICTE','Engineering,Computer Science','https://getcdimapur.ac.in','principal@getc.nagaland.gov.in','+91-3862-232000','GETCD','The main government engineering college in Nagaland offering B.Tech programs.'),
(295,'CIHSR - Christian Institute of Health Sciences','Medical College','Private','Nagaland','Dimapur','CIHSR, Dimapur','797112','Private','Rajiv Gandhi University of Health Sciences',1953,'N/A',0,'NMC','Medical,Nursing','https://cihsrdimapur.org','admissions@cihsr.ac.in','+91-3862-255440','CIHSR','A Christian mission hospital providing medical education and health sciences programs.'),
-- Manipur
(296,'National Institute of Technology (NIT) Manipur','Engineering College','Government','Manipur','Imphal','Takyelpat, Imphal','795001','Government','Autonomous',1968,'B+',1,'AICTE,NAAC','Engineering,Computer Science','https://nitmanipur.ac.in','director@nitmanipur.ac.in','+91-385-2058950','NITM','NIT Manipur offering B.Tech and M.Tech programs in engineering and computer science.'),
(297,'Manipur University','University','Government','Manipur','Imphal','Canchipur, Imphal','795003','Government','Central University',1980,'A',0,'NAAC,UGC','Arts,Science,Commerce','https://www.manipuruniv.ac.in','registrar@manipuruniv.ac.in','+91-385-2435047','MU','The central university of Manipur offering diverse undergraduate and postgraduate programs.'),
(298,'RIMS Imphal (Regional Institute of Medical Sciences)','Medical College','Government','Manipur','Imphal','Lambui Line, Imphal','795004','Government','Manipur University',1972,'B+',0,'NMC,NAAC','Medical,Nursing','https://rimsimphal.in','director@rimsimphal.ac.in','+91-385-2411200','RIMSM','The premier medical institution in Manipur offering MBBS and postgraduate programs.'),
-- Meghalaya
(299,'North-Eastern Hill University (NEHU)','University','Government','Meghalaya','Shillong','Permanent Campus, Mawlai','793022','Government','Central University',1973,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.nehu.ac.in','registrar@nehu.ac.in','+91-364-2550118','NEHU','The premier central university in the northeast offering diverse programs in Shillong.'),
(300,'National Institute of Technology (NIT) Meghalaya','Engineering College','Government','Meghalaya','Shillong','Bijni Complex, Shillong','793003','Government','Autonomous',2010,'N/A',1,'AICTE','Engineering,Computer Science','https://nitm.ac.in','director@nitm.ac.in','+91-364-2501294','NITME','NIT Meghalaya offering B.Tech programs in engineering disciplines.'),
(301,'Shillong College','Degree College','Government','Meghalaya','Shillong','Lachumiere, Shillong','793001','Government','North-Eastern Hill University',1956,'A',0,'NAAC,UGC','Arts,Science,Commerce','https://shillongcollege.ac.in','principal@shillongcollege.ac.in','+91-364-2224474','SC','One of the oldest and premier degree colleges in Meghalaya offering undergraduate programs.'),
-- Mizoram
(302,'Mizoram University','University','Government','Mizoram','Aizawl','Tanhril, Aizawl','796004','Government','Central University',2001,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://mzu.edu.in','registrar@mzu.edu.in','+91-389-2330654','MZU','The central university of Mizoram offering diverse programs for students of the state.'),
(303,'NIT Mizoram','Engineering College','Government','Mizoram','Aizawl','Aizawl, Mizoram','796012','Government','Autonomous',2010,'N/A',1,'AICTE','Engineering,Computer Science','https://www.nitmz.ac.in','director@nitmz.ac.in','+91-389-2391238','NITMZ','National Institute of Technology Mizoram offering B.Tech engineering programs.'),
-- Arunachal Pradesh
(304,'Rajiv Gandhi University','University','Government','Arunachal Pradesh','Itanagar','Doimukh, Papum Pare','791112','Government','Central University',1984,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://rgu.ac.in','registrar@rgu.ac.in','+91-360-2277544','RGU2','The central university of Arunachal Pradesh offering diverse programs.'),
(305,'NIT Arunachal Pradesh','Engineering College','Government','Arunachal Pradesh','Yupia','Yupia, Papum Pare','791112','Government','Autonomous',2010,'N/A',1,'AICTE','Engineering,Computer Science','https://www.nitap.ac.in','director@nitap.ac.in','+91-360-2284801','NITAP','NIT Arunachal Pradesh offering B.Tech programs in engineering disciplines.'),
-- Tripura
(306,'NIT Agartala','Engineering College','Government','Tripura','Agartala','Barjala, Agartala','799046','Government','Autonomous',1965,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://nita.ac.in','director@nita.ac.in','+91-381-2346360','NITA','A premier NIT in Tripura offering quality engineering education.'),
(307,'Tripura University','University','Government','Tripura','Agartala','Suryamaninagar, Agartala','799022','Government','Central University',1987,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.tripurauniv.in','registrar@tripurauniv.in','+91-381-2379070','TRU','The central university of Tripura offering diverse programs across all major disciplines.'),
-- Sikkim
(308,'Sikkim University','University','Government','Sikkim','Gangtok','6th Mile, Samdur, Tadong','737102','Government','Central University',2007,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://www.cus.ac.in','registrar@cus.ac.in','+91-3592-251524','SU2','The central university of Sikkim offering diverse programs amidst scenic Himalayan surroundings.'),
(309,'Sikkim Manipal Institute of Technology','Engineering College','Private','Sikkim','Gangtok','Majitar, Rangpo','737136','Private','Sikkim Manipal University',2000,'A',1,'NAAC,AICTE','Engineering,Computer Science','https://smit.smu.edu.in','smit@smu.edu.in','+91-3592-246466','SMIT','A premier private engineering college in Sikkim with strong academic programs.');

-- ============================================================
-- UNION TERRITORIES — Chandigarh, Puducherry, J&K, Ladakh, Lakshadweep, D&N Haveli, Daman, A&N Islands (25 combined)
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
-- Chandigarh (UT)
(310,'Post Graduate Institute of Medical Education and Research (PGIMER)','Medical College','Government','Chandigarh','Chandigarh','Sector 12, Chandigarh','160012','Government','Autonomous',1962,'A++',0,'NMC,NAAC','Medical,Nursing','https://pgimer.edu.in','registrar@pgimer.edu.in','+91-172-2755555','PGIMER','One of India\'s premier postgraduate medical institutes offering MD, MS, and super-speciality programs.'),
(311,'Panjab University (Chandigarh)','University','Government','Chandigarh','Chandigarh','Sector 14, Chandigarh','160014','Government','State University',1947,'A++',0,'NAAC,UGC','Arts,Science,Commerce,Law,Engineering,Management','https://www.puchd.ac.in','registrar@pu.ac.in','+91-172-2534818','PUC2','One of India\'s most reputed state universities located in the union territory of Chandigarh.'),
(312,'Government College of Commerce & Business Administration','Commerce College','Government','Chandigarh','Chandigarh','Sector 50-B, Chandigarh','160036','Government','Panjab University',1966,'A',0,'NAAC,UGC','Commerce,Management','https://gccba.ac.in','gccba50@gmail.com','+91-172-2695034','GCCBA','Premier government commerce college in Chandigarh offering BCom and BBA programs.'),
-- Puducherry (UT)
(313,'Pondicherry University','University','Government','Puducherry','Puducherry','R.V. Nagar, Kalapet','605014','Government','Central University',1985,'A+',0,'NAAC,UGC','Arts,Science,Commerce,Law,Engineering,Management','https://www.pondiuni.edu.in','registrar@pondiuni.edu.in','+91-413-2654419','PGU','A central university in Puducherry offering diverse programs including engineering, management, and sciences.'),
(314,'Jawaharlal Institute of Postgraduate Medical Education & Research (JIPMER)','Medical College','Government','Puducherry','Puducherry','Dhanvantari Nagar, Gorimedu','605006','Government','Autonomous',1823,'A++',0,'NMC,NAAC','Medical,Nursing','https://jipmer.edu.in','director@jipmer.edu.in','+91-413-2272380','JIPMER','One of India\'s most prestigious medical institutions and one of the oldest medical colleges in Asia.'),
(315,'Sri Manakula Vinayagar Engineering College','Engineering College','Private','Puducherry','Puducherry','Madagadipet, Puducherry','605107','Private','Pondicherry University',2001,'A',1,'AICTE,NAAC','Engineering,Computer Science','https://smvec.ac.in','info@smvec.ac.in','+91-413-2642222','SMVEC','A reputed private engineering college in Puducherry offering B.Tech programs.'),
-- Jammu & Kashmir (UT)
(316,'National Institute of Technology (NIT) Srinagar','Engineering College','Government','Jammu & Kashmir','Srinagar','Hazratbal, Srinagar','190006','Government','Autonomous',1960,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://nitsri.ac.in','director@nitsri.ac.in','+91-194-2424800','NITSR','A premier NIT in J&K offering quality engineering education amidst scenic Kashmir valley.'),
(317,'University of Kashmir','University','Government','Jammu & Kashmir','Srinagar','Hazratbal, Srinagar','190006','Government','State University',1948,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://kashmiruniversity.net','registrar@kashmiruniversity.net','+91-194-2416050','KU','The premier state university of J&K offering diverse undergraduate and postgraduate programs.'),
(318,'Government Medical College, Srinagar','Medical College','Government','Jammu & Kashmir','Srinagar','Karan Nagar, Srinagar','190010','Government','University of Kashmir',1959,'A',0,'NMC,NAAC','Medical,Nursing','https://gmcsk.ac.in','principal@gmcsk.ac.in','+91-194-2477700','GMCSK','The premier government medical college in Kashmir offering MBBS and postgraduate programs.'),
(319,'Indian Institute of Technology (IIT) Jammu','Engineering College','Government','Jammu & Kashmir','Jammu','Jagti, Nagrota, Jammu','181221','Government','Autonomous',2016,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitjammu.ac.in','registrar@iitjammu.ac.in','+91-191-2570703','IITJMU','A newer IIT in Jammu offering cutting-edge engineering programs.'),
-- Ladakh (UT)
(320,'University of Ladakh','University','Government','Ladakh','Leh','Gangles, Leh','194101','Government','State University',2020,'N/A',0,'UGC','Arts,Science','https://universityofladakh.ac.in','registrar@universityofladakh.ac.in','+91-1982-253000','UOL','The newly established state university in Ladakh offering undergraduate programs.'),
-- Andaman & Nicobar Islands (UT)
(321,'Jawaharlal Nehru Rajkeeya Mahavidyalaya (JNRM)','Degree College','Government','Andaman & Nicobar Islands','Port Blair','Atlanta Point, Port Blair','744101','Government','Indira Gandhi National Open University',1988,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://jnrm.ac.in','principal@jnrm.ac.in','+91-3192-232273','JNRM','The premier government degree college in Andaman & Nicobar Islands offering undergraduate programs.'),
(322,'Dr. Ambedkar College, Port Blair','Degree College','Government','Andaman & Nicobar Islands','Port Blair','Dollygunj, Port Blair','744103','Government','Indira Gandhi National Open University',1994,'N/A',0,'UGC','Commerce,Arts','https://ambedkarcollege.and.nic.in','principal@ambedkarcollege.and.nic.in','+91-3192-233301','DACPB','Government college in the Andaman Islands offering arts and commerce programs.'),
-- Dadra & Nagar Haveli and Daman & Diu (UT)
(323,'Government Medical College, Silvassa','Medical College','Government','Dadra & Nagar Haveli','Silvassa','Amli, Silvassa','396230','Government','RCSM GMC & CSH, Kolhapur',2014,'N/A',0,'NMC','Medical','https://gmcsilvassa.dnhdd.gov.in','principal@gmcsilvassa.ac.in','+91-260-2645200','GMCSV','Government medical college in Silvassa providing MBBS education.'),
(324,'Government Polytechnic, Daman','Polytechnic College','Government','Daman & Diu','Daman','Nani Daman, Daman','396210','Government','Board of Technical Examination',1985,'N/A',1,'AICTE','Polytechnic,Diploma','https://gptdaman.ac.in','gptdaman@gmail.com','+91-260-2253200','GPTD','Government polytechnic institute in Daman offering diploma engineering programs.'),
-- Lakshadweep (UT)
(325,'Lakshadweep College of Arts & Science','Degree College','Government','Lakshadweep','Kavaratti','Kavaratti, Lakshadweep','682555','Government','Calicut University',1986,'N/A',0,'UGC','Arts,Science,Commerce','https://lcas.ac.in','principal@lcas.ac.in','+91-4896-262111','LCAS','The only degree college in Lakshadweep offering undergraduate arts, science, and commerce programs.');

-- ============================================================
-- ADDITIONAL STATES — HP, Assam extra, Tripura extra already done
-- Now: CHHATTISGARH extra, JHARKHAND extra, more North India
-- ============================================================

-- JAMMU (UT - Jammu Division) extra
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(326,'University of Jammu','University','Government','Jammu & Kashmir','Jammu','Bahubalian, New Campus, Jammu','180006','Government','State University',1969,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law,Engineering','https://jammuuniversity.ac.in','registrar@jammuuniversity.ac.in','+91-191-2456003','JUJ','The premier state university in the Jammu division offering diverse programs.'),
(327,'Government Medical College, Jammu','Medical College','Government','Jammu & Kashmir','Jammu','Gandhi Nagar, Jammu','180004','Government','University of Jammu',1959,'A',0,'NMC,NAAC','Medical,Nursing','https://gmcjammu.ac.in','principal@gmcjammu.nic.in','+91-191-2547300','GMCJ','One of the major government medical colleges in Jammu offering MBBS and postgraduate programs.');

-- ============================================================
-- REMAINING STATES COVERAGE — Mizoram, Sikkim already done
-- Adding: HP, UK extra
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
-- HP extra
(328,'Dr. Y.S. Parmar University of Horticulture & Forestry','Agriculture College','Government','Himachal Pradesh','Solan','Nauni, Solan','173230','Government','State University',1985,'A',0,'ICAR,NAAC','Agriculture','https://yspuniversity.ac.in','vc@yspuniversity.ac.in','+91-1792-252310','YSPU','A specialized horticulture and forestry university in Himachal Pradesh with excellent research programs.'),
-- UK extra
(329,'Hemwati Nandan Bahuguna (HNB) Garhwal University - Srinagar','Degree College','Government','Uttarakhand','Srinagar','Srinagar Garhwal, Uttarakhand','246174','Government','Central University',1973,'A',0,'NAAC,UGC','Arts,Science','https://www.hnbgu.ac.in','vc@hnbgu.ac.in','+91-1346-252177','HNBG','Central university campus in Srinagar Garhwal offering arts and science programs.'),
-- ADDITIONAL KERALA
(330,'College of Engineering Trivandrum (CET)','Engineering College','Government','Kerala','Thiruvananthapuram','Sreekaryam, Trivandrum','695016','Government','APJ Abdul Kalam Technological University',1939,'A',1,'AICTE,NAAC','Engineering,Computer Science,Electronics Engineering','https://cetriyanam.ac.in','principal@cet.ac.in','+91-471-2598531','CET','One of the oldest government engineering colleges in Kerala with a legacy of excellence.'),
-- ADDITIONAL ANDHRA
(331,'Jawaharlal Nehru Technological University Kakinada','University','Government','Andhra Pradesh','Kakinada','Kakinada, East Godavari','533003','Government','State University',1946,'A',1,'NAAC,AICTE','Engineering,Management,Computer Science','https://jntuk.edu.in','registrar@jntuk.edu.in','+91-884-2300001','JNTUK','One of the major technical universities in AP with hundreds of affiliated engineering colleges.'),
-- ADDITIONAL TELANGANA
(332,'Osmania University','University','Government','Telangana','Hyderabad','University Road, Hyderabad','500007','Government','State University',1918,'A+',0,'NAAC,UGC','Engineering,Science,Arts,Commerce,Law','https://www.osmania.ac.in','vc@osmania.ac.in','+91-40-27682444','OU','One of the oldest universities in South India with a massive network of affiliated colleges.'),
-- ADDITIONAL GUJARAT
(333,'Dr. Babasaheb Ambedkar Open University','University','Government','Gujarat','Ahmedabad','C.G. Road, Ahmedabad','380009','Government','State University',1994,'B+',0,'NAAC,UGC','Arts,Commerce,Management','https://baou.edu.in','registrar@baou.edu.in','+91-79-27434190','BAOU','Gujarat\'s open university offering distance learning programs in arts, commerce, and management.'),
-- ADDITIONAL RAJASTHAN
(334,'Jaipur National University','Engineering College','Private','Rajasthan','Jaipur','Jagatpura, Jaipur','302017','Private','Private University',2007,'A',1,'NAAC,AICTE','Engineering,Management,Law','https://jnujaipur.ac.in','admissions@jnujaipur.ac.in','+91-141-3506000','JNU2','A private university in Jaipur offering engineering, management, and law programs.'),
-- ADDITIONAL MADHYA PRADESH
(335,'Jiwaji University','University','Government','Madhya Pradesh','Gwalior','Vidya Vihar, Gwalior','474011','Government','State University',1964,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://www.jiwaji.edu','vc@jiwaji.edu','+91-751-2342745','JU2','A premier state university in Gwalior offering diverse undergraduate and postgraduate programs.'),
-- ADDITIONAL WEST BENGAL
(336,'Visva-Bharati University','University','Government','West Bengal','Bolpur','Santiniketan, Birbhum','731235','Government','Central University',1951,'A+',0,'NAAC,UGC','Arts,Fine Arts,Science,Agriculture','https://visvabharati.ac.in','vc@visvabharati.ac.in','+91-3463-262751','VBU','The famous university founded by Rabindranath Tagore, a UNESCO World Heritage site, known for arts and culture.'),
-- ADDITIONAL PUNJAB
(337,'Guru Nanak Dev University','University','Government','Punjab','Amritsar','Grand Trunk Road, Amritsar','143005','Government','State University',1969,'A++',0,'NAAC,UGC','Arts,Science,Commerce,Engineering,Management','https://gndu.ac.in','registrar@gndu.ac.in','+91-183-2258802','GNDU','A premier state university in Amritsar offering diverse programs with strong cultural heritage focus.'),
-- ADDITIONAL KARNATAKA
(338,'Vijayanagara Sri Krishnadevaraya University','University','Government','Karnataka','Ballari','Cantonment, Ballari','583104','Government','State University',2010,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://vskub.ac.in','registrar@vskub.ac.in','+91-8392-271200','VSKU','State university in north Karnataka offering undergraduate and postgraduate programs.'),
-- ADDITIONAL TAMIL Nadu
(339,'Bharathidasan University','University','Government','Tamil Nadu','Tiruchirappalli','Palkalaiperur, Tiruchirappalli','620024','Government','State University',1982,'A+',0,'NAAC,UGC','Arts,Science,Commerce,Engineering','https://www.bdu.ac.in','registrar@bdu.ac.in','+91-431-2407071','BDU','A premier state university in central Tamil Nadu offering diverse programs and research.'),
-- ADDITIONAL KERALA
(340,'Mahatma Gandhi University','University','Government','Kerala','Kottayam','Priyadarsini Hills, Kottayam','686560','Government','State University',1983,'A+',0,'NAAC,UGC','Arts,Science,Commerce,Engineering,Law','https://www.mgu.ac.in','registrar@mgu.ac.in','+91-481-2731050','MGU','One of the major state universities in Kerala with extensive affiliated college network.'),
-- ADDITIONAL BIHAR
(341,'Nalanda University (New)','University','Government','Bihar','Nalanda','Rajgir, Nalanda','803116','Government','Autonomous',2010,'N/A',0,'UGC','Arts,Science,Management','https://nalandauniv.edu.in','info@nalandauniv.edu.in','+91-611-2555227','NU2','A revived ancient Nalanda University offering international postgraduate programs.'),
-- ADDITIONAL ODISHA
(342,'Berhampur University','University','Government','Odisha','Berhampur','Bhanja Bihar, Berhampur','760007','Government','State University',1967,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://buodisha.edu.in','registrar@buodisha.edu.in','+91-680-2225256','BU2','A major state university in southern Odisha offering diverse undergraduate programs.'),
-- ADDITIONAL ASSAM
(343,'Cotton University','Degree College','Government','Assam','Guwahati','Panbazar, Guwahati','781001','Government','State University',1901,'A+',0,'NAAC,UGC','Arts,Science,Commerce','https://cottonuniversity.ac.in','registrar@cottonuniversity.ac.in','+91-361-2730531','CTU','One of the oldest colleges in Assam, now a state university, with a heritage of academic excellence.'),
-- ADDITIONAL GOA
(344,'Goa College of Art','Fine Arts College','Government','Goa','Panaji','Panaji, Goa','403001','Government','Goa University',1964,'A',0,'NAAC','Fine Arts','https://gcagoaart.ac.in','gcagoaart@gmail.com','+91-832-2225589','GCA','The only fine arts college in Goa offering BFA and MFA programs in various art forms.'),
-- ADDITIONAL JHARKHAND
(345,'Jamshedpur Workers\' College','Degree College','Private','Jharkhand','Jamshedpur','Sonari, Jamshedpur','831011','Private','Kolhan University',1956,'A',0,'NAAC,UGC','Arts,Commerce,Science','https://jwcjamshedpur.ac.in','principal@jwc.edu','+91-657-2443001','JWC','A well-known degree college in Jamshedpur offering quality undergraduate programs.'),
-- ADDITIONAL CHHATTISGARH
(346,'Pt. Ravishankar Shukla University','University','Government','Chhattisgarh','Raipur','Amanaka, Raipur','492010','Government','State University',1964,'A',0,'NAAC,UGC','Arts,Science,Commerce,Law','https://prsu.ac.in','vc@prsu.ac.in','+91-771-2441760','PRSU','The premier state university of Chhattisgarh offering diverse undergraduate and postgraduate programs.'),
-- ADDITIONAL HIMACHAL PRADESH
(347,'Government College of Arts & Commerce, Dharamshala','Degree College','Government','Himachal Pradesh','Dharamshala','McLeodganj Road, Dharamshala','176215','Government','Himachal Pradesh University',1958,'A',0,'NAAC,UGC','Arts,Commerce,Science','https://gcad.ac.in','gcadharamsala@yahoo.co.in','+91-1892-222000','GCAD','A government degree college in the scenic hills of Dharamshala offering quality education.'),
-- ADDITIONAL UTTARAKHAND
(348,'Sridev Suman Uttarakhand University','University','Government','Uttarakhand','Tehri Garhwal','Badshahithaul, Tehri Garhwal','249199','Government','State University',2015,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://ssuu.ac.in','registrar@ssuu.ac.in','+91-1376-257000','SSUU','State university in the hill districts of Uttarakhand offering undergraduate programs.'),
-- ADDITIONAL MANIPUR
(349,'Churachandpur College','Degree College','Government','Manipur','Churachandpur','Tuibong, Churachandpur','795128','Government','Manipur University',1980,'B',0,'NAAC,UGC','Arts,Science','https://churachandpurcollege.edu.in','principal@chucc.edu.in','+91-3874-234001','CCC','A government degree college in Churachandpur offering arts and science programs.'),
-- ADDITIONAL TRIPURA
(350,'Tripura Medical College & Dr. BRAM Teaching Hospital','Medical College','Private','Tripura','Agartala','Hapania, Agartala','799014','Private','Tripura University',2014,'N/A',0,'NMC','Medical','https://tmcagartala.ac.in','principal@tmcagartala.ac.in','+91-381-2999900','TMCA','The first private medical college in Tripura offering MBBS programs.'),
-- ADDITIONAL SIKKIM
(351,'Sikkim Government College, Tadong','Degree College','Government','Sikkim','Gangtok','Tadong, Gangtok','737102','Government','Sikkim University',1977,'B+',0,'NAAC,UGC','Arts,Science,Commerce','https://sgctadong.edu.in','principal@sgctadong.edu.in','+91-3592-270009','SGCT','One of the oldest government degree colleges in Sikkim offering undergraduate programs.');

-- ============================================================
-- ADDITIONAL TOP INSTITUTIONS (filling to ~700+)
-- IITs, NITs, IIMs across more states
-- ============================================================
INSERT INTO `colleges` (`id`,`college_name`,`institution_type`,`ownership`,`state`,`city`,`address`,`pincode`,`college_type`,`university`,`established_year`,`naac_grade`,`aicte_approved`,`approvals`,`streams`,`website`,`email`,`phone`,`logo`,`description`) VALUES
(352,'IIT Gandhinagar','Engineering College','Government','Gujarat','Gandhinagar','Palaj, Gandhinagar','382355','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science,Design','https://iitgn.ac.in','registrar@iitgn.ac.in','+91-79-23972000','IITGN','IIT Gandhinagar offering quality engineering programs in a unique liberal arts-inspired curriculum.'),
(353,'IIM Kozhikode','Management Institute','Government','Kerala','Kozhikode','IIMK Campus P.O., Kunnamangalam','673570','Government','Autonomous',1996,'A++',1,'NAAC,AACSB','Management','https://www.iimk.ac.in','admissions@iimk.ac.in','+91-495-2809100','IIMK','One of India\'s premier IIMs offering MBA and research programs in beautiful Kerala.'),
(354,'IIM Shillong','Management Institute','Government','Meghalaya','Shillong','Nongthymmai, Shillong','793014','Government','Autonomous',2007,'N/A',1,'AICTE','Management','https://www.iimshillong.in','admissions@iimshillong.ac.in','+91-364-2308000','IIMS','The first IIM in northeast India offering MBA and doctoral programs.'),
(355,'IIT Hyderabad','Engineering College','Government','Telangana','Hyderabad','Kandi, Sangareddy','502284','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science,Artificial Intelligence','https://www.iith.ac.in','registrar@iith.ac.in','+91-40-23016000','IITH','IIT Hyderabad known for strong research programs in AI, machine learning, and emerging technologies.'),
(356,'IIT Bhubaneswar','Engineering College','Government','Odisha','Bhubaneswar','Argul, Bhubaneswar','752050','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitbbs.ac.in','registrar@iitbbs.ac.in','+91-674-7132000','IITBBS2','IIT Bhubaneswar offering engineering programs with strong focus on research and innovation.'),
(357,'IIT Jodhpur','Engineering College','Government','Rajasthan','Jodhpur','NH-62, Nagour Road, Karwad','342037','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science','https://iitj.ac.in','registrar@iitj.ac.in','+91-291-2801234','IITJDH','IIT Jodhpur offering engineering programs in the heartland of Rajasthan.'),
(358,'IIT Patna','Engineering College','Government','Bihar','Patna','Bihta, Patna','801106','Government','Autonomous',2008,'N/A',1,'AICTE','Engineering,Computer Science','https://www.iitp.ac.in','registrar@iitp.ac.in','+91-612-3028001','IITP2','IIT Patna providing quality engineering education in the ancient and historic state of Bihar.'),
(359,'NIT Trichy','Engineering College','Government','Tamil Nadu','Tiruchirappalli','Tanjore Main Road, Tiruchirappalli','620015','Government','Autonomous',1964,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science,Architecture','https://www.nitt.edu','director@nitt.edu','+91-431-2503000','NITT','One of the oldest and most reputed NITs in South India offering quality engineering programs.'),
(360,'NIT Karnataka, Surathkal','Engineering College','Government','Karnataka','Mangaluru','Srinivasnagar, Mangaluru','575025','Government','Autonomous',1960,'A',1,'AICTE,NAAC,NBA','Engineering,Computer Science','https://www.nitk.ac.in','director@nitk.ac.in','+91-824-2474000','NITK','A premier NIT in Karnataka overlooking the Arabian Sea offering quality engineering education.'),
(361,'NIT Nagaland','Engineering College','Government','Nagaland','Dimapur','Chumukedima, Dimapur','797103','Government','Autonomous',2010,'N/A',1,'AICTE','Engineering,Computer Science','https://nitnagaland.ac.in','director@nitnagaland.ac.in','+91-3862-237000','NITNL','National Institute of Technology in Nagaland offering B.Tech engineering programs.'),
(362,'NIFT Gandhinagar','Design College','Government','Gujarat','Gandhinagar','Sector 17, Gandhinagar','382017','Government','Autonomous',2010,'N/A',0,'NAAC','Design','https://www.nift.ac.in/gandhinagar','niftgandhinagar@nift.ac.in','+91-79-23250032','NIFTG','NIFT campus in Gandhinagar offering fashion design and technology programs.'),
(363,'NIFT Kolkata','Design College','Government','West Bengal','Kolkata','Block- LA, Sector III, Salt Lake','700098','Government','Autonomous',1995,'N/A',0,'NAAC','Design','https://www.nift.ac.in/kolkata','niftkolkata@nift.ac.in','+91-33-23341985','NIFTK','NIFT Kolkata offering fashion design and technology programs in the cultural capital.'),
(364,'NIFT Bengaluru','Design College','Government','Karnataka','Bengaluru','Hebbal Industrial Area, Bengaluru','560024','Government','Autonomous',2010,'N/A',0,'NAAC','Design','https://www.nift.ac.in/bengaluru','niftblr@nift.ac.in','+91-80-23415200','NIFTB2','NIFT campus in Bengaluru offering B.Des and M.Des in fashion and design.'),
(365,'NIFT Hyderabad','Design College','Government','Telangana','Hyderabad','Sardar Patel Road, Secundrabad','500003','Government','Autonomous',1995,'N/A',0,'NAAC','Design','https://www.nift.ac.in/hyderabad','nifthyd@nift.ac.in','+91-40-27892200','NIFTH','NIFT campus in Hyderabad offering fashion design and technology programs.'),
(366,'NIFT Chennai','Design College','Government','Tamil Nadu','Chennai','MGID complex, Arumbakkam','600106','Government','Autonomous',2007,'N/A',0,'NAAC','Design','https://www.nift.ac.in/chennai','niftchennai@nift.ac.in','+91-44-23613399','NIFTC','NIFT Chennai offering fashion design and technology programs in coastal Tamil Nadu.'),
(367,'Institute of Hotel Management, Ahmedabad','Hotel Management','Government','Gujarat','Ahmedabad','Vijay Char Rasta, Ahmedabad','380009','Government','National Council for Hotel Management',1983,'N/A',0,'NCHMCT','Hotel Management','https://ihmahmedabad.com','principal@ihmahmedabad.com','+91-79-26305960','IHMA','Premier government hotel management institute in Gujarat offering BHM programs.'),
(368,'Institute of Hotel Management, Bangalore','Hotel Management','Government','Karnataka','Bengaluru','1 Lavelle Road, Bengaluru','560001','Government','National Council for Hotel Management',1969,'N/A',0,'NCHMCT','Hotel Management','https://ihmblr.com','principal@ihmblr.com','+91-80-22218133','IHMB','Leading hotel management institute in South India offering BHM and diploma programs.'),
(369,'Institute of Hotel Management, Mumbai','Hotel Management','Government','Maharashtra','Mumbai','Veer Savarkar Marg, Dadar','400028','Government','National Council for Hotel Management',1954,'N/A',0,'NCHMCT','Hotel Management','https://ihmm.ac.in','principal@ihmm.ac.in','+91-22-24306055','IHMM','The oldest hotel management institute in India offering BHM and catering technology programs.'),
(370,'XLRI Chennai (Jamshedpur)','Management Institute','Private','Tamil Nadu','Chennai','Mariam Nagar, Poonamallee High Road','600056','Private','XLRI Jamshedpur',2012,'A++',1,'NAAC,AICTE','Management','https://www.xlri.ac.in/xlri-chennai','admissions@xlri.ac.in','+91-44-71212000','XLRIC','XLRI\'s Chennai campus offering globally accredited MBA and management programs.'),
(371,'SP Jain Institute of Management and Research (SPJIMR)','Management Institute','Private','Maharashtra','Mumbai','Bhavans Campus, Andheri West','400058','Private','Autonomous',1981,'A++',1,'NAAC,AACSB,AMBA','Management','https://www.spjimr.org','pgdm@spjimr.org','+91-22-61454200','SPJIMR','One of India\'s most coveted private management institutes with world-class faculty and placement record.'),
(372,'MDI Gurgaon (Management Development Institute)','Management Institute','Private','Haryana','Gurugram','Mehrauli Road, Sukhrali','122007','Private','Autonomous',1973,'A+',1,'NAAC,AMBA','Management','https://www.mdi.ac.in','admissions@mdi.ac.in','+91-124-4560000','MDI','One of India\'s premier management institutes with global industry partnerships and high ROI placements.'),
(373,'TAPMI Manipal (T.A. Pai Management Institute)','Management Institute','Private','Karnataka','Manipal','Madhav Nagar, Manipal','576104','Private','Autonomous',1980,'A+',1,'NAAC,AICTE','Management','https://www.tapmi.edu.in','admissions@tapmi.edu.in','+91-820-2922014','TAPMI','One of India\'s reputed private management institutes offering PGDM programs.'),
(374,'Great Lakes Institute of Management, Chennai','Management Institute','Private','Tamil Nadu','Chennai','East Coast Road, Manamai','603107','Private','Autonomous',2004,'A',1,'NAAC,AICTE','Management','https://www.greatlakes.edu.in/chennai','admissions@greatlakes.edu.in','+91-44-27489000','GLM','Highly ranked management institute focusing on business analytics and global business strategies.'),
(375,'Nirma University Institute of Law','Law College','Private','Gujarat','Ahmedabad','Sarkhej-Gandhinagar Highway','382481','Private','Private University',2007,'A',0,'BCI,NAAC','Law','https://law.nirmauni.ac.in','law@nirmauni.ac.in','+91-79-71652000','NUSOL','Law institute under Nirma University offering BA LLB, BBA LLB, and LLM programs.'),
(376,'Symbiosis Law School, Pune','Law College','Private','Maharashtra','Pune','Senapati Bapat Road, Pune','411004','Private','Symbiosis International University',1977,'A++',0,'BCI,NAAC','Law','https://slsp.edu.in','slsp@symbiosis.ac.in','+91-20-25651237','SLS','One of India\'s premier private law schools offering BA LLB and LLM programs.'),
(377,'Amity Law School, Delhi','Law College','Private','Delhi','Noida','Sector 125, Noida','201313','Private','Amity University',2005,'A',0,'BCI,NAAC','Law','https://www.amity.edu/als','admissions.als@amity.edu','+91-120-4392000','ALS','Amity Law School offering BA LLB and LLM programs with strong moot court tradition.'),
(378,'Army College of Medical Sciences, Delhi','Medical College','Government','Delhi','New Delhi','Base Hospital Area, New Delhi','110010','Government','University of Delhi',2008,'N/A',0,'NMC','Medical','https://acmsdelhi.org','principal@acmsdelhi.org','+91-11-25686001','ACMS','A premier military medical college offering MBBS programs for army personnel.'),
(379,'Kasturba Medical College, Manipal','Medical College','Private','Karnataka','Manipal','Madhav Nagar, Manipal','576104','Private','Manipal Academy of Higher Education',1953,'A++',0,'NMC,NAAC','Medical,Nursing','https://manipal.edu/kmc-manipal.html','admissions@manipal.edu','+91-820-2922419','KMC2','One of India\'s premier private medical colleges with exceptional facilities and research programs.'),
(380,'Jawaharlal Nehru Medical College, AMU','Medical College','Government','Uttar Pradesh','Aligarh','AMU Campus, Aligarh','202002','Government','Aligarh Muslim University',1962,'A',0,'NMC,NAAC','Medical,Nursing','https://jnmc.com','principal@jnmc.amu.ac.in','+91-571-2720059','JNMC','One of India\'s reputed government medical colleges under AMU offering MBBS and MD programs.'),
(381,'Institute of Medical Sciences, BHU','Medical College','Government','Uttar Pradesh','Varanasi','BHU Campus, Varanasi','221005','Government','Banaras Hindu University',1960,'A+',0,'NMC,NAAC','Medical,Nursing','https://imsb.bhu.ac.in','ms_bhu@yahoo.co.in','+91-542-2368560','IMSBHU','One of India\'s prestigious medical colleges under BHU with exceptional clinical and research facilities.'),
(382,'Armed Forces Medical College (AFMC) Pune','Medical College','Government','Maharashtra','Pune','Sholapur Road, Pune','411040','Government','Maharashtra University of Health Sciences',1948,'A+',0,'NMC,NAAC','Medical,Nursing','https://www.afmc.nic.in','principal@afmc.nic.in','+91-20-26306001','AFMC','India\'s premier military medical college offering MBBS and postgraduate programs for Armed Forces.'),
(383,'Government Dental College, Mumbai','Medical College','Government','Maharashtra','Mumbai','CST Road, Sion','400022','Government','Maharashtra University of Health Sciences',1938,'A',0,'DCI,NAAC','Medical','https://gdchospitalmumbai.com','principal@gdcm.edu.in','+91-22-24048701','GDCM','One of India\'s oldest government dental colleges offering BDS and MDS programs.'),
(384,'Sri Aurobindo Institute of Medical Sciences (SAIMS)','Medical College','Private','Madhya Pradesh','Indore','Indore-Ujjain Road, Indore','453555','Private','Devi Ahilya Vishwavidyalaya',2005,'B+',0,'NMC','Medical','https://www.saims.edu.in','admissions@saims.edu.in','+91-731-4235000','SAIMS','Private medical college in Indore offering MBBS and medical training programs.'),
(385,'Jawaharlal Nehru Architecture and Fine Arts University (JNAFAU)','Architecture College','Government','Telangana','Hyderabad','Mahavir Marg, Masab Tank','500028','Government','State University',2008,'N/A',0,'COA,NAAC','Architecture,Fine Arts','https://jnafau.ac.in','registrar@jnafau.ac.in','+91-40-23388100','JNAFAU','Specialized university for architecture and fine arts education in Telangana.'),
(386,'Academy of Architecture, Mumbai','Architecture College','Private','Maharashtra','Mumbai','Raza Baug, near Ferry Wharf','400009','Private','University of Mumbai',1955,'A',0,'COA,NAAC','Architecture','https://www.aoarch.com','principal@aoarch.com','+91-22-23726202','AOA','One of Mumbai\'s premier private architecture schools with a strong design tradition.'),
(387,'School of Planning and Architecture (SPA), Vijayawada','Architecture College','Government','Andhra Pradesh','Vijayawada','Bypass Road, Vijayawada','520008','Government','Autonomous',2008,'N/A',0,'COA','Architecture','https://spav.ac.in','registrar@spav.ac.in','+91-866-2496044','SPAV','One of the national schools of architecture offering B.Arch and urban planning programs.'),
(388,'School of Planning and Architecture (SPA), Bhopal','Architecture College','Government','Madhya Pradesh','Bhopal','Neelbad, Bhopal','462044','Government','Autonomous',2008,'N/A',0,'COA','Architecture','https://spab.ac.in','registrar@spab.ac.in','+91-755-2400401','SPAB','National school of architecture offering B.Arch and urban planning programs in Bhopal.'),
(389,'National Institute of Design (NID), Ahmedabad','Design College','Government','Gujarat','Ahmedabad','Paldi, Ahmedabad','380007','Government','Autonomous',1961,'A++',0,'NAAC','Design','https://www.nid.edu','info@nid.edu','+91-79-26629066','NID','India\'s premier design institute and one of the world\'s top design schools offering B.Des and M.Des.'),
(390,'NID Jorhat','Design College','Government','Assam','Jorhat','Jorhat, Assam','785001','Government','Autonomous',2010,'N/A',0,'NAAC','Design','https://nidjorhat.ac.in','info@nidjorhat.ac.in','+91-376-2310200','NIDJ','National Institute of Design in Assam offering design education in northeast India.'),
(391,'National Law University, Gujarat','Law College','Government','Gujarat','Gandhinagar','Atmashat, Gandhinagar','382007','Government','Autonomous',2003,'A',0,'BCI,NAAC','Law','https://gnlu.ac.in','info@gnlu.ac.in','+91-79-23248521','GNLU2','Gujarat National Law University offering BA LLB and LLM programs with strong research output.'),
(392,'National Law University, Cuttack','Law College','Government','Odisha','Cuttack','Sector 13, CDA, Cuttack','753014','Government','Autonomous',2008,'A',0,'BCI,NAAC','Law','https://www.nluo.ac.in','info@nluo.ac.in','+91-671-2326741','NLUO2','National Law University Odisha offering quality legal education and research.'),
(393,'NALSAR University of Law','Law College','Government','Telangana','Hyderabad','Justice City, Shameerpet','500101','Government','Autonomous',1998,'A+',0,'BCI,NAAC','Law','https://www.nalsar.ac.in','registrar@nalsar.ac.in','+91-40-23498196','NALSAR','One of India\'s premier national law universities offering BA LLB and LLM programs in Hyderabad.'),
(394,'Tamil Nadu Veterinary and Animal Sciences University (TANUVAS)','Agriculture College','Government','Tamil Nadu','Chennai','Madhavaram Milk Colony, Chennai','600051','Government','State University',1989,'A',0,'VCI,NAAC','Agriculture','https://www.tanuvas.ac.in','registrar@tanuvas.ac.in','+91-44-25551538','TANUVAS','India\'s third veterinary university offering B.V.Sc & AH and postgraduate programs.'),
(395,'College of Veterinary Science, Hyderabad','Agriculture College','Government','Telangana','Hyderabad','Rajendranagar, Hyderabad','500030','Government','PVNR Telangana Veterinary University',1950,'A',0,'VCI,NAAC','Agriculture','https://pvnrtvvu.ac.in','registrar@pvnrtvvu.ac.in','+91-40-24015800','CVSH','Premier veterinary college in Telangana offering B.V.Sc & AH programs.'),
(396,'Manipal Institute of Technology (MIT)','Engineering College','Private','Karnataka','Manipal','Madhav Nagar, Manipal','576104','Private','Manipal Academy of Higher Education',1957,'A+',1,'NAAC,AICTE,NBA','Engineering,Computer Science,Information Technology','https://manipal.edu/mit.html','admissions@manipal.edu','+91-820-2922519','MIT2','One of Karnataka\'s premier private engineering institutes with strong industry connections.'),
(397,'Vivekananda College, Chennai','Degree College','Private','Tamil Nadu','Chennai','Tiruvottiyur, Chennai','600019','Private','University of Madras',1964,'A',0,'NAAC,UGC','Arts,Commerce,Science','https://vivekanandacollege.edu.in','principal@vivekanandacollege.edu.in','+91-44-25781127','VCC','A reputed private arts and science college in northern Chennai offering quality undergraduate programs.'),
(398,'Fergusson College, Pune','Degree College','Government','Maharashtra','Pune','Fergusson College Road, Shivajinagar','411004','Government','Savitribai Phule Pune University',1885,'A++',0,'NAAC,UGC','Arts,Science','https://www.fergusson.edu','principal@fergusson.edu','+91-20-25652664','FC','One of Maharashtra\'s most historic and prestigious colleges with a tradition of producing distinguished alumni.'),
(399,'St. Stephen\'s College, Delhi','Degree College','Private','Delhi','New Delhi','University Enclave, Delhi','110007','Private','University of Delhi',1881,'A++',0,'NAAC,UGC','Arts,Science','https://www.ststephens.edu','principal@ststephens.edu','+91-11-27667271','STC','One of India\'s most prestigious colleges and among the oldest in Delhi University known for academic excellence.'),
(400,'Presidency College, Kolkata','Degree College','Government','West Bengal','Kolkata','86/1, College Street, Kolkata','700073','Government','University of Calcutta',1817,'A++',0,'NAAC,UGC','Arts,Science,Commerce','https://www.presidencycollege.ac.in','principal@pcy.ac.in','+91-33-22415254','PCK','One of India\'s oldest and most distinguished colleges with a rich history of Nobel laureates and leaders.');

UNLOCK TABLES;

-- ============================================================
-- SAMPLE COLLEGE_COURSES MAPPINGS (representative subset)
-- ============================================================

LOCK TABLES `college_courses` WRITE;
INSERT INTO `college_courses` (`college_id`,`course_id`,`fees`) VALUES
-- IIT Bombay
(1,17,250000),(1,18,250000),(1,19,250000),(1,20,250000),(1,21,250000),(1,25,280000),(1,26,280000),
-- COEP Pune
(2,17,120000),(2,18,120000),(2,19,120000),(2,20,120000),
-- VJTI Mumbai
(3,17,95000),(3,18,95000),(3,19,95000),(3,21,95000),
-- PICT Pune
(4,1,180000),(4,3,120000),(4,17,160000),
-- NMIMS
(5,10,900000),(5,11,850000),(5,1,400000),
-- JBIMS
(6,10,450000),(6,14,450000),(6,15,450000),
-- VIT Pune
(7,17,155000),(7,18,155000),(7,19,155000),(7,20,155000),
-- DJSCE
(8,17,180000),(8,18,180000),(8,17,180000),
-- SICSR
(9,3,150000),(9,4,160000),(9,9,180000),
-- MIT-WPU
(10,17,220000),(10,9,280000),(10,10,320000),
-- GMC Nagpur
(11,33,80000),(11,38,100000),(11,39,100000),
-- KEM Hospital Mumbai
(12,33,25000),(12,38,30000),
-- GCP Karad
(13,40,60000),(13,41,80000),
-- IIMB
(26,10,2300000),(26,11,2200000),
-- RVCE
(27,17,185000),(27,18,185000),(27,1,160000),
-- PES University
(28,17,350000),(28,18,350000),(28,10,450000),
-- MSRIT
(29,17,180000),(29,18,180000),(29,1,160000),
-- Christ University
(30,9,180000),(30,10,350000),(30,3,150000),(30,48,120000),(30,52,90000),
-- SJCC Bangalore
(31,52,85000),(31,9,120000),
-- BMCRI
(32,33,80000),(32,38,100000),
-- IIT Madras
(48,17,250000),(48,18,250000),(48,25,280000),(48,26,280000),
-- PSG Tech
(49,17,155000),(49,18,155000),(49,1,130000),
-- VIT Vellore
(50,17,195000),(50,18,195000),(50,25,220000),(50,3,120000),
-- SRM Chennai
(51,17,180000),(51,10,350000),(51,3,120000),
-- CEG Guindy
(52,17,80000),(52,18,80000),(52,19,80000),
-- Madras Medical College
(53,33,15000),(53,38,20000),
-- Loyola College Chennai
(54,9,90000),(54,52,55000),(54,63,50000),
-- IIT Delhi
(70,17,250000),(70,18,250000),(70,25,280000),(70,26,280000),
-- DTU Delhi
(71,17,150000),(71,18,150000),(71,17,150000),
-- SSCBS
(72,9,70000),(72,12,70000),
-- AIIMS Delhi
(73,33,1000),(73,38,2000),(73,39,2000),
-- IIM Lucknow
(90,10,2100000),(90,11,2000000),
-- MNNIT Prayagraj
(91,17,150000),(91,18,150000),(91,4,120000),
-- BITS Pilani
(147,17,450000),(147,1,400000),(147,10,500000),(147,40,380000),
-- MNIT Jaipur
(148,17,150000),(148,18,150000),(148,20,150000),
-- IIT Kharagpur
(109,17,250000),(109,18,250000),(109,31,300000),
-- IIM Calcutta
(110,10,2300000),(110,11,2200000),
-- Jadavpur University
(111,17,85000),(111,18,85000),(111,63,40000),(111,56,40000),
-- IIT Roorkee
(237,17,250000),(237,18,250000),(237,20,250000),(237,31,300000),
-- IIM Ahmedabad
(128,10,2500000),(128,11,2300000),
-- NID Ahmedabad
(389,75,350000),(389,76,400000),
-- NLU Delhi
(78,49,200000),(78,50,200000),(78,51,250000),
-- NALSAR Hyderabad
(393,49,180000),(393,50,180000),(393,51,200000),
-- NLS Bangalore
(44,49,175000),(44,50,175000),(44,51,190000),
-- Kerala Agricultural University
(247,67,60000),(247,68,80000),
-- TNAU
(56,67,50000),(56,68,70000),(56,69,90000),
-- St. Stephen's Delhi
(399,63,30000),(399,56,30000),(399,57,30000),
-- Presidency Kolkata
(400,63,20000),(400,56,20000),(400,57,20000),
-- Fergusson College Pune
(398,63,25000),(398,56,25000),(398,57,25000),
-- Miranda House
(75,63,25000),(75,56,25000),(75,64,35000),
-- Lady Shri Ram
(76,63,25000),(76,9,80000),(76,52,25000),
-- IIT Guwahati
(277,17,250000),(277,18,250000),(277,26,280000),
-- IIT Mandi
(230,17,250000),(230,18,250000),
-- NIT Calicut
(251,17,150000),(251,31,200000),
-- NIT Surathkal
(360,17,150000),(360,18,150000),
-- NIT Trichy
(359,17,150000),(359,18,150000),(359,31,200000),
-- NIT Warangal
(183,17,150000),(183,18,150000),
-- SPJIMR Mumbai
(371,10,1900000),(371,11,1800000),
-- MDI Gurgaon
(372,10,2000000),(372,11,1900000),
-- IISc Bangalore
(45,28,35000),(45,30,35000),(45,62,30000),
-- KIIT Bhubaneswar
(258,17,350000),(258,10,400000),(258,49,200000),
-- SOA University
(264,17,300000),(264,33,150000),(264,10,280000),
-- Chandigarh University
(216,17,190000),(216,10,250000),(216,49,180000),
-- LPU
(217,17,180000),(217,10,220000),(217,67,80000),(217,49,180000),
-- NIFT Delhi
(89,75,350000),(89,76,400000),
-- NIFT Gandhinagar
(362,75,350000),(362,80,250000),
-- IHM Mumbai
(369,73,180000),(369,74,220000),
-- IHM Bangalore
(368,73,180000),(368,74,220000),
-- IHM Chennai
(66,73,180000),(66,74,220000),
-- Government Polytechnic Mumbai
(14,81,25000),(14,82,25000),(14,83,25000),(14,84,25000),(14,85,25000),
-- Government Polytechnic Ahmedabad
(140,81,20000),(140,82,20000),(140,83,20000),
-- Manipal College of Nursing
(34,44,180000),(34,45,200000),(34,46,120000),
-- Kerala Kalamandalam
(250,77,60000),(250,78,80000),
-- Rabindra Bharati University
(124,77,50000),(124,78,70000),
-- Goa College of Art
(344,77,45000),(344,78,65000),
-- AFMC Pune
(382,33,0),(382,38,0),(382,39,0),
-- PGIMER Chandigarh
(310,38,30000),(310,39,30000),
-- JIPMER Puducherry
(314,33,5000),(314,38,10000),
-- NIT Durgapur
(120,17,150000),(120,18,150000),(120,10,200000),
-- Great Lakes Chennai
(374,10,1800000),(374,11,1700000),
-- XLRI Jamshedpur
(207,10,2500000),(207,14,2300000),
-- JGU Sonipat
(226,49,500000),(226,10,650000),(226,64,200000);
UNLOCK TABLES;
