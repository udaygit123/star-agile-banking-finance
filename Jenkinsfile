pipeline {
  agent any

  tools {
      maven 'M2_HOME'
        }
  stages {
     stage('checkout'){
       steps {
         echo 'checkout the code from GitRepo'
         git 'git 'https://github.com/prafullashilimkar/star-agile-banking-finance.git'
                    }
            }
   

     stage('Build the  Application'){
               steps {
                   echo "Cleaning.... Compiling......Testing.........Packaging"
                   sh 'mvn clean package'
                    }
                 }
                 
  	     
