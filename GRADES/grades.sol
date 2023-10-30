// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract grades{

    //Returns professor address
    address public professor;

    //Professor address is contract deployer adress
    constructor(){
        professor = msg.sender;
    }

    //Relate hash with grades
    mapping(bytes32 => uint8) Grades;

    //Array from students that ask for revision
    string[] revisions;

    //Events
    event student_evaluated(bytes32,uint8);
    event ask_revision(string);

    //Checks if professor equals to sender
    modifier OnlyProfessor(address _sender){
        require(professor == _sender,"You don't have permissions.");
        _;
    }

    function getHashStudent(string memory _idStudent) private pure returns(bytes32){
        return keccak256(abi.encodePacked(_idStudent));
    }

    //Assign the grade to the student
    function Evaluate(string memory _idStudent, uint8 _grade) public OnlyProfessor(msg.sender){
        bytes32 hash_idStudent = getHashStudent(_idStudent);
        Grades[hash_idStudent] = _grade;
        emit student_evaluated(hash_idStudent,_grade);
    }

    //Receive id, returns grade
    function CheckGrades(string memory _idStudent) public view returns(uint8){
        bytes32 hash_idStudent = getHashStudent(_idStudent);
        uint8 studentGrade = Grades[hash_idStudent];
        return studentGrade;
    }

}