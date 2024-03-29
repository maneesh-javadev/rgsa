# Rashtriya Gram Swaraj Abhiyan (RGSA) project

## Requirements

- [ ] Install git from [git-scm](https://git-scm.com/downloads) site. Select Windows in download option if you are on windows. For Linux you might directly install from package manager. Make sure git binaries directory is in PATH variables.
- [ ] Install maven from maven site. Make sure maven binaries directory is in PATH variables.

## Getting started 

- [ ] Open the command prompt and `cd` to the directory where you want to clone.

- [ ] Switch off SSL verification for Codendi using following commands
  `git config --global http.sslVerify false`

- [ ] Add your author name and email using following commands. ***Change as per your name and email***.

  ```bash
  git config --global user.name "Maneesh Kumar"
  git config --global user.email "kumar.maneesh1984@gmail.com"
  ```

- [ ] Get the code (***change as per your codendi username***), enter the codendi password if prompted:

  ```bash
  git clone git@10.248.213.226:kkundan/rgsa.git
  # if ssh times out use:
  # git clone http://10.248.213.226/kkundan/rgsa.git 
  cd rgsa
  git checkout dev
  git submodule update --init --recursive
  ```

- [ ] To create a new branch use the following command assuming your branch name is `features/cec_dashboard`

  ```bash
  git gui
  # Now choose the Branch->Create 
  # Enter in "Branch Name" groupbox value "features/cec_dashboard" against Name text field.
  # In "Starting Revision" groupbox choose "Local Branch" radio and in select box select "dev" branch.
  ```



## Running the code

##### Prerequisites:

- [ ] Find all `*.properties.example` files mostly located in the `src/main/resources/` directory. Copy the file and paste it again by removing `.example` extension. Example `application.properties.example` has to be renamed as `application.properties`. Update the values as per your build environment.

- [ ] Checklist:

  + `./src/main/resources/config/application-security.properties.example`
  + `./src/main/resources/config/application.properties.example`
  + `./src/main/resources/log4j.properties.example`
  + `./src/main/webapp/WEB-INF/configs/Owasp.CsrfGuard.properties.template`

- [ ] To auto generate your `Owasp.CsrfGuard.properties ` grab the `annoter-tool.jar` and run following command

  ```bash
  # Linux
  COLLECTION_DIR="/home/kyk/Documents/Progs/Java/deploy/rgsa"
  CODE_DIR="${COLLECTION_DIR}/live/rgsa"
  java -jar "${COLLECTION_DIR}/deploy/tool/annoter-tool.jar" -tool=owasp -mount="/rgsa/" -basedir="${CODE_DIR}/src/main/java/gov/in/rgsa/controller" -t="${CODE_DIR}/src/main/webapp/WEB-INF/configs/Owasp.CsrfGuard.properties.template" -o="${CODE_DIR}/src/main/webapp/WEB-INF/configs/Owasp.CsrfGuard.properties" 2>&1 > /dev/null
  
  # Windows (Change path as per system also cd to root dir i.e. rgsa)
  
  java -jar "D:\annoter-tool.jar" -tool=owasp -mount="/rgsa/" -basedir="src\main\java\gov\in\rgsa\controller" -t="src\main\webapp\WEB-INF\configs\Owasp.CsrfGuard.properties.template" -o="src\main\webapp\WEB-INF\configs\Owasp.CsrfGuard.properties" > nul 2>&1
  
  ```

  

- [ ] To compile and run the code issue following command from root directory (rgsa):
  `mvn spring-boot:run`

> Currently you can copy *Owasp.CsrfGuard.properties* from svn trunk. Later an autobuilder will be integrated to avoid manual updating of *Owasp.CsrfGuard.properties* file. 

- [ ] Use `mvn package` to create war file. To avoid testing use `mvn clean package -DskipTests`.