package {{ cookiecutter.package_name }};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class {{ cookiecutter.project_name }}Application {

	public static void main(String[] args) {
		SpringApplication.run({{ cookiecutter.project_name }}Application.class, args);
	}

}
