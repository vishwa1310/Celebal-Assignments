# Azure Data Factory Assignment

## Introduction

In this assignment, I explored the basic functionalities of Azure Data Factory (ADF) and Azure Blob Storage. The objective was to create a data pipeline that reads a CSV file from Blob Storage, checks its metadata, and copies the file to another location successfully.

---

## Task 1: Resource Group Creation

I started by creating a Resource Group in Azure to organize all the resources required for this assignment. This helped me manage the storage account and data factory within a single environment.

---

## Task 2: Storage Account and Blob Container

A Storage Account was created in Azure, followed by a Blob Container named **data**. After creating the container, I uploaded the source file:

**Sample - Superstore.csv**

This file was used as the input for the pipeline.

---

## Task 3: Azure Data Factory Basics

### Creating a Linked Service

A Linked Service was configured to establish a connection between Azure Data Factory and Azure Blob Storage.

### Creating Datasets

Two datasets were created:

* **InputDataset** – Source dataset
* **OutputDataset** – Destination dataset

These datasets were used to define the source and destination locations for the data movement process.

### Get Metadata Activity

A Get Metadata activity was added to the pipeline to verify the existence of the source file before copying it. The activity was configured to check the **Exists** property of the file.

---

## Task 4: Pipeline Development

A pipeline named **pipeline1** was created.

The workflow of the pipeline is:

Get Metadata → Copy Data

The source dataset points to the uploaded CSV file, while the destination dataset stores the copied file in the same container with a different name.

---

## Task 5: Pipeline Execution

The pipeline was executed using the **Debug** option in Azure Data Factory.

After execution, both activities completed successfully:

* Get Metadata
* Copy Data

The pipeline status was displayed as **Succeeded**.

---

## Task 6: IAM Role Assignments

To provide the necessary permissions, the following roles were assigned:

* Reader
* Contributor
* Storage Blob Data Contributor

These roles ensured that Azure Data Factory could access and manage the storage resources required for the assignment.

---

## Mini Project

### Objective

Build a complete Azure Data Factory pipeline that reads a CSV file from Azure Blob Storage, validates its metadata, and copies it to a new destination file.

### Implementation

1. Uploaded the source CSV file to Blob Storage.
2. Created a Linked Service to connect ADF with Blob Storage.
3. Created source and destination datasets.
4. Added a Get Metadata activity to validate the source file.
5. Added a Copy Data activity to copy the file.
6. Executed the pipeline and verified the results.

### Output

The pipeline executed successfully, and the destination file was created in Blob Storage. Metadata validation was also completed successfully before the copy operation.

---

## Conclusion

Through this assignment, I gained hands-on experience with Azure Data Factory, Blob Storage, datasets, linked services, metadata validation, pipeline creation, and role-based access control. The project helped me understand how data can be moved and managed efficiently using Azure cloud services.
