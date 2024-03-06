# Art for Welfare - Database Design (MySQL)
The purpose of this database is to facilitate the Art for Welfare project, serving as a robust system that connects artistic expression with social impact.
---
1. **Entities:**
   1. **NGO**: Represents non-profit organizations participating in the project.
   2. **Artists**: Individuals contributing artworks to the platform.
   3. **Artworks**: Creative outputs of artists showcased for purchase.
   4. **Customers**: Individuals interested in purchasing artworks.
   5. **Transactions**: Captures orders, donations, and financial aspects.
---
2. **Database Tables:**
   ___
   1. **NGO**
      * **Columns**:
        
        ngoid_pk (INT PRIMARY KEY): Unique identifier for the NGO.
        
        name (VARCHAR(255)): Name of the NGO.
        
        email (VARCHAR(255)): Email address of the NGO.
        
        goal (TEXT): Description of the NGO's mission.
        
        address (TEXT): Physical address of the NGO.
        
        total_donation (DECIMAL(10,2)): Total amount of donations received.
        

      * **Constraints**:
        
        PRIMARY KEY (ngoid_pk): Ensures unique identification of each NGO.
   ___  
   2. **Artists**
      * **Columns**:

        artist_id (INT PRIMARY KEY): Unique identifier for the artist.

        name (VARCHAR(255)): Name of the artist.

        contact_info (TEXT): Contact information for the artist (e.g., email, phone number).
      * **Constraints**:

        PRIMARY KEY (artist_id): Ensures unique identification of each artist.
    ___
    3. **Artworks**
       * **Columns**:

         artwork_id (INT PRIMARY KEY): Unique identifier for the artwork.

         title (VARCHAR(255)): Title of the artwork.

         description (TEXT): Description of the artwork.

         price (DECIMAL(10,2)): Price of the artwork (optional).

         artist_id (INT FOREIGN KEY REFERENCES Artists(artist_id)): References the artist who created the artwork.

       * **Constraints**:

         PRIMARY KEY (artwork_id): Ensures unique identification of each artwork.

         FOREIGN KEY (artist_id) REFERENCES Artists(artist_id): Maintains data integrity by linking artworks to their respective artists.

         ON DELETE SET NULL: Sets the artist_id to NULL if the referenced artist is deleted, preserving historical data.
    ___    
    4. **Customers**
       * **Columns**:

         customer_id (INT PRIMARY KEY): Unique identifier for the customer.

         name (VARCHAR(255)): Name of the customer.

         email (VARCHAR(255)): Email address of the customer.

       * **Constraints**:

         PRIMARY KEY (customer_id): Ensures unique identification of each customer.
    ___
    5. **Transactions**
       * **Columns**:

         transaction_id (INT PRIMARY KEY): Unique identifier for the transaction.

         customer_id (INT FOREIGN KEY REFERENCES Customers(customer_id)): References the customer involved in the transaction.

         artwork_id (INT FOREIGN KEY REFERENCES Artworks(artwork_id)): References the artwork involved in the transaction.

         ngo_id (INT FOREIGN KEY REFERENCES NGOs(ngoid_pk)): References the NGO benefitting from the transaction.

         transaction_date (DATETIME): Date and time of the transaction.

         transaction_type (ENUM('order', 'donation')): Type of transaction (order or donation).

         amount (DECIMAL(10,2)): Amount involved in the transaction.

       * **Constraints**:

         PRIMARY KEY (transaction_id): Ensures unique identification of each transaction.

         FOREIGN KEY (customer_id) REFERENCES Customers(customer_id): Links transactions to the involved customers.

         FOREIGN KEY (artwork_id) REFERENCES Artworks(artwork_id): Links transactions to the purchased or donated artworks.

         FOREIGN KEY (ngo_id) REFERENCES NGOs(ngoid_pk): Links transactions to the beneficiary NGOs.
    ___
    6. **PL Query**

       * **Triggers**:

         AT_INSERT: AFTER INSERT ON transactions

         This trigger could be used to perform actions after a new transaction is inserted, such as updating the total_donation for the associated NGO.

       * **Stored Procedures:**
         
         unavailable_artworks() - This procedure could potentially retrieve a list of artworks that are not available for purchase (e.g., already sold).

         available_artworks()

         add_transaction(customer_id int, artwork_id int, ngo_id int)

       * **Stored Functions:**

         iscustomer_id_present(customer_id int)

         isngo_id_present(ngo_id int)

         isartwork_id_present(artwork_id int)
