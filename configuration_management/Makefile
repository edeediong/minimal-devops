run-terraform:
	@terraform init
	@terraform apply -auto-approve

run-ansible:
	@ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory appsilon.yml

generate-inventory:
	@echo "[servers]" > inventory
	@terraform output -raw instance_ip | awk '{print $$0 " ansible_user=ubuntu"}' >> inventory

automate: run-terraform generate-inventory run-ansible

destroy:
	@terraform destroy -auto-approve
	rm -r inventory
