-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 14, 2024 at 04:34 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mental_health_support_analytics`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentDetails` (IN `student_name` VARCHAR(255))   begin
select * 
from students
where name = student_name;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentSummary` (IN `student_id` INT)   begin
select s.name as student_name,
count(distinct mha.assessment_id) as assessment_count,
count(distinct i.intervention_id) as intervention_count,
count(distinct ss.service_id) as service_count
from students s
left join mental_health_assessments mha on s.student_id = mha.student_id
left join interventions i on s.student_id = i.student_id
left join support_services ss on s.student_id = ss.student_id
where s.student_id  = student_id;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `assessment_questions`
--

CREATE TABLE `assessment_questions` (
  `question_id` int(11) NOT NULL,
  `question_text` text DEFAULT NULL,
  `assessment_id` int(11) DEFAULT NULL,
  `response` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `assessment_questions`
--

INSERT INTO `assessment_questions` (`question_id`, `question_text`, `assessment_id`, `response`) VALUES
(1, 'How often do you feel anxious?', 1, 'Often'),
(2, 'Do you have trouble sleeping?', 1, 'Yes'),
(3, 'Describe your mood over the past week.', 2, 'I have been feeling down lately.'),
(4, 'Have you experienced any traumatic events recently?', 3, 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `interventions`
--

CREATE TABLE `interventions` (
  `intervention_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `intervention_Date` date DEFAULT NULL,
  `intervention_type` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `interventions`
--

INSERT INTO `interventions` (`intervention_id`, `student_id`, `intervention_Date`, `intervention_type`, `provider`) VALUES
(1, 1, '2024-02-16', 'Counseling', 'School Counselor'),
(2, 2, '2024-02-17', 'Therapy', 'Licensed Therapist'),
(3, 3, '2024-02-18', 'Counseling', 'School Counselor');

-- --------------------------------------------------------

--
-- Table structure for table `intervention_outcomes`
--

