# DeskspaceBooking
<img width="917" height="634" alt="image" src="https://github.com/user-attachments/assets/49b3d359-c903-4877-9a23-a4066dc12b11" />
Here I present and evaluate the original database architecture designed for the client project, based on a detailed ER diagram comprising 7 tables. The design prioritises simplicity, maintainability, and scalability while fully meeting the client’s requirements.

- The Customer table stores customer details such as name, customer type, and desk ID, using a unique customer ID as the primary key. It links to the Customer Type table via a one-to-many relationship, allowing admins to assign membership types (e.g., full-time, part-time) with associated pricing. This structure supports business flexibility—Jane can easily introduce new membership options or seasonal discounts to attract more customers. The inclusion of desk ID accommodates full-time members with reserved desks.

- The Booking table records desk bookings, linking customers to desks with booking dates. It connects to both the Customer and Desk tables through one-to-many relationships, reflecting that one customer can make multiple bookings and one desk can be booked multiple times. Similarly, a separate Meeting Room Booking table handles hourly room reservations, including start and end times, and links to the Meeting Room table. Separating desk and meeting room bookings improves clarity and system simplicity.

- The Site table holds site information—name, address, and capacity—and is central to the design. It connects to both the Desk and Meeting Room tables via one-to-many relationships, as each site hosts multiple desks and rooms. This supports current operations across multiple locations and allows easy expansion—Jane can add new sites, desks, or meeting rooms as the business grows.

- The Desk table includes desk type (e.g., reserved or open) and is tied to a specific site, ensuring accurate resource tracking. All relationships are carefully defined to reflect real-world usage and prevent data redundancy.

- This database design fulfils all functional requirements from the project brief and supports future growth. It enables Jane to efficiently manage customers, bookings, sites, and membership options while maintaining flexibility for promotions, pricing changes, and business expansion. Overall, the system is scalable, adaptable, and aligned with the client’s operational and strategic goals.
