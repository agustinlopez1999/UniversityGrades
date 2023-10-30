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
    //Receive id string, returns hash
    function getHashStudent(string memory _idStudent) private pure returns(bytes32){
        return keccak256(abi.encodePacked(_idStudent));
    }

    //Assign the grade to the student
    function Evaluate(string memory _idStudent, uint8 _grade) external  OnlyProfessor(msg.sender){
        bytes32 hash_idStudent = getHashStudent(_idStudent);
        Grades[hash_idStudent] = _grade;
        emit student_evaluated(hash_idStudent,_grade);
    }

    //Receive id, returns grade
    function CheckGrades(string memory _idStudent) external view returns(uint8){
        bytes32 hash_idStudent = getHashStudent(_idStudent);
        require(Grades[hash_idStudent]!=0,"Student doesn't exists");
        uint8 studentGrade = Grades[hash_idStudent];
        return studentGrade;
    }

    //check if student is already in revision list
    function isInRevisionList(string memory _idStudent) private view returns(bool){
        bool flag = false;
        uint i = 0;
        while(i<revisions.length && flag == false){
            if(keccak256(abi.encodePacked(revisions[i])) == keccak256(abi.encodePacked(_idStudent)))
                flag = true;
            i++;
        }
        return flag;
    }

    //Receive id from the Student who wants revision
    function AskRevision(string memory _idStudent) external{
        require(Grades[getHashStudent(_idStudent)]!=0,"Student doesn't exists");
        require(!isInRevisionList(_idStudent),"Student is already on the list");
        revisions.push(_idStudent);
        emit ask_revision(_idStudent);
    }

    function ShowAskedRevisions() external view returns(string[] memory){
        return revisions;
    }

}