CREATE TABLE `intervention_outcomes` (
  `outcome_id` int(11) NOT NULL,
  `intervention_id` int(11) DEFAULT NULL,
  `outcome_measure` varchar(255) DEFAULT NULL,
  `outcome_value` varchar(255) DEFAULT NULL,
  `outcome_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `intervention_outcomes`
--

INSERT INTO `intervention_outcomes` (`outcome_id`, `intervention_id`, `outcome_measure`, `outcome_value`, `outcome_date`) VALUES
(1, 1, 'Reduction in anxiety symptoms', '25% improvement', '2024-03-01'),
(2, 2, 'Improvement in mood', 'Significant improvement', '2024-03-02'),
(3, 3, 'Increase in coping skills', 'Developed new coping strategies', '2024-03-03');

-- --------------------------------------------------------

--
-- Table structure for table `mental_health_assessments`
--

CREATE TABLE `mental_health_assessments` (
  `assessment_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `assessment_date` date DEFAULT NULL,
  `assessment_type` varchar(255) DEFAULT NULL,
  `assessor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mental_health_assessments`
--

INSERT INTO `mental_health_assessments` (`assessment_id`, `student_id`, `assessment_date`, `assessment_type`, `assessor`) VALUES
(1, 1, '2024-02-14', 'Questionnaire', 'Psychologist'),
(2, 2, '2024-02-15', 'Interview', 'Counselor'),
(3, 3, '2024-02-16', 'Questionnaire', 'Therapist');

-- --------------------------------------------------------

--
-- Table structure for table `mental_health_survey_responses`
--

CREATE TABLE `mental_health_survey_responses` (
  `response_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `survey_date` date DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `response` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mental_health_survey_responses`
--

INSERT INTO `mental_health_survey_responses` (`response_id`, `student_id`, `survey_date`, `question_id`, `response`) VALUES
(1, 1, '2024-02-14', 1, 'Often'),
(2, 1, '2024-02-14', 2, 'Yes'),
(3, 2, '2024-02-15', 1, 'Rarely'),
(4, 2, '2024-02-15', 2, 'No'),
(5, 3, '2024-02-16', 1, 'Sometimes'),
(6, 3, '2024-02-16', 2, 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE `schools` (
  `school_id` int(11) NOT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`school_id`, `school_name`, `location`) VALUES
(1, 'Central High School', 'City A'),
(2, 'Westside High School', 'City B');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `grade_level` varchar(50) DEFAULT NULL,
  `school_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `age`, `gender`, `grade_level`, `school_id`) VALUES
(1, 'John Doe', 17, 'male', '12th Grade', 1),
(2, 'Jane Smith', 16, 'female', '11th Grade', 2),
(3, 'Michael Johnson', 15, 'male', '10th Grade', 1);

--
-- Triggers `students`
--
DELIMITER $$
CREATE TRIGGER `update_grade_level` AFTER INSERT ON `students` FOR EACH ROW begin
if new.age >= 18 then 
update students
set grade_level = 'College'
where student_id = new.student_id;
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `support_services`
--

CREATE TABLE `support_services` (
  `service_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `service_type` varchar(255) DEFAULT NULL,
  `service_provider` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `support_services`
--

INSERT INTO `support_services` (`service_id`, `student_id`, `service_type`, `service_provider`) VALUES
(1, 1, 'Support Group', 'Peer Support Group'),
(2, 2, 'Peer Counseling', 'Senior Peer Counselor'),
(3, 3, 'Support Group', 'Mental Health Organization');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment_questions`
--
ALTER TABLE `assessment_questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `assessment_id` (`assessment_id`);

--
-- Indexes for table `interventions`
--
ALTER TABLE `interventions`
  ADD PRIMARY KEY (`intervention_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `intervention_outcomes`
--
ALTER TABLE `intervention_outcomes`
  ADD PRIMARY KEY (`outcome_id`),
  ADD KEY `intervention_id` (`intervention_id`);

--
-- Indexes for table `mental_health_assessments`
--
ALTER TABLE `mental_health_assessments`
  ADD PRIMARY KEY (`assessment_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `mental_health_survey_responses`
--
ALTER TABLE `mental_health_survey_responses`
  ADD PRIMARY KEY (`response_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`school_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `support_services`
--
ALTER TABLE `support_services`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessment_questions`
--
ALTER TABLE `assessment_questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `interventions`
--
ALTER TABLE `interventions`
  MODIFY `intervention_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `intervention_outcomes`
--
ALTER TABLE `intervention_outcomes`
  MODIFY `outcome_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mental_health_assessments`
--
ALTER TABLE `mental_health_assessments`
  MODIFY `assessment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mental_health_survey_responses`
--
ALTER TABLE `mental_health_survey_responses`
  MODIFY `response_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `school_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `support_services`
--
ALTER TABLE `support_services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assessment_questions`
--
ALTER TABLE `assessment_questions`
  ADD CONSTRAINT `assessment_questions_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `mental_health_assessments` (`assessment_id`);

--
-- Constraints for table `interventions`
--
ALTER TABLE `interventions`
  ADD CONSTRAINT `interventions_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Constraints for table `intervention_outcomes`
--
ALTER TABLE `intervention_outcomes`
  ADD CONSTRAINT `intervention_outcomes_ibfk_1` FOREIGN KEY (`intervention_id`) REFERENCES `interventions` (`intervention_id`);

--
-- Constraints for table `mental_health_assessments`
--
ALTER TABLE `mental_health_assessments`
  ADD CONSTRAINT `mental_health_assessments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Constraints for table `mental_health_survey_responses`
--
ALTER TABLE `mental_health_survey_responses`
  ADD CONSTRAINT `mental_health_survey_responses_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `mental_health_survey_responses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `assessment_questions` (`question_id`);

--
-- Constraints for table `support_services`
--
ALTER TABLE `support_services`
  ADD CONSTRAINT `support_services_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
