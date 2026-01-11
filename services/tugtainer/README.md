
<div align="center">
	<h1>Tugtainer</h1>
	<a href="https://github.com/Quenary/tugtainer"><img src="https://img.shields.io/github/v/release/Quenary/tugtainer" alt="Release"></a>
	<a href="https://github.com/Quenary/tugtainer"><img src="https://img.shields.io/github/license/Quenary/tugtainer" alt="License"></a>
</div>


Tugtainer is a self-hosted application for automating Docker container updates, featuring a modern web UI. It is a feature-rich alternative to Watchtower, but not a full replacement for general Docker management tools like Portainer.

**Key features:**
- Web UI with authentication
- Multi-host support (via agent)
- Crontab scheduling for update checks
- Per-container config (check only or auto-update)
- Manual and automatic update options
- Image pruning
- Linked containers and private registries support
- Broad notification integrations
- Socket proxy support

**Usage:**
- Deploy using the provided `docker-compose.app.yml` or Docker commands
- Access the web UI at [http://localhost:9412](http://localhost:9412) or your configured port
- Configure update policies and credentials in the `.env` file
- For multi-host, deploy the Tugtainer Agent on remote hosts

**Configuration:**
- See `.env.tugtainer.example` for options


## Additional Information
- [official repository and documentation](https://github.com/Quenary/tugtainer)


