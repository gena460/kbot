pipeline {
  agent any
  parameters {
	choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'Choose OS')
  }
    environment {
      REPO = 'https://github.com/gena460/kbot'
	  BRANCH = 'main'
	  }
    stages {
	  
	    stage("clone") {
	      steps {
		  echo 'CLONE REPOSITORY'
		    git branch: "${BRANCH}", url: "${REPO}"
		  }
	    }

	    stage("test") {
	      steps {
		    sh "make --version"
		    echo 'TEST EXECUTION STARTED'
		    sh 'make test'
		    }
	    }
		
	    stage("build") {
	      steps {
		    echo 'BUILD EXECUTION STARTED'
		    sh 'make build'
		    }
	    }

	    stage("image") {
	      steps {
		    script {
		      echo 'BUILD EXECUTION STARTED'
		      sh 'make image'
		    }
	      }
	    }

	    stage("push") {
	      steps {
		    script {
		      docker.withRegistry( '', 'dockerhub' ) {
		      sh 'make push'
		      }
	        }
	      }
	    }
	  }
  }