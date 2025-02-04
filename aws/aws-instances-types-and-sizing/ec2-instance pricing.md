
---

### **General Purpose Instances (T, M, A Series)**
- **Description:** Balanced CPU and memory resources, suitable for a variety of workloads.
- **Use Cases:** Web applications, development environments, small databases.

| **Instance Type** | **Plan**     | **Per Minute (INR)** | **Per Hour (INR)** | **Per Month (INR)** | **Per Year (INR)** |
|------------------|-------------|---------------------|-------------------|-------------------|------------------|
| t3.micro         | On-Demand   | ₹0.014          | ₹0.86       | ₹627.80      | ₹7,539.84   |
|                  | Reserved    | ₹0.010          | ₹0.60       | ₹438.00      | ₹5,256.00   |
|                  | Spot        | ₹0.007          | ₹0.40       | ₹292.00      | ₹3,504.00   |

**Run Notes:**
- Ideal for applications with moderate and consistent workloads.
- Use t3.micro for cost-effective web hosting.
- Monitor CPU credits if burstable performance is required.

---

### **Compute Optimized Instances (C Series)**
- **Description:** High compute performance for compute-intensive application.
- **Use Cases:** Batch processing, gaming servers, scientific modeling.

| **Instance Type** | **Plan**     | **Per Minute (INR)** | **Per Hour (INR)** | **Per Month (INR)** | **Per Year (INR)** |
|------------------|-------------|---------------------|-------------------|-------------------|------------------|
| c5.large         | On-Demand   | ₹0.144         | ₹8.66       | ₹6,321.80    | ₹75,981.60  |
|                  | Reserved    | ₹0.085         | ₹5.09       | ₹3,715.70    | ₹44,227.80  |
|                  | Spot        | ₹0.041         | ₹2.48       | ₹1,810.40    | ₹21,724.80  |

**Run Notes:**
- Suitable for applications requiring high-performance computing.
- Use c5.large for large-scale data processing tasks.
- Monitor CPU utilization to optimize instance performance.

---

### **Memory Optimized Instances (R, X Series)**
- **Description:** High memory instances for memory-intensive workloads.
- **Use Cases:** In-memory databases, real-time big data analytics, SAP applications.

| **Instance Type** | **Plan**     | **Per Minute (INR)** | **Per Hour (INR)** | **Per Month (INR)** | **Per Year (INR)** |
|------------------|-------------|---------------------|-------------------|-------------------|------------------|
| r5.4xlarge       | On-Demand   | ₹1.364         | ₹81.84      | ₹59,743.20   | ₹715,046.40 |
|                  | Reserved    | ₹0.845         | ₹50.74      | ₹37,540.20   | ₹450,602.40 |
|                  | Spot        | ₹0.308         | ₹18.51      | ₹13,522.30   | ₹162,877.20 |

**Run Notes:**
- Ideal for data-heavy applications and enterprise workloads.
- Use r5.4xlarge for SAP deployments.
- Monitor memory usage closely to prevent performance bottlenecks.

---

### **Storage Optimized Instances (I, D Series)**
- **Description:** Optimized for high read/write storage performance.
- **Use Cases:** NoSQL databases, data warehousing, large-scale analytics.

| **Instance Type** | **Plan**     | **Per Minute (INR)** | **Per Hour (INR)** | **Per Month (INR)** | **Per Year (INR)** |
|------------------|-------------|---------------------|-------------------|-------------------|------------------|
| i3.16xlarge      | On-Demand   | Custom Pricing       | Custom Pricing    | Custom Pricing     | Custom Pricing   |

**Run Notes:**
- Best suited for workloads requiring high IOPS.
- Use i3 instances for real-time data analytics.
- Monitor storage throughput and I/O performance.

---

### **Accelerated Computing Instances (P, G Series)**
- **Description:** GPU-based instances optimized for machine learning and AI workloads.
- **Use Cases:** AI model training, high-performance computing, deep learning.

| **Instance Type** | **Plan**     | **Per Minute (INR)** | **Per Hour (INR)** | **Per Month (INR)** | **Per Year (INR)** |
|------------------|-------------|---------------------|-------------------|-------------------|------------------|
| p4d.24xlarge     | On-Demand   | Custom Pricing       | Custom Pricing    | Custom Pricing     | Custom Pricing   |

**Run Notes:**
- Suitable for complex AI/ML tasks.
- Use p4d instances for efficient AI training.
- Monitor GPU utilization to optimize costs.

---

### **General Recommendations:**
1. **Monitoring:** Use AWS CloudWatch to track instance performance metrics such as CPU, memory, disk I/O, and network traffic.
2. **Cost Optimization:** Utilize Spot instances for non-critical workloads to reduce costs.
3. **Scaling:** Implement Auto Scaling to handle traffic fluctuations efficiently.
4. **Right-Sizing:** Periodically review instance usage to ensure optimal instance selection.

