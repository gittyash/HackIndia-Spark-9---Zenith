// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HiringPlatform {
    struct Employer {
        string name;
        string[] previousEmployeeRatings;
        string[] successfulProjects;
    }

    struct Employee {
        string name;
        string education;
        uint256 marks;
        string[] previousEmployerRatings;
        string[] completedProjects;
    }

    mapping(address => Employer) public employers;
    mapping(address => Employee) public employees;

    event EmployerRegistered(address indexed employer, string name);
    event EmployeeRegistered(address indexed employee, string name);

    function registerEmployer(string memory _name) public {
        require(bytes(employers[msg.sender].name).length == 0, "Employer already registered.");
        employers[msg.sender].name = _name;
        emit EmployerRegistered(msg.sender, _name);
    }

    function addEmployerRating(string memory _rating) public {
        require(bytes(employers[msg.sender].name).length > 0, "Employer not registered.");
        employers[msg.sender].previousEmployeeRatings.push(_rating);
    }

    function registerEmployee(string memory _name, string memory _education, uint256 _marks) public {
        require(bytes(employees[msg.sender].name).length == 0, "Employee already registered.");
        employees[msg.sender].name = _name;
        employees[msg.sender].education = _education;
        employees[msg.sender].marks = _marks;
        emit EmployeeRegistered(msg.sender, _name);
    }

    function addEmployeeRating(string memory _rating) public {
        require(bytes(employees[msg.sender].name).length > 0, "Employee not registered.");
        employees[msg.sender].previousEmployerRatings.push(_rating);
    }

    function addCompletedProject(string memory _project) public {
        require(bytes(employees[msg.sender].name).length > 0, "Employee not registered.");
        employees[msg.sender].completedProjects.push(_project);
    }

    function getEmployerInfo(address _employer) public view returns (Employer memory) {
        return employers[_employer];
    }

    function getEmployeeInfo(address _employee) public view returns (Employee memory) {
        return employees[_employee];
    }
}
