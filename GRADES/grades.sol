// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract grades{

    //Professor address
    address public professor;

    //Professor address is contract deployer adress
    constructor(){
        professor = msg.sender;
    }

    //Relate hash with grades
    mapping(bytes32 => uint) Grades;

    //Array from students that ask for revision
    string[] revisions;

    //Events
    event student_evaluated(bytes32);
    event ask_revision(string);

    //checks if professor equals to sender
    modifier OnlyProfessor(address _sender){
        require(professor == _sender,"Only professor can use this Function");
        _;
    }

    //assign the grade to the student
    function Evaluate(string memory _idStudent, uint _grade) public OnlyProfessor(msg.sender){
        bytes32 hash_idStudent = keccak256(abi.encodePacked(_idStudent));
        Grades[hash_idStudent] = _grade;
        emit student_evaluated(hash_idStudent);
    }

}