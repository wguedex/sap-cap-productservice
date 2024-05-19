# SAP CAP Product Service

Welcome to the SAP CAP Product Service repository. This project is a reference implementation using SAP Cloud Application Programming (CAP) model.

## Project Structure

The repository contains the following folders and files:

| File or Folder | Purpose |
| -------------- | ------- |
| `app/`         | Contains content for UI frontends. |
| `db/`          | Contains domain models and data. |
| `srv/`         | Contains service models and code. |
| `package.json` | Contains project metadata and configuration. |
| `readme.md`    | This getting started guide. |

## Getting Started

To set up and run the project locally, follow these steps:

1. **Download or Clone the Repository**
    ```bash
    git clone https://github.com/wguedex/sap-cap-productservice.git
    cd sap-cap-productservice
    ```

2. **Install Dependencies**
    ```bash
    npm install
    ```

3. **Run the Application**
    - Open a new terminal and run:
      ```bash
      cds watch
      ```
    - Alternatively, in VS Code, choose: **Terminal** > **Run Task** > **cds watch**

4. **Start Adding Content**
    - You can start by adding a new schema file, for example: `db/schema.cds`.

## Project Description

This project includes the following features and functionalities:

1. **Project Initialization**
   - Initial commit to start the project.
   - Created persistent entities and loaded mock data.

2. **Data and Service Modeling**
   - **Entities**:
     - Defined various domain entities including `Products`, `Orders`, and `Customers`.
     - Added facets, data points, and selection fields to enrich the data models.
     - Included types defined by reference and user-defined types to extend flexibility.
   - **Services**:
     - Created service definitions to expose the entities.
     - Integrated external services to enhance functionality.
     - Implemented CRUD operations for entities.
     - Added virtual elements to the services for dynamic data handling.
     - Included restrictions and assigned default values to ensure data integrity.

3. **User Interface and Fiori Elements**
   - Added an application with Fiori Elements for a standardized and efficient UI.
   - Included capabilities, criticality, and communication contacts for enhanced user interaction.

4. **Improvements and Additional Features**
   - Added pictures, search helps, and other visual elements to improve usability.
   - Enhanced system capabilities by integrating data points into the rating column and adding restrictions and default values.

## Database Setup

The `db/` folder contains scripts for setting up the database schema. You can find multiple DDL scripts (DDL_Script1 to DDL_Script8) that define various parts of the database.

## Development

For development, you can use the VS Code setup provided in the `.vscode` folder.

## Configuration

Project-specific configurations are stored in the following files:
- `.cdsrc.json`
- `.eslintrc`
- `package.json`

## Learn More

To learn more about the SAP CAP model, visit the [official documentation](https://cap.cloud.sap/docs/get-started/).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
