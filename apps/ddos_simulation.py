import streamlit as st
import random
import time

# Function to simulate network traffic and detect DDoS
def simulate_ddos(threshold_limit, time_window, monitoring_period, regular_requests, attack_requests):
    regular_ips = [f"192.168.1.{i}" for i in range(2, 255)]
    attacker_ip = "192.168.1.1"

    # Generate network traffic
    network_traffic = []
    for _ in range(regular_requests):
        network_traffic.append({
            'ip_address': random.choice(regular_ips),
            'timestamp': time.time() + random.randint(1, monitoring_period)
        })

    # Inject attack traffic
    for _ in range(attack_requests):
        network_traffic.append({
            'ip_address': attacker_ip,
            'timestamp': time.time() + random.randint(1, monitoring_period)
        })

    # Shuffle the traffic
    random.shuffle(network_traffic)

    # Detection logic
    start_time = time.time()
    ip_request_count = {}
    attack_detected = []

    for request in network_traffic:
        current_time = time.time()
        if current_time - start_time > monitoring_period:
            break

        ip_address = request['ip_address']
        timestamp = request['timestamp']
        ip_request_count[ip_address] = ip_request_count.get(ip_address, 0) + 1

        if ip_request_count[ip_address] == threshold_limit:
            time_first_request = min(req['timestamp'] for req in network_traffic if req['ip_address'] == ip_address)
            if current_time - time_first_request <= time_window:
                attack_detected.append(ip_address)

        ip_request_count = {ip: count for ip, count in ip_request_count.items() if current_time - timestamp <= time_window}

    return attack_detected

# Streamlit UI
st.title('DDoS Attack Simulation and Detection')

# Sidebar for simulation configuration
st.sidebar.header('Simulation Configuration')
threshold_limit = st.sidebar.number_input('Threshold Limit', min_value=10, value=100)
time_window = st.sidebar.number_input('Time Window (seconds)', min_value=10, value=60)
monitoring_period = st.sidebar.number_input('Monitoring Period (seconds)', min_value=60, value=300)
regular_requests = st.sidebar.number_input('Number of Regular Requests', min_value=0, value=500)
attack_requests = st.sidebar.number_input('Number of Attack Requests', min_value=0, value=200)

# Sidebar for creator information
st.sidebar.header('About This Application')
st.sidebar.markdown('**Created by:** [Fadel M. Megahed](https://miamioh.edu/fsb/directory/?up=/directory/megahefm)')
st.sidebar.markdown('**Version:** 1.0')
st.sidebar.markdown('**Date:** January 30, 2024')
st.sidebar.text('This application simulates network traffic to detect potential DDoS attacks, allowing users to interactively adjust simulation parameters.')

# Button to run simulation
if st.button('Run Simulation'):
    with st.spinner('Simulating network traffic and detecting DDoS attacks...'):
        detected_attacks = simulate_ddos(threshold_limit, time_window, monitoring_period, regular_requests, attack_requests)
        if detected_attacks:
            st.success(f"DDoS attack detected from the following IP(s): {', '.join(detected_attacks)}")
        else:
            st.info("No DDoS attack detected.")
