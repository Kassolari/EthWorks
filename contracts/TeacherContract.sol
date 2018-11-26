pragma solidity ^0.4.23;

contract Course {
    string public courseName;
    address public teacher;
    address[] public students;
    mapping(address => Student) public studentData;
    
    struct Student {
        address _adres;
        uint32 _punkty;
    }

    // konstruktor kontraktu
    constructor(string _name, address[] _students) public {
        teacher = msg.sender;
        courseName = _name;
        for (uint32 i = 0; i < _students.length; ++i){
            addStudent(_students[i]);
        }
    }
    
    // lista eventow wywolywanych gdy wykona sie akcja przez emit
    event StudentResult(address student, uint32 points, uint date);
    
    //modifikatory funkcji sprawdzajace warunki przed wykonaniem
    modifier onlyTeacher() {
        require(msg.sender == teacher);
        _;
    }
    
    modifier activeStudent(address _candidate){
        require(isStudent(_candidate));
        _;
    }
    
    //funkcja sprawdzajaca czy student jest na liscie
    function isStudent(address _candidate) private view returns (bool){
        for (uint32 i = 0; i <students.length; ++i){
            if (students[i] == _candidate) {
                return true;
            }
        }
        return false;
    }
    
    //funkcja sprawdzajaca czy adres juz nie wystepuje na liscie
    //jesli wystepuje nie mozna go dodac uzycie require musi byc true
    
    function isAdded(address _address) private view returns (bool){
        for (uint32 i = 0; i <students.length; ++i) {
            if (students[i] == _address) {
                return false;
            }
        }
        return true;
    }
    
    //funkcja dodawania studenta modifikator wlasciciel kontraktu oraz czy
    //adres nie zostal juz dodawny wczesniej >> require
    
    function addStudent(address _address) public onlyTeacher {
        require(isAdded(_address));
        Student storage student_pom = studentData[_address];
        student_pom._adres = _address;
        students.push(_address) -1;
    }
    
    function seeListOfStudents() view public returns(address[]){
        return students;
    }
    
    //funkcja dodawania punktow danemu uczniowi
    
    function addPoints(address _student, uint32 _points) public onlyTeacher activeStudent(_student) {
        Student storage student_pom = studentData[_student];
        student_pom._punkty += _points; 
        emit StudentResult(_student, _points, now);
    }
    
    
    //otrzymanie oceny przez ucznia na podstawie wyniku
    
    function getMark(address _student) public view returns (uint8) {
        uint256 studentPoints = studentData[_student]._punkty;
        if (studentPoints < 50) { return 20; }
        if (studentPoints < 60) { return 30; }
        if (studentPoints < 70) { return 35; }
        if (studentPoints < 80) { return 40; }
        if (studentPoints < 90) { return 45; }
        return 50;
    }
}