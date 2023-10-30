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

}